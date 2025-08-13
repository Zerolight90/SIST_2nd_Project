package Action;

import mybatis.dao.TheatherDAO;
import mybatis.dao.TimeTableDAO;
import mybatis.vo.LocalDateVO;
import mybatis.vo.TheaterVO;
import mybatis.vo.TimeTableVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

public class BookingAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // booking.jsp로 이동하기 전 날짜를 구해 table에 뿌려주기 위해 수행하는 부분

        // 상단의 날짜를 보여주기 위한 값을 구하는 영역-------------------------------------
        LocalDate now = LocalDate.now();
        LocalDate f_date = now.plusDays(12);



        List<LocalDateVO> dvo_list = new ArrayList<>();

        int i = 0;
        for(LocalDate date=now; !date.isAfter(f_date); date=date.plusDays(1)) {
            LocalDateVO ldv = new LocalDateVO();
            DayOfWeek dow = date.getDayOfWeek();
//            System.out.println(date); // 값이 저장됐는지 확인
            ldv.setLocDate(date.toString());
            ldv.setDow(dow.getDisplayName(TextStyle.FULL, Locale.KOREA));
            dvo_list.add(ldv);
        }

//
        request.setAttribute("dvo_list", dvo_list);
        //------------------------------------------------------------------------------

        // 현재 상영중이거나 상영예정인 영화들을 보여주기 위한 값을 구하는 영역-----------------
        TimeTableVO[] timeArr = TimeTableDAO.getList();
        request.setAttribute("timeArr", timeArr);
        //------------------------------------------------------------------------------

        // 상영관들의 정보를 모두 보여주기 위한 값을 구하는 영역------------------------------
        TheaterVO[] theaterArr = TheatherDAO.getList();

        request.setAttribute("theaterArr", theaterArr);
        //------------------------------------------------------------------------------

        return "booking.jsp";
    }
}
