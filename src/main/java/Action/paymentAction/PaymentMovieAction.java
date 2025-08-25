package Action.paymentAction;

import Action.Action;
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

            // --- 조조 할인 ---
            String timeDiscountName = "";
            int timeDiscountAmount = 0;
            if (hour < 9) {
                timeDiscountName = "조조할인";
                timeDiscountAmount = morningDiscountValue * totalPersons;
            }

            // --- 좌석 할인 ---
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
            String orderId = "SIST_MOVIE_" + System.currentTimeMillis();

            Map<String, Object> paymentContext = new HashMap<>();
            paymentContext.put("paidItem", reservation); // 예매 정보
            paymentContext.put("mvo", mvo);              // 회원
            paymentContext.put("nmemvo", nmemvo);        // 비회원

            session.setAttribute(orderId, paymentContext); // ✅ 핵심!

            // --- 5. 결제 페이지로 전달할 정보 설정 ---
            request.setAttribute("orderId", orderId);
            request.setAttribute("paymentType", "paymentMovie");
            request.setAttribute("reservationInfo", reservation);
            request.setAttribute("price", price);
            request.setAttribute("finalAmount", finalAmount);
            request.setAttribute("isGuest", (mvo == null));

            if (mvo != null) {
                String userIdx = mvo.getUserIdx();
                List<MyCouponVO> couponList = CouponDAO.getAvailableMovieCoupons(Long.parseLong(userIdx));
                MemberVO memberInfo = MemberDAO.getMemberByIdx(Long.parseLong(userIdx));
                request.setAttribute("couponList", couponList);
                request.setAttribute("memberInfo", memberInfo);
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
