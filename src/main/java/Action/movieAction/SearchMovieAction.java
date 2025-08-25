package Action.movieAction;

import Action.Action;
import mybatis.dao.FavoriteMovieDAO;
import mybatis.dao.MovieDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MovieVO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SearchMovieAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String cPage = request.getParameter("cPage");
        String keyword = request.getParameter("keyword");

        Paging p = new Paging(8, 5);
        p.setTotalCount(MovieDAO.getTotalSearchCount(keyword));

        if (cPage == null || cPage.isEmpty()) {
            p.setNowPage(1);
        } else {
            p.setNowPage(Integer.parseInt(cPage));
        }

        // DB에서 검색 결과 목록 가져오기 위한 Map 준비
        Map<String, Object> map = new HashMap<>();
        map.put("keyword", keyword);

        // ▼▼▼ 핵심 수정 부분 ▼▼▼
        // mapper가 필요로 하는 offset과 numPerPage를 정확히 계산하여 전달합니다.
        int offset = p.getBegin() - 1;
        map.put("offset", offset);
        map.put("numPerPage", p.getNumPerPage());
        // ▲▲▲ 핵심 수정 부분 ▲▲▲

        List<MovieVO> list = MovieDAO.getSearchMovieList(map);

        // 검색된 영화들의 '좋아요' 개수만 따로 조회
        Map<String, Integer> likeCountMap = FavoriteMovieDAO.getLikeCountForMovies(list);

        // 로그인한 경우, 사용자가 좋아요 누른 영화 목록 조회
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        Set<Long> likedMovieSet = null;
        if (mvo != null) {
            likedMovieSet = FavoriteMovieDAO.getLikedMovieSet(Long.valueOf(mvo.getUserIdx()));
        }

        // 검색 결과를 JSON으로 변환
        JSONObject resultJson = new JSONObject();
        // ... (이하 JSON 변환 및 응답 보내는 코드는 이전과 동일)
        JSONArray movieListJson = new JSONArray();
        for (MovieVO vo : list) {
            JSONObject movie = new JSONObject();
            movie.put("mIdx", vo.getmIdx());
            movie.put("name", vo.getName());
            movie.put("poster", vo.getPoster());
            movie.put("age", vo.getAge());
            movie.put("date", vo.getDate() != null ? vo.getDate().toString() : "");
            // synop도 추가해줍니다 (마우스 오버 효과에 필요)
            movie.put("synop", vo.getSynop());
            movieListJson.add(movie);
        }

        JSONObject pagingJson = new JSONObject();
        pagingJson.put("nowPage", p.getNowPage());
        pagingJson.put("startPage", p.getStartPage());
        pagingJson.put("endPage", p.getEndPage());
        pagingJson.put("totalPage", p.getTotalPage());

        resultJson.put("movieList", movieListJson);
        resultJson.put("paging", pagingJson);
        resultJson.put("totalCount", p.getTotalCount());
        resultJson.put("likeCountMap", new JSONObject(likeCountMap));
        resultJson.put("likedMovieSet", likedMovieSet != null ? new JSONArray() : new JSONArray());

        response.setContentType("application/json; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(resultJson.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}