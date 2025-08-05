package Action;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class EmailAuthVerifyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String sessionAuthCode = (String) session.getAttribute("authCode");
        String inputAuthCode = req.getParameter("authCode"); // JS에서 data: {authCode: ...}

        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        boolean match = false;
        String message = "";

        if (sessionAuthCode == null) {
            message = "인증번호 발송 기록이 없습니다. 다시 발송해주세요.";
        } else if (inputAuthCode == null || inputAuthCode.trim().isEmpty()) {
            message = "인증번호를 입력해주세요.";
        } else if (sessionAuthCode.trim().equals(inputAuthCode.trim())) {
            match = true;
            message = "인증번호가 일치합니다.";
        } else {
            message = "인증번호가 일치하지 않습니다.";
        }

        // 반드시 escape 처리 (문자열에 " 있을 때 에러 방지)
        message = message.replace("\"", "\\\"");
        out.print("{\"match\": " + match + ", \"message\": \"" + message + "\"}");
        out.flush();
    }
}
