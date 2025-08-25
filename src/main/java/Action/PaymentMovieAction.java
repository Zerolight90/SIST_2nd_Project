package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.dao.PriceDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.NmemVO;
import mybatis.vo.PriceVO;
import mybatis.vo.ReservationVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID; // ✅ 고유성 보장을 위해 UUID 사용 권장

public class PaymentMovieAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        NmemVO nmemvo = (NmemVO) session.getAttribute("nmemvo");

        // ✅ 비정상 접근 방어: 회원, 비회원 정보 둘 다 없으면 에러 페이지로
        if (mvo == null && nmemvo == null) {
            request.setAttribute("errorMsg", "로그인 정보가 없습니다. 다시 시도해주세요.");
            return "error.jsp";
        }

        try {
            // --- 1. seat.jsp에서 정보 수신 ---
            String movieTitle = request.getParameter("movieTitle");
            String posterUrl = request.getParameter("posterUrl");
            String theaterName = request.getParameter("theaterName");
            String screenName = request.getParameter("screenName");
            String startTimeStr = request.getParameter("startTime");
            String seatInfo = request.getParameter("seatInfo");

            int adultCount = parseInt(request.getParameter("adult"));
            int teenCount = parseInt(request.getParameter("teen"));
            int seniorCount = parseInt(request.getParameter("senior"));
            int specialCount = parseInt(request.getParameter("special"));
            int totalPersons = adultCount + teenCount + seniorCount + specialCount;

            String timeTableIdxStr = request.getParameter("timeTableIdx");
            String tIdxStr = request.getParameter("tIdx");
            String sIdxStr = request.getParameter("sIdx");
            String priceIdxStr = request.getParameter("priceIdx");

            // --- 2. 가격 계산 ---
            PriceVO price = PriceDAO.getPrice();
            int normalPrice = Integer.parseInt(price.getNormal());
            int teenPrice = Integer.parseInt(price.getTeen());
            int elderPrice = Integer.parseInt(price.getElder());
            int dayDiscount = Integer.parseInt(price.getDay());
            int weekPrice = Integer.parseInt(price.getWeek());
            int morningDiscountValue = Integer.parseInt(price.getMorning());

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date startTime = sdf.parse(startTimeStr);
            Calendar cal = Calendar.getInstance();
            cal.setTime(startTime);
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            int hour = cal.get(Calendar.HOUR_OF_DAY);

            int baseAdultPrice = (dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY)
                    ? weekPrice : (normalPrice - dayDiscount);

            int subtotal = (adultCount * baseAdultPrice)
                    + (teenCount * teenPrice)
                    + (seniorCount * elderPrice)
                    + (specialCount * elderPrice);

            // 조조 할인
            String timeDiscountName = "";
            int timeDiscountAmount = 0;
            if (hour < 9) {
                timeDiscountName = "조조할인";
                timeDiscountAmount = morningDiscountValue * totalPersons;
            }

            // 좌석 할인
            int seatDiscountAmount = 0;
            if (seatInfo != null && !seatInfo.isEmpty()) {
                String[] seats = seatInfo.split(",");
                for (String seat : seats) {
                    if (seat.trim().startsWith("A")) {
                        seatDiscountAmount += 1000;
                    }
                }
            }

            int finalAmount = subtotal - timeDiscountAmount - seatDiscountAmount;

            // --- 3. ReservationVO 생성 ---
            ReservationVO reservation = new ReservationVO();
            if (timeTableIdxStr != null) reservation.setTimeTableIdx(Long.parseLong(timeTableIdxStr));
            if (tIdxStr != null) reservation.settIdx(Long.parseLong(tIdxStr));
            if (sIdxStr != null) reservation.setsIdx(Long.parseLong(sIdxStr));
            if (priceIdxStr != null) reservation.setPriceIdx(Long.parseLong(priceIdxStr));
            reservation.setTitle(movieTitle);
            reservation.setPosterUrl(posterUrl);
            reservation.setTheaterName(theaterName);
            reservation.setScreenName(screenName);
            reservation.setStartTime(startTimeStr);
            reservation.setSeatInfo(seatInfo);
            reservation.setFinalAmount(finalAmount);
            reservation.setAdultCount(adultCount);
            reservation.setTeenCount(teenCount);
            reservation.setSeniorCount(seniorCount);
            reservation.setSpecialCount(specialCount);
            reservation.setTimeDiscountName(timeDiscountName);
            reservation.setTimeDiscountAmount(timeDiscountAmount);
            reservation.setSeatDiscountAmount(seatDiscountAmount);

            // --- 4. orderId + 결제정보 세션에 저장 ---
            // ✅ currentTimeMillis 대신 UUID로 고유성을 더 확실하게 보장
            String orderId = "SIST_MOVIE_" + UUID.randomUUID().toString().replace("-", "");

            Map<String, Object> paymentContext = new HashMap<>();
            paymentContext.put("paidItem", reservation);
            paymentContext.put("mvo", mvo);
            paymentContext.put("nmemvo", nmemvo);
            session.setAttribute(orderId, paymentContext);

            // --- 5. 결제 페이지로 전달할 정보 설정 ---
            request.setAttribute("orderId", orderId);
            request.setAttribute("paymentType", "paymentMovie");
            request.setAttribute("reservationInfo", reservation);
            request.setAttribute("price", price);
            request.setAttribute("finalAmount", finalAmount);

            // ✅ 회원/비회원 분기 처리 로직 수정
            if (mvo != null) {
                // 회원 처리
                request.setAttribute("isGuest", false);
                String userIdx = mvo.getUserIdx();
                List<MyCouponVO> couponList = CouponDAO.getAvailableMovieCoupons(Long.parseLong(userIdx));

                // ✅ DB 중복 조회 제거, 세션에 있는 mvo를 그대로 사용
                request.setAttribute("memberInfo", mvo);
                request.setAttribute("couponList", couponList);

                // ✅ payment.jsp에서 비회원 정보가 null이 되도록 명시적으로 설정
                request.setAttribute("nmemInfoForPayment", null);

            } else { // nmemvo는 맨 위에서 null이 아님을 확인했으므로 else로 처리 가능
                // 비회원 처리
                request.setAttribute("isGuest", true);

                // ✅ 비회원 정보를 payment.jsp에서 사용할 수 있도록 request에 저장
                request.setAttribute("nmemInfoForPayment", nmemvo);

                // ✅ 회원이 아니므로 쿠폰과 멤버 정보는 null 또는 빈 값으로 설정
                request.setAttribute("couponList", null);
                request.setAttribute("memberInfo", null);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "요청 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "error.jsp";
        }

        return "payment.jsp";
    }

    private int parseInt(String val) {
        if (val == null || val.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(val.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}