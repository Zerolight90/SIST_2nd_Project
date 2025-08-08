package Action;

import mybatis.dao.MovieDAO;
import mybatis.vo.MovieVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class MovieSearchAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> params = new HashMap<>();
        params.put("datepicker", request.getParameter("datepicker"));
        params.put("movie_status", request.getParameter("movie_status"));
        params.put("movie_level", request.getParameter("movie_level"));
        params.put("search_field", request.getParameter("search_field"));
        params.put("search_keyword", request.getParameter("search_keyword"));

        MovieVO[] ar = MovieDAO.getMovieSearch(params);
        request.setAttribute("ar", ar);

        return "admin/adminMovieSearch.jsp";
    }
}
