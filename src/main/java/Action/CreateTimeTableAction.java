package Action;

import mybatis.dao.TimeTableDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class CreateTimeTableAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String day = request.getParameter("day");
        String tIdx = request.getParameter("tIdx");

        Map<String, String> map = new HashMap<>();
        map.put("day", day);
        map.put("tIdx", tIdx);

        TimeTableDAO.createTimeTable(map);

        return "";
    }
}
