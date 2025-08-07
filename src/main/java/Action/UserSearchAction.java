package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class UserSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String status = request.getParameter("user_status");
        String field = request.getParameter("search_field");
        String keyword = request.getParameter("search_keyword");

        MemberVO[] ar = MemberDAO.getMemSearch(status, field, keyword);

        request.setAttribute("userSearch", ar);

        return "admin/adminBaseSearch.jsp";
    }
}
