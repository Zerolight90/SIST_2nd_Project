package Action.movieAction;

import Action.Action;
import mybatis.dao.FavoriteMovieDAO;
import mybatis.dao.MovieDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MovieVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class AllMovieDataAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String category = request.getParameter("category");
        String cPage = request.getParameter("cPage");

        if (category == null || category.isEmpty()) {
            category = "boxoffice";
        }

        // 1. Paging 객체 생성
        Paging p = new Paging(8, 5); // 한 페이지에 8개씩, 페이징 블록은 5개

        // 2. 총 게시물 수 설정
        p.setTotalCount(MovieDAO.getTotalCount(category));

        // 3. 현재 페이지 설정 (음수 및 비정상 파라미터 방어 로직 추가)
        int nowPage = 1; // 기본 페이지는 1로 초기화
        if (cPage != null && !cPage.isEmpty()) {
            try {
                nowPage = Integer.parseInt(cPage);
                // 페이지 번호가 0 또는 음수일 경우 1로 강제 설정
                if (nowPage <= 0) {
                    nowPage = 1;
                }
            } catch (NumberFormatException e) {
                // cPage 파라미터가 숫자가 아닌 경우, 기본 페이지 1로 설정
                nowPage = 1;
            }
        }
        p.setNowPage(nowPage);

        // 4. DB에서 목록 가져오기 위한 Map 준비
        Map<String, Object> map = new HashMap<>();
        map.put("category", category);

        // offset 계산 (이제 음수가 될 수 없음)
        int offset = p.getBegin() - 1;
        if (offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("numPerPage", p.getNumPerPage());

        List<MovieVO> list = MovieDAO.getMovieList(map);

        // 1) 예매율 계산을 위한 분모 (상영작 전체 예매 수) 구하기
        int totalReservations = MovieDAO.getTotalReservationsForShowingMovies();

        // 2) 각 영화별 예매율 계산하여 VO에 저장
        if (totalReservations > 0 && list != null) {
            double rate = 0;
            for (MovieVO vo : list) {
                // 2-1) 분자 (해당 영화 예매 수) 구하기
                int movieReservations = MovieDAO.getReservationCountByMovie(vo.getmIdx());

                // 2-2) 예매율 계산 (소수점 둘째 자리에서 반올림)
                rate = ((double) movieReservations / totalReservations) * 100;

                // 2-3) 계산된 예매율을 MovieVO에 설정
                vo.setBookingRate(rate);
            }

        }

        // 5. '좋아요' 관련 데이터 처리
        Map<String, Integer> likeCountMap = FavoriteMovieDAO.getLikeCountForMovies(list);
        request.setAttribute("likeCountMap", likeCountMap);

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo != null) {
            // String → Long 변환
            Long userIdx = Long.parseLong(String.valueOf(mvo.getUserIdx()));

            Set<Long> likedMovieSet = FavoriteMovieDAO.getLikedMovieSet(userIdx);
            request.setAttribute("likedMovieSet", likedMovieSet);
        }

        // 6. JSP로 데이터 전달
        request.setAttribute("movieList", list);
        request.setAttribute("paging", p);
        request.setAttribute("totalCount", p.getTotalCount());
        request.setAttribute("currentCategory", category);
        request.setAttribute("nowPage", p.getNowPage());


        return "/allmovie/allmovie.jsp";
    }
}