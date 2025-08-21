package Action;

import mybatis.dao.MovieDAO;
import mybatis.dao.MoviedetailDAO;
import mybatis.vo.MovieVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieDetailAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 1. mIdx 파라미터 받기
        String mIdxStr = request.getParameter("mIdx");


        int mIdx = -1;
        if (mIdxStr != null && !mIdxStr.isEmpty()) {
            try {
                mIdx = Integer.parseInt(mIdxStr);
//                System.out.println(mIdxStr);

            } catch (NumberFormatException e) {

                System.err.println("Invalid mIdx format: " + mIdxStr);

            }
        }

        // 2. DAO를 통해 영화 상세 정보 조회
        MoviedetailDAO dao = new MoviedetailDAO();
        MovieVO movie = dao.getMovieDetail(mIdx); // mIdx를 DAO 메서드에 전달

        // 3. 조회된 영화 정보를 request 또는 session에 저장
        if (movie != null) {
            // --- ▼▼▼ 예매율 계산 로직 추가 ▼▼▼ ---

            // 3-1) 예매율 계산을 위한 분모 (상영작 전체 예매 수) 구하기
            int totalReservations = MovieDAO.getTotalReservationsForShowingMovies();

            if(totalReservations > 0) {
                // 3-2) 분자 (해당 영화 예매 수) 구하기
                int movieReservations = MovieDAO.getReservationCountByMovie(movie.getmIdx());

                // 3-3) 예매율 계산
                double rate = ((double) movieReservations / totalReservations) * 100;

                // 3-4) 계산된 예매율을 MovieVO에 설정
                movie.setBookingRate(rate);
            }
            // --- ▲▲▲ 예매율 계산 로직 추가 끝 ▲▲▲ ---
            request.setAttribute("movie", movie); // movieDetail.jsp로 전달하기 위해 request에 저장
        } else {
            // 영화 정보를 찾지 못했을 경우의 처리 (예: 에러 메시지 설정)
            request.setAttribute("errorMessage", "해당 영화를 찾을 수 없습니다.");
        }

        return "movieDetail.jsp";
    }
}
