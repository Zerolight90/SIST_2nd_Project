package Action;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class EmailAuthVerifyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        // 여기에 generate6DigitAuthCode() 절대 호출하지 마세요 (새 코드 생성 금지!)

        String sessionAuthCode = (String) session.getAttribute("emailAuthCode");
        String inputAuthCode = req.getParameter("authCode");
        sessionAuthCode.trim().equals(inputAuthCode.trim());



        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        boolean match = false;
        String message = "";

        if (sessionAuthCode == null) {
            message = "인증번호 발송 기록이 없습니다. 다시 시도해주세요.";
        } else if (inputAuthCode == null || inputAuthCode.trim().isEmpty()) {
            message = "인증번호를 입력해주세요.";
        } else if (sessionAuthCode.trim().equals(inputAuthCode.trim())) {
            match = true;
            message = "인증번호가 일치합니다.";
        } else {
            message = "인증번호가 일치하지 않습니다.";
        }
        System.out.println("세션의 인증코드: " + sessionAuthCode + ", 입력값: " + inputAuthCode);

        message = message.replace("\"", "\\\"");
        out.print("{\"match\": " + match + ", \"message\": \"" + message + "\"}");
        out.flush();
    }
}
