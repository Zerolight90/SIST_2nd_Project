package Action;

import mybatis.dao.TheatherDAO;
import mybatis.vo.TheaterVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ThscSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String thsc_level = request.getParameter("thsc_level");
        String search_keyword = request.getParameter("search_keyword");
        Map<String, String> map = new HashMap<>();
        map.put("thsc_level", thsc_level);
        map.put("search_keyword", search_keyword);

        TheaterVO[] ar = TheatherDAO.getThscSearch(map);

        request.setAttribute("ar", ar);

        return "admin/thscSearch.jsp";
    }
}
