package Action.adminAction.user;

import Action.Action;
import mybatis.Service.FactoryService;
import mybatis.dao.PaymentDAO;
import mybatis.vo.PaymentVO;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 비회원의 예매/구매 내역을 조회하는 Action 클래스
 */
public class NmemReservationCheckAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 1. JSP 폼에서 넘어온 파라미터 받기
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String orderId = request.getParameter("orderId");
        String password = request.getParameter("password");

        // 2. 받은 파라미터들을 Map에 저장하여 DAO에 전달
        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        params.put("phone", phone);
        params.put("orderId", orderId);
        params.put("password", password);

        SqlSession ss = FactoryService.getFactory().openSession();

        // 3. DAO를 호출하여 DB에서 일치하는 내역 조회
        PaymentVO history = PaymentDAO.getNmemPaymentHistory(params, ss);
        ss.close();

        // 4. 조회 결과를 request 객체에 저장
        request.setAttribute("history", history);

        // 5. 결과를 표시할 JSP 페이지로 포워딩
        return "/mypage/nmemReservationHistory.jsp";
    }
}