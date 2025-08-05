package Action;

import mybatis.dao.PaymentDAO;
import mybatis.vo.PaymentVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminPaymentAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        PaymentVO[] ar = PaymentDAO.getAllPayment();

        request.setAttribute("ar", ar);

        return "admin/adminPayment.jsp";
    }
}
