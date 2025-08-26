package Action;

import mybatis.dao.NmemDAO;
import mybatis.vo.NmemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter; // AJAX 응답을 위한 PrintWriter 추가

public class NonmemberAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8"); // POST 한글 처리
            response.setContentType("text/plain;charset=UTF-8"); // AJAX 응답 타입 설정
        } catch (Exception e) {
          e.printStackTrace();
        }

        String name  = request.getParameter("u_name");
        String birth = request.getParameter("u_birth");
        String phone = request.getParameter("u_phone");
        String email = request.getParameter("u_email");
        String pw    = request.getParameter("u_pw");


        // 1. 전달받은 파라미터로 VO 생성
        NmemVO n = new NmemVO(null, name, email, null, phone, pw, birth);

        // 2. DB에 동일한 정보의 비회원이 있는지 먼저 조회
        NmemVO nmemvo = NmemDAO.findNmemByInfo(n);

        if (nmemvo == null) {
            // 3-1. 기존 정보가 없으면, 새로 등록
            NmemDAO.registry(n);
            // 방금 등록한 정보를 다시 조회해서 nmemvo에 저장
            nmemvo = NmemDAO.findNmemByInfo(n);
        }
        // DB에 저장
        int cnt = NmemDAO.registry(n);

        try (PrintWriter out = response.getWriter()) {
            if (cnt > 0) {
                // 저장 성공 시 DB에서 방금 저장된 레코드를 이메일로 조회하여 세션에 저장
                NmemVO inserted = NmemDAO.getByEmail(email);
                HttpSession session = request.getSession();
                session.setAttribute("nmemvo", inserted); // 예매 시 존재하는지 확인해야하는 녀석


                out.print("success"); // nonmember.jsp의 AJAX success 콜백에서 이 문자열을 받음
            } else {
                // 실패 시 AJAX 실패 응답 전송
                out.print("fail");
            }
        } catch (Exception e) {
            System.out.println("NonmemberAction 응답 오류: " + e.getMessage());
            // 예외 발생 시에도 'fail' 응답을 보내거나 에러 메시지를 보낼 수 있음
            try (PrintWriter out = response.getWriter()) {
                out.print("error");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }
}
