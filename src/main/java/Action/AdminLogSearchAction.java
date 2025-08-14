package Action;

import mybatis.dao.LogDAO;
import mybatis.vo.LogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminLogSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String datepicker = request.getParameter("datepicker");
        String datepicker2 = request.getParameter("datepicker2");
        String search_field = request.getParameter("search_field");
        String search_keyword = request.getParameter("search_keyword");
        Map<String, String> map = new HashMap<>();
        map.put("datepicker", datepicker);
        map.put("datepicker2", datepicker2);
        map.put("search_field", search_field);
        map.put("search_keyword", search_keyword);

        LogVO[] ar = LogDAO.adminLogSearch(map);

        request.setAttribute("ar", ar);

        return "admin/adminLogSearch.jsp";
    }
}
