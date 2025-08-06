package Action;

import mybatis.dao.AdminBoardDAO;
import mybatis.dao.BbsDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminBoardDelAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath = null;

        //파라미터 받기_글번호, 페이지 값(지우고 원래의 페이지로 돌아가기 위함)
        //추후 글 작성한 작성자의 파라미터 값도 받을 예정
        String boardIdx = request.getParameter("boardIdx");
        String cPage = request.getParameter("cPage");

        int cnt = AdminBoardDAO.delBbs(boardIdx); //업데이트가 된다.

        viewPath = "Controller?type=adminBoardList&cPage=" + cPage;

        return viewPath;
    }
}

