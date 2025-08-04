package Action;

import mybatis.vo.AdminBoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminBoardListAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String boardType = request.getParameter("boardType");

        if(boardType == null){
            boardType = "공지사항"; //제일 먼저 보여줄 화면을 정함
        }


        return "list.jsp";
    }
}
