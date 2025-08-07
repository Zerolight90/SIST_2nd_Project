package Action;

import mybatis.dao.TimeTableDAO;
import mybatis.vo.ReservationVO;
import mybatis.vo.SeatStatusVO;
import mybatis.vo.TimeTableVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class PlayingAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        TimeTableVO[] ar = TimeTableDAO.getTimetableList();
        ReservationVO[] ar2 = TimeTableDAO.getRemainSeat();

        request.setAttribute("ar", ar);
        request.setAttribute("ar2", ar2);
        System.out.println(ar2.length);

        return "admin/adminTimetable.jsp";
    }
}
