package Action;

import mybatis.dao.*;
import mybatis.vo.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

public class PaymentMovieAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception e) { e.printStackTrace(); }

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        NmemVO nmemvo = (NmemVO) session.getAttribute("nmemvo");

        try {
            // --- 1. seat.jsp에서 원재료 정보 수신 ---
            String movieTitle = request.getParameter("movieTitle");
            String posterUrl = request.getParameter("posterUrl");
            String theaterName = request.getParameter("theaterName");
            String screenName = request.getParameter("screenName");
            String startTimeStr = request.getParameter("startTime");
            String seatInfo = request.getParameter("seatInfo");

            String adultCountStr = request.getParameter("adult");
            String teenCountStr = request.getParameter("teen");
            String seniorCountStr = request.getParameter("senior");
            String specialCountStr = request.getParameter("special");

            String timeTableIdxStr = request.getParameter("timeTableIdx");
            String tIdxStr = request.getParameter("tIdx");
            String sIdxStr = request.getParameter("sIdx");
            String priceIdxStr = request.getParameter("priceIdx");

            int adultCount = (adultCountStr == null || adultCountStr.isEmpty()) ? 0 : Integer.parseInt(adultCountStr);
            int teenCount = (teenCountStr == null || teenCountStr.isEmpty()) ? 0 : Integer.parseInt(teenCountStr);
            int seniorCount = (seniorCountStr == null || seniorCountStr.isEmpty()) ? 0 : Integer.parseInt(seniorCountStr);
            int specialCount = (specialCountStr == null || specialCountStr.isEmpty()) ? 0 : Integer.parseInt(specialCountStr);
            int totalPersons = adultCount + teenCount + seniorCount + specialCount;

            // --- 2. 서버에서 가격 및 할인 계산 ---
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

            int baseAdultPrice;
            if (dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY) {
                baseAdultPrice = weekPrice;
            } else {
                baseAdultPrice = normalPrice - dayDiscount;
            }

            int subtotal = (adultCount * baseAdultPrice) + (teenCount * teenPrice) +
                    (seniorCount * elderPrice) + (specialCount * elderPrice);

            String timeDiscountName = "";
            int timeDiscountAmount = 0;
            if (hour < 9) {
                timeDiscountName = "조조할인";
                timeDiscountAmount = morningDiscountValue * totalPersons;
            }

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

            // --- 3. 결과를 ReservationVO에 담기 ---
            ReservationVO reservation = new ReservationVO();
            if(timeTableIdxStr != null) reservation.setTimeTableIdx(Long.parseLong(timeTableIdxStr));
            if(tIdxStr != null) reservation.settIdx(Long.parseLong(tIdxStr));
            if(sIdxStr != null) reservation.setsIdx(Long.parseLong(sIdxStr));
            if(priceIdxStr != null) reservation.setPriceIdx(Long.parseLong(priceIdxStr));

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

            // 1. 고유한 주문번호(orderId) 생성
            String orderId = "SIST_MOVIE_" + System.currentTimeMillis();

            // 2. 결제에 필요한 정보들을 Map에 한 번에 담기
            Map<String, Object> paymentContext = new HashMap<>();
            paymentContext.put("paidItem", reservation); // 결제할 항목
            paymentContext.put("mvo", mvo);             // 회원 정보 (비회원인 경우 null)
            paymentContext.put("nmemvo", nmemvo);         // 비회원 정보 (회원인 경우 null)

            // 3. orderId를 key로 사용하여 세션에 저장
            session.setAttribute(orderId, paymentContext);

            // 4. JSP로 orderId 전달
            request.setAttribute("orderId", orderId);
            // ★★★★★★★★★★★★★★★★★★★★★


            // --- 4. 회원/비회원 처리 및 JSP로 정보 전달 ---
            if (mvo != null) {
                String userIdx = mvo.getUserIdx();
                List<MyCouponVO> couponList = CouponDAO.getAvailableMovieCoupons(Long.parseLong(userIdx));
                MemberVO memberInfo = MemberDAO.getMemberByIdx(Long.parseLong(userIdx));
                request.setAttribute("couponList", couponList);
                request.setAttribute("memberInfo", memberInfo);
                request.setAttribute("isGuest", false);
            } else {
                request.setAttribute("isGuest", true);
            }

            request.setAttribute("price", price);
            request.setAttribute("reservationInfo", reservation);
            request.setAttribute("paymentType", "paymentMovie");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "요청 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "error.jsp";
        }

        return "payment.jsp";
    }
}