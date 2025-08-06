package Action;

import mybatis.dao.MemberDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_id = request.getParameter("u_id");
        String u_pw = request.getParameter("u_pw");

        MemVO mvo = MemberDAO.login(u_id, u_pw);

        // 로그인 성공 여부 확인
        if (mvo != null) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("mvo", mvo);

            // 로그인 성공 시 메인 페이지로 이동 (Controller가 forward한다고 가정)
            // 혹은, 필요에 따라 리다이렉트를 원한다면 Controller에서 처리하도록 null 또는 특정 명령 반환
            return "./index.jsp"; // 예: 로그인 성공 후 이동할 메인 페이지
        } else {
            // 로그인 실패 시
            request.setAttribute("loginError", "true");
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");

            // 로그인 실패 시 login.jsp로 돌아가도록 경로 반환
            return "/join/login.jsp"; // Controller가 forward할 로그인 페이지 경로
        }
    }
}
