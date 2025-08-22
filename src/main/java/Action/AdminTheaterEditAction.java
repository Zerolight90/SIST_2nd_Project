package Action;

import mybatis.dao.AdminTheaterBoardDAO;
import mybatis.vo.TheaterInfoBoardVO;
import mybatis.vo.TheaterVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminTheaterEditAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String tIdx = request.getParameter("tIdx");

        //TheaterInfoBoardVO infovo = AdminTheaterBoardDAO.edit(tvo);

        return "";
    }
}
