package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemVO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.ReservationVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class PaymentMovieAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // [버그 추적] execute 메소드 실행 시작
        System.out.println("\n--- PaymentMovieAction 시작 ---");

        // 인코딩 설정 (POST 방식 파라미터 한글 깨짐 방지)
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        MemVO mvo = (MemVO) session.getAttribute("loginUser"); // [수정]
        long userIdx = (mvo == null) ? 1L : mvo.getUserIdx();

        try {
            String movieTitle = request.getParameter("movieTitle");
            String posterUrl = request.getParameter("posterUrl");
            String theaterName = request.getParameter("theaterName");
            String screenName = request.getParameter("screenName");
            String startTime = request.getParameter("startTime");
            String seatInfo = request.getParameter("seatInfo");
            String amountStr = request.getParameter("amount");
            // 필수 파라미터가 없는 경우 에러 처리
            if (movieTitle == null || theaterName == null || amountStr == null) {
                request.setAttribute("errorMsg", "필수 예매 정보가 누락되었습니다.");
                return "error.jsp";
            }

            // 전달받은 파라미터로 ReservationVO 객체를 직접 생성
            ReservationVO reservation = new ReservationVO();
            reservation.setTitle(movieTitle);
            reservation.setPosterUrl(posterUrl);
            reservation.setTheaterName(theaterName);
            reservation.setScreenName(screenName);
            reservation.setStartTime(startTime);
            reservation.setSeatInfo(seatInfo);
            reservation.setFinalAmount(Integer.parseInt(amountStr));

            // 사용 가능한 쿠폰 목록 조회
            List<MyCouponVO> couponList = CouponDAO.getAvailableMovieCoupons(userIdx);

            // '무료' 쿠폰 처리 로직
            for (MyCouponVO coupon : couponList) {
                if (coupon.getCouponName().contains("무료")) {
                    coupon.setCouponValue(reservation.getFinalAmount());
                }
            }

            // 사용자의 포인트 정보를 포함한 전체 회원 정보 조회
            MemVO memberInfo = MemberDAO.getMemberByIdx(userIdx); // [수정]

            // 조회된 모든 정보를 request 객체에 저장
            request.setAttribute("reservationInfo", reservation);
            request.setAttribute("couponList", couponList);
            request.setAttribute("memberInfo", memberInfo);
            request.setAttribute("paymentType", "paymentMovie");

            // 결제 승인 단계에서 사용하기 위해 예매 정보를 세션에 저장
            session.setAttribute("reservationInfoForPayment", reservation);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "결제 페이지 로딩 중 오류가 발생했습니다.");
            return "error.jsp";
        }

        return "payment.jsp";
    }
}