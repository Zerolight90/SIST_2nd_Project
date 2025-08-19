package Action;

import mybatis.dao.PaymentDAO;
import mybatis.vo.PaymentVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminPaymentSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> map = new HashMap<>();
        map.put("datepicker", request.getParameter("datepicker"));
        map.put("payment_status", request.getParameter("payment_status"));
        map.put("payment_type", request.getParameter("payment_type"));
        map.put("payment_field", request.getParameter("payment_field"));
        map.put("payment_keyword", request.getParameter("payment_keyword"));

        PaymentVO[] ar = PaymentDAO.adminSearchPayment(map);

        request.setAttribute("ar", ar);

        return "admin/adminPaymentSearch.jsp";
    }
}
