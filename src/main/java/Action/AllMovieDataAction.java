package Action;

import mybatis.dao.MovieDAO;
import mybatis.vo.MovieVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AllMovieDataAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        // 1. 파라미터 받기 (카테고리, 현재 페이지)
        String category = request.getParameter("category");
        String cPage = request.getParameter("cPage");

        if (category == null || category.isEmpty()) {
            category = "boxoffice"; // 기본값 설정
        }

        // 2. 페이징 객체 생성 및 설정
        Paging p = new Paging(8, 5); // 한 페이지에 8개씩, 한 블록에 5개 페이지

        p.setTotalCount(MovieDAO.getTotalCount(category)); // 카테고리별 총 영화 수 설정

        if (cPage != null) {
            p.setNowPage(Integer.parseInt(cPage));
        } else {
            p.setNowPage(1); // cPage 파라미터 없으면 1페이지로
        }

        // 3. DB에서 현재 페이지에 해당하는 영화 목록 조회
        Map<String, Object> map = new HashMap<>();
        map.put("category", category);
        map.put("begin", p.getBegin());
        map.put("end", p.getEnd());

        List<MovieVO> list = MovieDAO.getMovieList(map);

        // 4. JSP에서 사용할 수 있도록 request에 데이터 저장
        request.setAttribute("movieList", list);
        request.setAttribute("paging", p); // 페이징 객체 저장
        request.setAttribute("totalCount", p.getTotalCount());
        request.setAttribute("currentCategory", category);

        // 5. JSP 경로 반환
        return "/allmovie/allmovie.jsp";
    }
}