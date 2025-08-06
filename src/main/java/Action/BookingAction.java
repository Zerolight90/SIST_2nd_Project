package Action;

import mybatis.dao.TheatherDAO;
import mybatis.dao.TimeTableDAO;
import mybatis.vo.TheaterVO;
import mybatis.vo.TimeTableVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BookingAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // booking.jsp로 이동하기 전 날짜를 구해 table에 뿌려주기 위해 수행하는 부분

        // 상단의 날짜를 보여주기 위한 값을 구하는 영역-------------------------------------
        LocalDate now = LocalDate.now();
        LocalDate f_date = now.plusDays(10);

        List<LocalDate> dateList = new ArrayList<>();

        for(LocalDate date=now; !date.isAfter(f_date); date=date.plusDays(1)) {
//            System.out.println(date); // 값이 저장됐는지 확인
            dateList.add(date);
        }
        LocalDate[] dateArr = new LocalDate[dateList.size()];
        dateList.toArray(dateArr);
//        System.out.println(dateList.size());
        request.setAttribute("dateArr", dateArr);
        //------------------------------------------------------------------------------

        // 현재 상영중이거나 상영예정인 영화들을 보여주기 위한 값을 구하는 영역-----------------
        List<TimeTableVO> list = TimeTableDAO.getList(now.toString());
        TimeTableVO[] timeArr = new TimeTableVO[list.size()];
//        System.out.println(timeArr.length);
        list.toArray(timeArr);
        // 2025-08-05
        request.setAttribute("timeArr", timeArr);
        //------------------------------------------------------------------------------

        // 상영관들의 정보를 모두 보여주기 위한 값을 구하는 영역------------------------------
        List<TheaterVO> theaterList = TheatherDAO.getList();
        TheaterVO[] theaterArr = new TheaterVO[list.size()];
        theaterList.toArray(theaterArr);
        request.setAttribute("theaterArr", theaterArr);
        //------------------------------------------------------------------------------

        return "booking.jsp";
    }
}
