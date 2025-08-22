package Action;

import mybatis.dao.MovieDAO;
import mybatis.dao.TimeTableDAO;
import mybatis.vo.MovieVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

public class CreateTimeTableAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 이전 모달 창에서 지정한 상영 시작 시간 파라미터 받기
        String startTime = request.getParameter("startTime");

        // 이전 모달 창에서 지정한 영화 고유키를 이용해 해당 영화 vo 받기
        MovieVO mvo = MovieDAO.getById(request.getParameter("mIdx"));
        // 영화 vo에서 런타임을 얻어내 정수형으로 형변환
        int runTime = Integer.parseInt(mvo.getRuntime());
        // 런타임은 150 과 같은 형식이므로 시간 형식으로 표현하기 위해 연산해야 한다
        // 60으로 나눈 값이 시간이므로 나눠주기
        int hour = runTime / 60;
        // 60으로 나누고 남은 나머지 값이 분이므로 나눠주기
        int minute = runTime % 60;
        // 두 값을 이용해 포매팅해주고 최종 런타임 문자열로 저장
        String finalRunTime = String.format("%02d:%02d:00", hour, minute);

        // 
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        LocalTime time1 = LocalTime.parse(startTime, formatter);
        LocalTime time2 = LocalTime.parse(finalRunTime, formatter);
        // LocalTime -> Duration 변환 (자정부터의 시간 차이)
        Duration duration1 = Duration.between(LocalTime.MIDNIGHT, time1);
        Duration duration2 = Duration.between(LocalTime.MIDNIGHT, time2);
        // Duration 더하기
        Duration totalDuration = duration1.plus(duration2);
        // 더한 Duration을 LocalTime으로 변환 (하루를 넘어갈 경우 시간만큼 계속 돌아감)
        LocalTime resultTime = LocalTime.MIDNIGHT.plusSeconds(totalDuration.getSeconds());
        // 결과를 다시 문자열로 포맷팅해서 반환
        String resTime = resultTime.format(formatter);

        // 매퍼에서 사용할 Map 생성
        Map<String, String> map = new HashMap<>();

        // Map에 파라미터들 넣기
        // 영화관 고유키
        map.put("tIdx", request.getParameter("tIdx"));
        // 영화 고유키
        map.put("mIdx", request.getParameter("mIdx"));
        // 상영관 고유키
        map.put("sIdx", request.getParameter("sIdx"));
        // 상영 시작 시간 (상영일 + 공백 (DATETIME 형식에 맞추기 위함) + 상영 시작 시간)
        map.put("startTime", request.getParameter("inDatepicker") + " " + startTime);
        // 상영 종료 시간 (상영일 + 공백 (DATETIME 형식에 맞추기 위함) + )
        map.put("endTime", request.getParameter("inDatepicker") + " " + resTime);
        // 상영일
        map.put("date", request.getParameter("inDatepicker"));

        // 시간표 DAO의 시간표 생성 함수 호출
        TimeTableDAO.createTimeTable(map);

        // 시간표 생성 여부 확인을 위해 상영 시간표 목록 페이지로 이동
        return "Controller?type=playingInfo";
    }
}
