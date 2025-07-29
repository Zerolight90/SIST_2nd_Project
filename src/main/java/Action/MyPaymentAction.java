package Action;

import mybatis.dao.PaymentDAO;
import mybatis.vo.PaymentVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class MyPaymentAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 여기서는 특정 userIdx 없이 모든 결제 목록을 가져옵니다.
        // 실제 서비스에서는 로그인된 userIdx를 기반으로 목록을 가져와야 합니다.
        // 예: long userIdx = (long) request.getSession().getAttribute("userIdx");
        //     List<PaymentVO> paymentList = PaymentDAO.getPaymentsByUserIdx(userIdx);

        List<PaymentVO> paymentList = PaymentDAO.getAllPayments(); // 모든 결제 목록 가져오기
        if (paymentList == null) {
            System.out.println("MyPaymentAction: paymentList is NULL.");
        } else if (paymentList.isEmpty()) {
            System.out.println("MyPaymentAction: paymentList is EMPTY (size: 0).");
        } else {
            System.out.println("MyPaymentAction: paymentList size: " + paymentList.size());
            for (PaymentVO payment : paymentList) {
                System.out.println("Payment: " + payment.getOrderId() + ", Amount: " + payment.getPaymentFinal());
            }
        }
        request.setAttribute("paymentList", paymentList); // JSP로 목록 전달

        return "/jsp/myPayment.jsp"; // 결제 목록을 보여줄 JSP 페이지
    }
}