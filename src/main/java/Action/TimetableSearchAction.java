package Action;

import mybatis.dao.TimeTableDAO;
import mybatis.vo.TimeTableVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class TimetableSearchAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> params = new HashMap<>();
        params.put("datepicker", request.getParameter("datepicker"));
        params.put("theater_status", request.getParameter("theater_status"));
        params.put("screen_level", request.getParameter("screen_level"));
        params.put("search_keyword", request.getParameter("search_keyword"));

        TimeTableVO[] ar = TimeTableDAO.getTimetableSearch(params);

        request.setAttribute("ar", ar);

        return "admin/adminTimetableSearch.jsp";
    }
}
