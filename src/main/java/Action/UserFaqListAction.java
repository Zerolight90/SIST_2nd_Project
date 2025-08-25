package Action;

import mybatis.dao.UserBoardDAO;
import mybatis.vo.AdminBoardVO;
import mybatis.vo.MemberVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserFaqListAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");

        return "userFaQ.jsp";
    }
}
