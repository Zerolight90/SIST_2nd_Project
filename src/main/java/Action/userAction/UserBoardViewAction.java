package Action.userAction;

import Action.Action;
import mybatis.dao.UserBoardDAO;
import mybatis.vo.AdminBoardVO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserBoardViewAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        String boardIdx = request.getParameter("boardIdx");//기본키
        //다 본 후 목록으로 돌아가게되면 원래 있던 페이지로 이동해야 한다.
        //String cPage = request.getParameter("cPage");
        String boardType = request.getParameter("type");

        AdminBoardVO vo = UserBoardDAO.getBoard(boardType, boardIdx, mvo);
        AdminBoardVO prevVo = UserBoardDAO.getPrevPost(boardIdx, boardType);
        AdminBoardVO nextVo = UserBoardDAO.getNextPost(boardIdx, boardType);

        //System.out.println("boardType은:::::"+boardType);

        request.setAttribute("vo", vo);
        request.setAttribute("prevVo", prevVo);
        request.setAttribute("nextVo", nextVo);


        if(boardType.equals("userViewBoard")){
            return "userViewBoard.jsp";
        }else if(boardType.equals("userViewEventBoard")){
            return "userViewEventBoard.jsp";
        }else if(boardType.equals("userViewInquiry")){
            return "/mypage/myPage_userViewInquiry.jsp";
        }

        return "userViewBoard.jsp";
    }
}
