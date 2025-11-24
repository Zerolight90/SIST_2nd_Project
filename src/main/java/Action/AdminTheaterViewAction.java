package Action;


import mybatis.dao.AdminTheaterBoardDAO;
import mybatis.vo.AdminVO;
import mybatis.vo.TheaterInfoBoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminTheaterViewAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //로그인한 관리자 정보 받아오기
        HttpSession session = request.getSession();

        AdminVO vo = (AdminVO) session.getAttribute("vo");
        session.setAttribute("adminInfo", vo);


        String tIdx = request.getParameter("tIdx");

        TheaterInfoBoardVO infovo = AdminTheaterBoardDAO.getTheaterBoard(tIdx);

        request.setAttribute("infovo", infovo);


        return "/admin/adminTheaterView.jsp";
    }
}
