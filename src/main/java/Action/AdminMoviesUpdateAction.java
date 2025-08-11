package Action;

import mybatis.dao.MovieDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdminMoviesUpdateAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> map = new HashMap<>();
        map.put("name", request.getParameter("name"));
        map.put("poster", request.getParameter("poster"));
        map.put("gen", request.getParameter("gen"));
        map.put("age", request.getParameter("age"));
        map.put("date", request.getParameter("date"));
        map.put("dir", request.getParameter("dir"));

        MovieDAO.editMovies(map);

        return "Controller?type=movieInfo";
    }
}
