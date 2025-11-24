package Action;

import mybatis.dao.AdminDAO;
import mybatis.dao.MovieDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.MovieVO;
import mybatis.vo.ReservationVO;
import mybatis.vo.RevenueVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class StatisticalChartAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        List<MovieVO> list = MovieDAO.rateMovie();
        // 1) 예매율 계산을 위한 분모 (상영작 전체 예매 수) 구하기
        int totalReservations = MovieDAO.getTotalReservationsForShowingMovies();
        // 2) 각 영화별 예매율 계산하여 VO에 저장
        if (totalReservations > 0 && list != null) {
            double rate = 0;
            for (MovieVO vo : list) {
                // 2-1) 분자 (해당 영화 예매 수) 구하기
                int movieReservations = MovieDAO.getReservationCountByMovie(vo.getmIdx());
                rate = ((double) movieReservations / totalReservations) * 100;
                vo.setBookingRate(rate);
            }
            // 예매율 기준 내림차순 정렬
            list.sort((a, b) -> Double.compare(b.getBookingRate(), a.getBookingRate()));

            // TOP 10
            if (list.size() > 10) {
                list = list.subList(0, 10);
            }
        }
        // 2. 조회된 데이터를 "revenueList"라는 이름으로 request 객체에 저장
        request.setAttribute("list", list);

        List<Map<String, Object>> rawList = ReservationDAO.reservNum();
        // 1~12월용 초기 배열 만들기
        int[] userList = new int[12]; // 기본값 0으로 채워짐
        for (Map<String, Object> row : rawList) {
            int month = ((Number) row.get("month")).intValue(); // 1~12
            int count = ((Number) row.get("reservNum")).intValue();
            userList[month - 1] = count; // 0-based index
        }
        request.setAttribute("userList", userList);

        // 3. 데이터를 표시할 JSP 경로 반환
        return "admin/adminDashboard.jsp";
    }
}