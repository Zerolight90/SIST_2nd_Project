package Action;

import mybatis.dao.NmemDAO;
import mybatis.vo.NmemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class NonmemberAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/plain;charset=UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }

        String name = request.getParameter("u_name");
        String birth = request.getParameter("u_birth");
        String phone = request.getParameter("u_phone");
        String email = request.getParameter("u_email");
        String pw = request.getParameter("u_pw");

        // 1. 전달받은 파라미터로 VO 생성
        NmemVO n = new NmemVO(null, name, email, null, phone, pw, birth);

        // 2. DB에 동일한 정보의 비회원이 있는지 먼저 조회
        NmemVO nmemvo = NmemDAO.findNmemByInfo(n);

        boolean isSuccess = false;

        if (nmemvo == null) {
            // 3-1. 기존 정보가 없으면, 새로 등록
            int cnt = NmemDAO.registry(n);
            if (cnt > 0) {
                // 방금 등록한 정보를 다시 조회해서 nmemvo에 저장해야 nIdx를 알 수 있다.
                nmemvo = NmemDAO.findNmemByInfo(n);
                isSuccess = (nmemvo != null);
            }
        } else {
            // 3-2. 기존 정보가 있으면, 그걸 그대로 사용하므로 성공으로 처리
            isSuccess = true;
        }

        try (PrintWriter out = response.getWriter()) {
            if (isSuccess && nmemvo != null) {
                // 성공 시 (신규 등록이든, 기존 회원이든) 조회된 nmemvo를 세션에 저장
                HttpSession session = request.getSession();
                session.setAttribute("nmemvo", nmemvo);
                out.print("success");
            } else {
                out.print("fail");
            }
        } catch (Exception e) {
            System.err.println("NonmemberAction 응답 처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            // 클라이언트 측에 에러가 발생했음을 알리기 위해 별도의 응답을 보낼 수 있다.
            try (PrintWriter out = response.getWriter()) {
                out.print("error");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        // AJAX 요청을 직접 처리했으므로 포워딩할 경로가 없어 null을 반환한다.
        return null;
    }
}