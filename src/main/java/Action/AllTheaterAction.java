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
        String tIdx = request.getParameter("tIdx");
        TimeTableVO[] timeArr = null;
        TimeTableVO[] mappingTime = null;
        ScreenTypeVO[] screenTypeArr = null;
        TheaterVO theater = null;
        PriceVO pvo = null;
        // ------극장 정보를 보여주기 위한 탭의 정보를 던지기 위한 영역-------------------------------------------------------
        // 극장 정보는 theater 테이블의 정보를 가져와서 뿌려야 한다
        theater = TheatherDAO.getTheaterInfo(tIdx);
        request.setAttribute("theater", theater);
        // ------------------------------------------------------------------------------------------------------------
        // ---------- 영화관의 보유시설, 층별안내를 따로 표현하기위해 하나의 문자열로 온 정보를 구분지어서 배열에 담아 보내야한다.--
        // 현재 정보가 담겨있는 theater(VO)의 theater_info_board의 정보를 문자열을 일단 뽑음
        String tFacilities = theater.getTibvo().gettFacilities(); // 보유시설
        String tFloorInfo = theater.getTibvo().gettFloorInfo(); // 층별안내

        // 값이 잘 들어오는지 확인
        // System.out.println("보유시설: " + tFacilities);
        // System.out.println("층별안내: " + tFloorInfo);

        // 이제 들어온 값을 구분자로 구분하여 문자열을 한개씩 만들고 만든 문자열을 배열에 한개씩 저장해서 request로 보낸다
        // ------------------------------------------------------------------------------------------------------------

        // 보유시설을 쉼표(,)로 구분하여 배열에 저장
        String[] facilitiesArray = null;
        if (tFacilities != null && !tFacilities.trim().isEmpty()) {
            facilitiesArray = tFacilities.split(",");
            // 각 요소의 앞뒤 공백 제거
            for (int i = 0; i < facilitiesArray.length; i++) {
                facilitiesArray[i] = facilitiesArray[i].trim();
            }
        }

        // 층별안내를 개행문자(\n)로 구분하여 배열에 저장
        String[] floorInfoArray = null;
        if (tFloorInfo != null && !tFloorInfo.trim().isEmpty()) {
            floorInfoArray = tFloorInfo.split("\n");
            // 각 요소의 앞뒤 공백 제거
            for (int i = 0; i < floorInfoArray.length; i++) {
                floorInfoArray[i] = floorInfoArray[i].trim();
            }
        }

        // request에 배열 담아서 JSP로 전송
        request.setAttribute("facilitiesArr", facilitiesArray);
        request.setAttribute("floorInfoArr", floorInfoArray);

        // 디버깅용 출력 (필요시 주석 해제)
//if (facilitiesArray != null) {
//    System.out.println("보유시설 배열:");
//    for (String facility : facilitiesArray) {
//        System.out.println("- " + facility);
//    }
//}
//
//if (floorInfoArray != null) {
//    System.out.println("층별안내 배열:");
//    for (String floor : floorInfoArray) {
//        System.out.println("- " + floor);
//    }
//}
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
        // -----------------------------------------------------------------------------

        // 현재 상영중이거나 상영예정인 영화들을 보여주기 위한 값을 구하는 영역-----------------
        timeArr = TimeTableDAO.getList();
        request.setAttribute("timeArr", timeArr);
        //------------------------------------------------------------------------------
        
        // 사용자가 선택한 영화관에서 상영중인 영화의 정보만 가져와야함
        mappingTime = TimeTableDAO.getTimeTableSearch(tIdx);

        // 영화관에 따른 상영중인 영화들 전달
        request.setAttribute("mappingTime", mappingTime);
        // ------------------------------------------------------------------------------------------------------------

        // ------가격 정보를 보여주기 위한 탭의 정보를 던지기 위한 영역-------------------------------------------------------
        // 연령, 장애 여부 별 가격정보
        pvo = PriceDAO.getPrice();
        request.setAttribute("pvo", pvo);
        // 2D, 3D 에 대한 가격 정보
        screenTypeArr = ScreenTypeDAO.getPrice();
        request.setAttribute("screenTypeArr", screenTypeArr);
        // ------------------------------------------------------------------------------------------------------------

        return "allTheater.jsp";
    }
}
