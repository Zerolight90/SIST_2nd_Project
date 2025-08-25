package Action;

import mybatis.dao.MovieDAO;
import mybatis.vo.MovieVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminMoviesEditAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String mIdx = request.getParameter("mIdx");

        MovieVO vo = MovieDAO.getById(mIdx);

        request.setAttribute("vo", vo);

        return "admin/adminMovieModal.jsp";
    }
}
