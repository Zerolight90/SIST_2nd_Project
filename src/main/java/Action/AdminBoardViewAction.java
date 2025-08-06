package Action;

import mybatis.dao.AdminBoardDAO;
import mybatis.vo.AdminBoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AdminBoardViewAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){

        String boardIdx = request.getParameter("boardIdx");//기본키
        //다 본 후 목록으로 돌아가게되면 원래 있던 페이지로 이동해야 한다.
        //String cPage = request.getParameter("cPage");

        AdminBoardVO vo = AdminBoardDAO.getBoard(boardIdx);

        request.setAttribute("vo", vo);

        return "admin/adminViewBoard.jsp";
    }
}
