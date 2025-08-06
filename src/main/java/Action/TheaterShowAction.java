package Action;

import mybatis.dao.TimeTableDAO;
import mybatis.vo.TheaterVO;
import mybatis.vo.TimeTableVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TheaterShowAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        System.out.println("TheaterShowAction");
        // 해당 날짜의 영화를 상영중인 영화관을 선택하면 예약할 수 있는 상영관을 보여줘야한다.
        // 그러기 위한 인자 3개를 받고 각각
        // date는 startTime과 endTime 를 비교하고
        // m_id는 mIdx 와 비교하고
        // theater는 tIdx와 비교한다.
        TimeTableVO[] showTime = null;

        String date = request.getParameter("date");
        String mIdx = request.getParameter("mIdx");
        String tIdx = request.getParameter("tIdx");
//        System.out.println("date:"+date);
//        System.out.println(mIdx);
//        System.out.println(tIdx);

        // 모든 테이블의 정보를 resultMap으로 가져온 정보를 갖는 showTime을 가짐
        showTime = TimeTableDAO.getTimeList(date, mIdx, tIdx);

        request.setAttribute("showTime", showTime);

        return "showTime.jsp";
    }
}
