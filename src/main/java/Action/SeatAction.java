package Action;

import mybatis.dao.*;
import mybatis.vo.*;

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
        PriceVO price = null;


        time = TimeTableDAO.getSelect(tvoIdx);

        String tIdx = time.gettIdx(); // 영화관 Idx
        String mIdx = time.getmIdx(); // 영화 Idx
        String sIdx = time.getsIdx(); // 상영관 Idx

        theater = TheatherDAO.getById(tIdx); // theater Idx로 theaterVO 얻기
        movie = MovieDAO.getById(mIdx); // movie Idx movieVO 얻기
        screen = ScreenDAO.getById(sIdx); // screen Idx screenVO 얻기
        price = PriceDAO.getPrice();

        // 현재 상영관의 코드값 받기 (2D, 3D 4D)
        String codeIdx = screen.getScreenCode();

        // 현재 받은 상영관의 type(code)을 받아서 screentype의 가격 가져오기
        ScreenTypeVO typeVO = null;
        typeVO = ScreenTypeDAO.getPrice(codeIdx);

        // 예약이 된 좌석들은 화면에서 비활성화 해야한다.
        SeatVO[] seatVO = null;
        seatVO = SeatDAO.reserveSeat(sIdx);

        // 사용자가 선택한 영화를 저장
        request.setAttribute("time", time); // 상영시간 vo
        request.setAttribute("theater", theater); // theaterVO
        request.setAttribute("movie", movie); // movieVO
        request.setAttribute("price", price); // priceVO (가격정보)
        request.setAttribute("screen", screen); // screenVO
        request.setAttribute("typeVO", typeVO); // 현재 상영관의 type을 가져옴
        request.setAttribute("seatVO", seatVO); // 현재 상영관의 예약된 좌석들을 보냄

        return "seat.jsp";
    }
}
