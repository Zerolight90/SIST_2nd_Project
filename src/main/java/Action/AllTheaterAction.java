package Action;

import mybatis.dao.*;
import mybatis.vo.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class AllTheaterAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // ------극장 정보를 보여주기 위한 탭의 정보를 던지기 위한 영역-------------------------------------------------------
        // 극장 정보는 theater 테이블의 정보를 가져와서 뿌려야 한다
        // ------------------------------------------------------------------------------------------------------------

        // ------상영시간표를 보여주기 위한 탭의 정보를 던지기 위한 영역 -----------------------------------------------------
        LocalDate now = LocalDate.now();
        LocalDate f_date = now.plusDays(11);

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

        request.setAttribute("dvo_list", dvo_list);
        // --------------------------------------------------------------------------------

        // 현재 상영중이거나 상영예정인 영화들을 보여주기 위한 값을 구하는 영역-----------------
        TimeTableVO[] timeArr = TimeTableDAO.getList();
        request.setAttribute("timeArr", timeArr);
        //------------------------------------------------------------------------------

        // 상영관들의 이름를 모두 보여주기 위한 값을 구하는 영역------------------------------
        TheaterVO[] theaterArr = TheatherDAO.getList();
        request.setAttribute("theaterArr", theaterArr);
        //------------------------------------------------------------------------------
        
        // 사용자가 선택한 영화관에서 상영중인 영화의 정보만 가져와야함
//        String tIdx = request.getParameter("tIdx");
        TimeTableVO[] mappingTime = null;

        mappingTime = TimeTableDAO.getTimeTableSearch("1");

        // 영화관에 따른 상영중인 영화들 전달
        request.setAttribute("mappingTime", mappingTime);
        // ------------------------------------------------------------------------------------------------------------

        // ------극장 정보를 보여주기 위한 탭의 정보를 던지기 위한 영역-------------------------------------------------------

        // ------------------------------------------------------------------------------------------------------------

        return "allTheater.jsp";
    }
}
