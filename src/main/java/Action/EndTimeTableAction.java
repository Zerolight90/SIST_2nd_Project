package Action;

import mybatis.dao.TimeTableDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EndTimeTableAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        TimeTableDAO.endTimeTable();

        return "Controller?type=playingInfo";
    }
}
