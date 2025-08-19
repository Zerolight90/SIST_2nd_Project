package Action;

import mybatis.dao.MyPaymentHistoryDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyPaymentHistoryVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// MyReservationAction -> MyPaymentHistoryAction 으로 이름 변경
public class MyPaymentHistoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo == null) {
            return "/mypage/myPage_reservationHistory.jsp";
        }

        Map<String, Object> params = new HashMap<>();
        params.put("userIdx", mvo.getUserIdx());

        String statusFilter = request.getParameter("statusFilter");
        String yearFilter = request.getParameter("yearFilter");
        String typeFilter = request.getParameter("typeFilter");

        if (statusFilter != null && !statusFilter.isEmpty()) {
            params.put("statusFilter", statusFilter);
        }
        if (yearFilter != null && !yearFilter.isEmpty()) {
            params.put("yearFilter", yearFilter);
        }
        if (typeFilter != null && !typeFilter.isEmpty()) {
            params.put("typeFilter", typeFilter);
        }

        Paging pvo = new Paging(5, 5);
        pvo.setTotalCount(MyPaymentHistoryDAO.getTotalHistoryCount(params));

        String cPage = request.getParameter("cPage");
        if (cPage != null) {
            pvo.setNowPage(Integer.parseInt(cPage));
        }

        params.put("begin", pvo.getBegin());

        params.put("end", 5);

        List<MyPaymentHistoryVO> list = MyPaymentHistoryDAO.getHistoryList(params);

        request.setAttribute("historyList", list);
        request.setAttribute("pvo", pvo);

        return "/mypage/myPage_reservationHistory.jsp";
    }
}