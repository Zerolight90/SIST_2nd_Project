package Action;

import mybatis.dao.MovieDAO;
import mybatis.vo.MovieVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        MovieVO[] ar = MovieDAO.getAllMovie();

        request.setAttribute("ar", ar);

        return "admin/adminMovie.jsp";
    }
}
