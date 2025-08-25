package Action.loginAction;

import Action.Action;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;

public class GoodbyeAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType("application/json; charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            if (session == null) {
                out.write("{\"result\":0,\"msg\":\"세션이 만료되었습니다. 다시 로그인해 주세요.\"}");
                return null; // AJAX 응답으로 종료
            }

            MemberVO mvo = (MemberVO) session.getAttribute("mvo");
            if (mvo == null) {
                out.write("{\"result\":0,\"msg\":\"로그인 정보가 없습니다.\"}");
                return null;
            }

            String userId = mvo.getId();
            String passwd = request.getParameter("passwd");

            if (passwd == null) passwd = "";

            // 1) 비밀번호 확인 (일반 회원 기준)
            boolean pwOk = MemberDAO.pwCheck(userId, passwd);
            if (!pwOk) {
                // 올바르게 이스케이프된 JSON 문자열로 수정
                out.write("{\"result\":0,\"msg\":\"비밀번호가 올바르지 않습니다.\"}");
                return null;
            }

            // 2) 탈퇴 처리 (status=1)
            int updated = MemberDAO.goodbye(userId);
            if (updated <= 0) {
                out.write("{\"result\":0,\"msg\":\"탈퇴 처리 중 오류가 발생했습니다.\"}");
                return null;
            }

            // 3) 세션 무효화
            try { session.invalidate(); } catch (Exception ignore) {}

            out.write("{\"result\":1,\"msg\":\"탈퇴가 완료되었습니다.\",\"redirect\":\"/Controller?type=index\"}");
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
