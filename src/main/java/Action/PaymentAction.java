package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 수정 필요: 실제로는 좌석 선택 페이지에서 파라미터를 받고, DB에서 조회해야 함
        // String scheduleId = request.getParameter("schedule_id");
        // UserVO uvo = (UserVO) request.getSession().getAttribute("loginUser");
        // MovieVO mvo = MovieDAO.findBySchedule(scheduleId);

        // [테스트용 임시 데이터]
        String movieTitle = "존나싼영화";
        int finalAmount = 1000; // 테스트를 위해 결제 금액을 1000원으로 고정
        String customerName = "honggildong"; // 실제로는 uvo.getName();
        long userIdx = 1; // 실제로는 uvo.getUserIdx();

        // JSP로 데이터를 넘기기 위해 request에 저장
        request.setAttribute("movieTitle", movieTitle);
        request.setAttribute("finalAmount", finalAmount);
        request.setAttribute("customerName", customerName);
        request.setAttribute("userIdx", userIdx);

        return "/jsp/payment.jsp";
    }
}