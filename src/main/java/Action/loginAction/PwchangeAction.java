package Action.loginAction;

import Action.Action;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class PwchangeAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("success", false);
        responseMap.put("message", "처리 실패");

        PrintWriter out = null;
        try {
            out = response.getWriter();

            // 필수 파라미터: id(또는 사용자식별자), newPassword(새 비밀번호, 평문)
            String userId = request.getParameter("u_id");
            String newPassword = request.getParameter("newPassword");
            System.out.println(userId);
            System.out.println(newPassword);

            if (userId == null || userId.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
                responseMap.put("message", "필수 파라미터(id, newPassword)가 누락되었습니다.");
                out.print(mapper.writeValueAsString(responseMap));
                out.flush();
                return null;
            }

            // DB에 받은 값 그대로 저장 (주의: 평문 저장)
            int result = MemberDAO.updatePassword(userId, newPassword);
            if (result > 0) {
                responseMap.put("success", true);
                responseMap.put("message", "비밀번호가 성공적으로 변경되었습니다.");

                // 이미 로그인한 사용자가 동일한 사용자일 경우 세션 동기화 (선택적)
                HttpSession session = request.getSession(false);
                if (session != null) {
                    Object obj = session.getAttribute("mvo");
                    if (obj instanceof MemberVO) {
                        MemberVO mvo = (MemberVO) obj;
                        if (userId.equals(mvo.getId())) {
                            mvo.setPw(newPassword);
                            session.setAttribute("mvo", mvo);
                        }
                    }
                }
            } else {
                responseMap.put("message", "비밀번호 변경에 실패했습니다.");
            }

            out.print(mapper.writeValueAsString(responseMap));
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
            responseMap.put("message", "서버 오류가 발생했습니다.");
            try {
                if (out != null) {
                    out.print(mapper.writeValueAsString(responseMap));
                    out.flush();
                }
            } catch (IOException ignored) {}
        } finally {
            if (out != null) out.close();
        }
        return null;
    }
}
