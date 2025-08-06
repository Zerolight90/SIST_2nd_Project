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
        // [버그 추적] 사용자 ID 확인
        System.out.println("[버그 추적] userIdx 확인됨: " + userIdx + (mvo == null ? " (임시 ID)" : " (로그인 ID)"));

        try {
            // [버그 추적] seat.jsp로부터 파라미터 수신 시작
            System.out.println("[버그 추적] 파라미터 수신 시작...");
            String movieTitle = request.getParameter("movieTitle");
            String posterUrl = request.getParameter("posterUrl");
            String theaterName = request.getParameter("theaterName");
            String screenName = request.getParameter("screenName");
            String startTime = request.getParameter("startTime");
            String seatInfo = request.getParameter("seatInfo");
            String amountStr = request.getParameter("amount");
            // [버그 추적] 수신된 파라미터 값 출력
            System.out.println("  - movieTitle: " + movieTitle);
            System.out.println("  - theaterName: " + theaterName);
            System.out.println("  - amount: " + amountStr);

            // 필수 파라미터가 없는 경우 에러 처리
            if (movieTitle == null || theaterName == null || amountStr == null) {
                // [버그 추적] 필수 파라미터 누락으로 에러 페이지 이동
                System.out.println("[버그 추적] 오류: 필수 파라미터 누락. error.jsp로 이동합니다.");
                request.setAttribute("errorMsg", "필수 예매 정보가 누락되었습니다.");
                return "error.jsp";
            }
            // [버그 추적] 필수 파라미터 검증 통과
            System.out.println("[버그 추적] 필수 파라미터 검증 완료.");

            // 전달받은 파라미터로 ReservationVO 객체를 직접 생성
            ReservationVO reservation = new ReservationVO();
            reservation.setTitle(movieTitle);
            reservation.setPosterUrl(posterUrl);
            reservation.setTheaterName(theaterName);
            reservation.setScreenName(screenName);
            reservation.setStartTime(startTime);
            reservation.setSeatInfo(seatInfo);
            reservation.setFinalAmount(Integer.parseInt(amountStr));
            // [버그 추적] ReservationVO 객체 생성 완료
            System.out.println("[버그 추적] ReservationVO 객체 생성 완료. 영화 제목: " + reservation.getTitle() + ", 금액: " + reservation.getFinalAmount());

            // 사용 가능한 쿠폰 목록 조회
            // [버그 추적] CouponDAO 호출
            System.out.println("[버그 추적] CouponDAO.getAvailableMovieCoupons(" + userIdx + ") 호출...");
            List<MyCouponVO> couponList = CouponDAO.getAvailableMovieCoupons(userIdx);
            // [버그 추적] CouponDAO 결과
            System.out.println("[버그 추적] 조회된 쿠폰 개수: " + (couponList != null ? couponList.size() : "null"));

            // '무료' 쿠폰 처리 로직
            for (MyCouponVO coupon : couponList) {
                if (coupon.getCouponName().contains("무료")) {
                    // [버그 추적] '무료' 쿠폰 처리
                    System.out.println("[버그 추적] '" + coupon.getCouponName() + "' 쿠폰 발견. 할인액을 " + reservation.getFinalAmount() + "원으로 변경합니다.");
                    coupon.setCouponValue(reservation.getFinalAmount());
                }
            }

            // 사용자의 포인트 정보를 포함한 전체 회원 정보 조회
            // [버그 추적] MemberDAO 호출
            System.out.println("[버그 추적] MemberDAO.getMemberByIdx(" + userIdx + ") 호출...");
            MemVO memberInfo = MemberDAO.getMemberByIdx(userIdx); // [수정]
            // [버그 추적] MemberDAO 결과
            System.out.println("[버그 추적] 조회된 회원 이름: " + (memberInfo != null ? memberInfo.getName() : "null") + ", 보유 포인트: " + (memberInfo != null ? memberInfo.getTotalPoints() : "null"));

            // 조회된 모든 정보를 request 객체에 저장
            request.setAttribute("reservationInfo", reservation);
            request.setAttribute("couponList", couponList);
            request.setAttribute("memberInfo", memberInfo);
            request.setAttribute("paymentType", "paymentMovie");
            // [버그 추적] request 객체에 데이터 저장 완료
            System.out.println("[버그 추적] request 객체에 'reservationInfo', 'couponList', 'memberInfo' 저장 완료.");

            // 결제 승인 단계에서 사용하기 위해 예매 정보를 세션에 저장
            session.setAttribute("reservationInfoForPayment", reservation);
            // [버그 추적] session 객체에 데이터 저장 완료
            System.out.println("[버그 추적] session 객체에 'reservationInfoForPayment' 저장 완료.");

        } catch (Exception e) {
            // [버그 추적] 예외(Exception) 발생
            System.out.println("[버그 추적] CRITICAL: try-catch 블록에서 예외 발생!");
            e.printStackTrace();
            request.setAttribute("errorMsg", "결제 페이지 로딩 중 오류가 발생했습니다.");
            return "error.jsp";
        }

        // [버그 추적] 최종적으로 payment.jsp로 forward
        System.out.println("[버그 추적] 모든 작업 완료. payment.jsp로 forward합니다.");
        System.out.println("--- PaymentMovieAction 종료 ---\n");
        return "payment.jsp";
    }
}