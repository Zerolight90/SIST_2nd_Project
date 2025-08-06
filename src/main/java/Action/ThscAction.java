package Action;

import mybatis.dao.TheatherDAO;
import mybatis.vo.TheaterVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ThscAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        TheaterVO[] ar = TheatherDAO.getThscInfo();

        request.setAttribute("ar", ar);

        return "admin/adminTheaterScreen.jsp";
    }
}
