package Action;

import mybatis.dao.NmemDAO;
import mybatis.vo.NmemVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NonmemberAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8"); // POST 한글 처리
        } catch (Exception e) {
            // 로깅/처리 필요시 추가
        }

        String name  = request.getParameter("u_name");
        String birth = request.getParameter("u_birth");
        String phone = request.getParameter("u_phone");
        String email = request.getParameter("u_email");
        String pw    = request.getParameter("u_pw");

        // 비회원 VO 생성 (nIdx는 DB에서 생성된 후 조회로 가져옵니다)
        NmemVO n = new NmemVO(null, name, email, null, phone, pw);

        // DB에 저장
        int cnt = NmemDAO.registry(n);

        if (cnt > 0) {
            // 저장 성공 시 DB에서 방금 저장된 레코드를 조회(이메일 기준)하여 세션에 저장
//            NmemVO inserted = NmemDAO.getByEmail(email);
            HttpSession session = request.getSession();
//            session.setAttribute("nmemvo", inserted);
            return "redirect:/index.jsp";
        } else {
            // 실패 시 원래대로 nonmember 페이지로 이동 (필요시 에러 처리 추가)
            return "redirect:/nonmember.jsp";
        }
    }
}
