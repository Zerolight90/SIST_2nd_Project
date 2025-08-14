package Action;

import mybatis.dao.AdminDAO;
import mybatis.vo.AdminVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminListSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String admin_status = request.getParameter("admin_status");
        String admin_level = request.getParameter("admin_level");
        String search_field = request.getParameter("search_field");
        String search_keyword = request.getParameter("search_keyword");
        Map<String, String> map = new HashMap<>();
        map.put("admin_status", admin_status);
        map.put("admin_level", admin_level);
        map.put("search_field", search_field);
        map.put("search_keyword", search_keyword);

        AdminVO[] ar = AdminDAO.adminListSearch(map);

        request.setAttribute("ar", ar);

        return "admin/adminListSearch.jsp";
    }
}
