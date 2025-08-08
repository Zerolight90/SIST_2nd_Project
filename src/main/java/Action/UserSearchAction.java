package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class UserSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> params = new HashMap<>();
        params.put("user_status", request.getParameter("user_status"));
        params.put("datepicker", request.getParameter("datepicker"));
        params.put("search_field", request.getParameter("search_field"));
        params.put("search_keyword", request.getParameter("search_keyword"));

        MemberVO[] ar = MemberDAO.getMemSearch(params);

        request.setAttribute("ar", ar);

        return "admin/adminMemSearch.jsp";
    }
}
