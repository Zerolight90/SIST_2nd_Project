package Action.loginAction;

import Action.Action;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PWcheckAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

            String u_pw = request.getParameter("u_pw");

            //세션에서 로그인 사용자ID
            String loginID = null;
            Object mvo = request.getSession().getAttribute("mvo");

            if (mvo instanceof MemberVO){
                loginID = ((MemberVO) mvo).getId();
            }


            boolean pwDuplicate = false;
            if(loginID  != null && u_pw != null){
                pwDuplicate = MemberDAO.pwCheck(loginID, u_pw);
            }

            request.setAttribute("chk", pwDuplicate);


            return "/join/pwCheck.jsp";
    }
}
