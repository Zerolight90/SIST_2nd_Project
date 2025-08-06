package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_id = request.getParameter("u_id");
        String u_pw = request.getParameter("u_pw");

        // 로그인 시도 여부 체크: 아이디와 비밀번호가 모두 입력된 경우에만 로그인 시도
        if (u_id == null || u_id.trim().isEmpty() || u_pw == null || u_pw.trim().isEmpty()) {
            // 로그인 시도 전이므로 에러 메시지 세팅하지 않고 로그인 페이지로 이동
            return "/join/login.jsp";
        }

        MemberVO mvo = MemberDAO.login(u_id, u_pw);

        if (mvo != null) {
            HttpSession session = request.getSession();
            session.setAttribute("mvo", mvo);
            return "./index.jsp";
        } else {
            request.setAttribute("loginError", true);
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "/join/login.jsp";
        }
    }

}
