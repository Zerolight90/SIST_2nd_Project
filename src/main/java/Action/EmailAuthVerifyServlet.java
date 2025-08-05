package Action;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class EmailAuthVerifyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        // 세션에서 "emailAuthCode"를 가져옵니다.
        String sessionAuthCode = (String) session.getAttribute("emailAuthCode");
        String inputAuthCode = req.getParameter("authCode"); // 클라이언트에서 전송된 인증번호

        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        boolean match = false;
        String message = "";

        if (sessionAuthCode == null) {
            // 세션에 인증 코드가 없는 경우 (예: 인증번호 발송 요청이 없었거나 세션 만료)
            message = "인증번호 발송 기록이 없습니다. 다시 발송해주세요.";
        } else if (inputAuthCode == null || inputAuthCode.trim().isEmpty()) {
            // 입력된 인증 코드가 비어있는 경우
            message = "인증번호를 입력해주세요.";
        } else if (sessionAuthCode.equals(inputAuthCode)) {
            // 인증 코드가 일치하는 경우
            match = true;
            message = "인증번호가 일치합니다.";
        } else {
            // 인증 코드가 일치하지 않는 경우
            message = "인증번호가 일치하지 않습니다.";
        }

        // JSON 형식으로 응답: match와 message 포함
        out.print("{\"match\": " + match + ", \"message\": \"" + message + "\"}");
        out.flush();
    }
}
