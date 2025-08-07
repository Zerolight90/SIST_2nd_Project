package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import util.ConfigUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;

public class LoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            String u_id = request.getParameter("u_id");
            String u_pw = request.getParameter("u_pw");

            // 로그인 페이지에서 항상 카카오 API 키와 Redirect URI를 사용할 수 있도록 세팅
            request.setAttribute("kakaoApiKey", ConfigUtil.getProperty("kakao.api.key"));
            request.setAttribute("kakaoRedirectUri", ConfigUtil.getProperty("kakao.redirect.uri"));

            // 로그인 시도 여부 체크
            if (u_id == null || u_id.trim().isEmpty() || u_pw == null || u_pw.trim().isEmpty()) {
                // 로그인 시도 전이므로 에러 메시지 없이 로그인 페이지로 이동
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

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/join/login.jsp";
    }


}
