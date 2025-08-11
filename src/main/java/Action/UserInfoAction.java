// Action/UserInfoAction.java

package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.KakaoVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.databind.ObjectMapper;

public class UserInfoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = null;
        ObjectMapper mapper = new ObjectMapper();

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("success", false);
        responseMap.put("message", "처리 실패");

        try {
            out = response.getWriter();

            String actionType = request.getParameter("action");
            // JSP에서 'birth'로 보낸 파라미터를 여기에서도 'birth'로 받습니다.
            String birthdate = request.getParameter("birth"); // <-- 이 부분을 수정했습니다.

            if ("updateBirthdate".equals(actionType) && birthdate != null && !birthdate.trim().isEmpty()) {
                HttpSession session = request.getSession();
                String userId = null;

                if (session.getAttribute("mvo") != null) {
                    MemberVO mvo = (MemberVO) session.getAttribute("mvo");
                    userId = mvo.getId();
                } else if (session.getAttribute("kvo") != null) {
                    KakaoVO kvo = (KakaoVO) session.getAttribute("kvo");
                    userId = kvo.getK_id();
                }

                if (userId != null) {
                    int result = MemberDAO.updateBirthdate(userId, birthdate);
                    if (result > 0) {
                        // 업데이트 성공 시 세션 정보 갱신
                        if (session.getAttribute("mvo") != null) {
                            MemberVO currentMvo = (MemberVO) session.getAttribute("mvo");
                            currentMvo.setBirth(birthdate);
                            session.setAttribute("mvo", currentMvo);
                        } else if (session.getAttribute("kvo") != null) {
                            KakaoVO currentKvo = (KakaoVO) session.getAttribute("kvo");
                            currentKvo.setBirth(birthdate);
                            session.setAttribute("kvo", currentKvo);
                        }
                        responseMap.put("success", true);
                        responseMap.put("message", "생년월일이 성공적으로 업데이트되었습니다.");
                    } else {
                        responseMap.put("message", "생년월일 업데이트에 실패했습니다.");
                    }
                } else {
                    responseMap.put("message", "로그인 정보가 유효하지 않습니다.");
                }
            } else {
                // 생년월일 업데이트 요청이 아니거나 유효하지 않은 경우
                responseMap.put("message", "생년월일 업데이트 요청이 아니거나 유효한 생년월일 값이 아닙니다.");
                // alert('다른 정보가 업데이트되었습니다.'); 메시지가 뜨지 않도록 처리
                // 또는 다른 정보 업데이트 로직을 여기에 추가
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
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        } finally {
            if (out != null) {
                out.close();
            }
        }
        return null;
    }
}
