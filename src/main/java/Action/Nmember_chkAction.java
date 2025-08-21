package Action;

import com.fasterxml.jackson.databind.ObjectMapper;
import mybatis.dao.NmemDAO;
import mybatis.vo.NmemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class Nmember_chkAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        ObjectMapper mapper = new ObjectMapper();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            request.setCharacterEncoding("UTF-8");
            String u_name = request.getParameter("u_name");
            String u_pw = request.getParameter("u_pw");
            String u_birth = request.getParameter("u_birth");

            // DB에서 조회
            NmemVO nonvo = NmemDAO.chk(u_name, u_pw, u_birth);

            Map<String, Object> resp = new HashMap<>();

            if (nonvo != null) {
                // 조회 성공: 세션에 저장
                HttpSession session = request.getSession();
                session.setAttribute("nonvo", nonvo);


//                System.out.println("sessionId="+session.getId());
//                System.out.println(nonvo.getName());
//                System.out.println(nonvo.getPassword());
//                System.out.println(nonvo.getBirth());
//                System.out.println(nonvo.getPhone());



                resp.put("success", true);
                resp.put("redirect", request.getContextPath() + "/Controller?type=myPage");
                out.print(mapper.writeValueAsString(resp));
                out.flush();
                return null; // AJAX 응답 직접 완료
            } else {
                // 조회 실패: 예매 내역 없음
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
                resp.put("success", false);
                resp.put("message", "입력하신 정보와 일치하는 예매 내역이 없습니다.");
                resp.put("field", "global");
                out.print(mapper.writeValueAsString(resp));
                out.flush();
                return null;
            }

        } catch (Exception e) {
            try {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, Object> err = new HashMap<>();
                err.put("success", false);
                err.put("message", "서버 오류가 발생했습니다. 다시 시도해주세요.");
                String json = mapper.writeValueAsString(err);
                response.getWriter().print(json);
                response.getWriter().flush();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
        return null;
    }
}
