package Action.loginAction;

import Action.Action;
import mybatis.dao.FavoriteMovieDAO;
import mybatis.dao.MovieDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MovieVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

public class IndexAction implements Action {

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

        // 3. 현재 페이지 설정
        int nowPage = 1;
        if (cPage != null && !cPage.isEmpty()) {
            try {
                nowPage = Integer.parseInt(cPage);
                if (nowPage <= 0) {
                    nowPage = 1;
                }
            } catch (NumberFormatException e) {
                nowPage = 1;
            }
        }
        p.setNowPage(nowPage);

        // 4. DB에서 목록 가져오기
        Map<String, Object> map = new HashMap<>();
        map.put("category", category);

        int offset = p.getBegin() - 1;
        if (offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("numPerPage", p.getNumPerPage());

        List<MovieVO> list = MovieDAO.getMovieList(map);

        // 5. 예매율 계산
        int totalReservations = MovieDAO.getTotalReservationsForShowingMovies();

        if (totalReservations > 0 && list != null) {
            for (MovieVO vo : list) {
                int movieReservations = MovieDAO.getReservationCountByMovie(vo.getmIdx());
                double rate = ((double) movieReservations / totalReservations) * 100;
                vo.setBookingRate(rate);
            }
        }

        // 6. 예매율 순으로 정렬 후 TOP 4 추출
        List<MovieVO> topMovies = new ArrayList<>(list);
        topMovies.sort((a, b) -> Double.compare(b.getBookingRate(), a.getBookingRate()));
        if (topMovies.size() > 4) {
            topMovies = topMovies.subList(0, 4);
        }

        // 7. '좋아요' 데이터 처리
        Map<String, Integer> likeCountMap = FavoriteMovieDAO.getLikeCountForMovies(list);
        request.setAttribute("likeCountMap", likeCountMap);

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo != null) {
            Long userIdx = Long.parseLong(String.valueOf(mvo.getUserIdx()));
            Set<Long> likedMovieSet = FavoriteMovieDAO.getLikedMovieSet(userIdx);
            request.setAttribute("likedMovieSet", likedMovieSet);
        }

        // 8. JSP에 데이터 전달
        request.setAttribute("topMovies", topMovies); // TOP 4만 전달
        request.setAttribute("paging", p);
        request.setAttribute("totalCount", p.getTotalCount());
        request.setAttribute("currentCategory", category);
        request.setAttribute("nowPage", p.getNowPage());

        request.setAttribute("topMovies", topMovies);
        return "/index.jsp";
    }
}
