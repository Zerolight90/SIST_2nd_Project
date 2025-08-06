package Action;

import mybatis.dao.MovieDAO;
import mybatis.dao.ScreenDAO;
import mybatis.dao.TheatherDAO;
import mybatis.dao.TimeTableDAO;
import mybatis.vo.MovieVO;
import mybatis.vo.ScreenVO;
import mybatis.vo.TheaterVO;
import mybatis.vo.TimeTableVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SeatAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 사용자가 최종적으로 선택한 영화 timetable을 받고
        String tvoIdx =  request.getParameter("tvoIdx");
        TimeTableVO time = null;
        TheaterVO theater = null;
        MovieVO movie = null;
        ScreenVO screen = null;


        time = TimeTableDAO.getSelect(tvoIdx);

        String timeIdx = time.getTimeTableIdx(); // 상영시간의 Idx
        String tIdx = time.gettIdx(); // 영화관 Idx
        String mIdx = time.getmIdx(); // 영화 Idx
        String sIdx = time.getsIdx(); // 상영관 Idx

        theater = TheatherDAO.getById(tIdx);
        movie = MovieDAO.getById(mIdx);
        screen = ScreenDAO.getById(sIdx);

        // 사용자가 선택한 영화를 저장
        request.setAttribute("time", time);
        request.setAttribute("theater", theater);
        request.setAttribute("movie", movie);
        request.setAttribute("screen", screen);

        return "seat.jsp";
    }
}
