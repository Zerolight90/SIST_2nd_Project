package Action.adminAction.theater;


import Action.Action;
import mybatis.dao.AdminTheaterBoardDAO;
import mybatis.vo.TheaterInfoBoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminTheaterViewAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {


        String tIdx = request.getParameter("tIdx");

        TheaterInfoBoardVO infovo = AdminTheaterBoardDAO.getTheaterBoard(tIdx);

        request.setAttribute("infovo", infovo);


        return "/admin/adminTheaterView.jsp";
    }
}
