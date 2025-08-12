package Action;

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
        Paging p = new Paging(8, 5);

        // 2. 총 게시물 수 설정
        p.setTotalCount(MovieDAO.getTotalCount(category));

        // 3. 현재 페이지 설정
        if (cPage != null && !cPage.isEmpty()) {
            p.setNowPage(Integer.parseInt(cPage));
        } else {
            p.setNowPage(1);
        }

        // 4. DB에서 목록 가져오기 위한 Map 준비
        Map<String, Object> map = new HashMap<>();
        map.put("category", category);

        int offset = p.getBegin() - 1;
        map.put("offset", offset);
        map.put("numPerPage", p.getNumPerPage());

        List<MovieVO> list = MovieDAO.getMovieList(map);

        // 5. '좋아요' 관련 데이터 처리
        Map<String, Integer> likeCountMap = FavoriteMovieDAO.getLikeCountForMovies(list);
        request.setAttribute("likeCountMap", likeCountMap); // ← 빠졌으면 추가

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        if (mvo != null) {
            // 👇 String → Long 변환
            Long userIdx = Long.parseLong(String.valueOf(mvo.getUserIdx()));

            Set<Long> likedMovieSet = FavoriteMovieDAO.getLikedMovieSet(userIdx);
            request.setAttribute("likedMovieSet", likedMovieSet);
        }

        // 6. JSP로 데이터 전달
        request.setAttribute("movieList", list);
        request.setAttribute("paging", p);
        request.setAttribute("likeCountMap", likeCountMap);
        request.setAttribute("totalCount", p.getTotalCount());
        request.setAttribute("currentCategory", category);
        request.setAttribute("nowPage", p.getNowPage());

        return "/allmovie/allmovie.jsp";
    }
}