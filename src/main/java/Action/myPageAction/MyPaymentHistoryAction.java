package Action.myPageAction;

import Action.Action;
import mybatis.dao.MyPaymentHistoryDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.NmemVO; // 비회원 VO import 추가
import mybatis.vo.MyPaymentHistoryVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyPaymentHistoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        // [반영 1] 비회원 정보(nmemvo)도 세션에서 가져옵니다.
        NmemVO nvo = (NmemVO) session.getAttribute("nmemvo");

        String userKey = null;
        String userType = null;

        // [반영 1 & 3] 회원, 비회원, 비로그인 상태를 분기하여 처리합니다.
        if (mvo != null) {
            userKey = mvo.getUserIdx();
            userType = "member";
        } else if (nvo != null) {
            userKey = nvo.getnIdx();
            userType = "nonMember";
        } else {
            // [반영 3] 로그인 정보가 없으면 로그인 페이지로 리다이렉트 (안정성 강화)
            return "redirect:Controller?type=login";
        }

        Map<String, Object> params = new HashMap<>();
        // [반영 1] userIdx 대신 userKey와 userType을 파라미터로 전달합니다.
        params.put("userKey", userKey);
        params.put("userType", userType);

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

        // [수정 안함] 기존 페이징 로직 유지
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