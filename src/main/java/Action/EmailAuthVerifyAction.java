package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.io.IOException; // IOException 명시적으로 임포트

public class EmailAuthVerifyAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        try{
            request.setCharacterEncoding("UTF-8"); // 요청 인코딩 설정

            HttpSession session = request.getSession();
            String sessionAuthCode = (String) session.getAttribute("emailAuthCode");
            String inputAuthCode = request.getParameter("authCode");
//        System.out.println("=========");
//        System.out.println(sessionAuthCode);
//        System.out.println(inputAuthCode);

            boolean match = false;
            String message = "";

            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();

            if (inputAuthCode == null || inputAuthCode.trim().isEmpty()) {
                message = "인증번호를 입력해주세요.";
            } else if (sessionAuthCode == null) { // 세션에 인증 코드가 없는 경우 (예: 세션 만료)
                message = "인증 시간이 만료되었거나, 인증번호를 발송하지 않았습니다. 다시 시도해주세요.";
            } else if (sessionAuthCode.trim().equals(inputAuthCode.trim())) {
                match = true;
                message = "인증번호가 일치합니다.";

                // 인증 성공 시 세션에서 인증 코드 제거 (선택 사항, 보안 강화)
//
            } else {
                message = "인증번호가 일치하지 않습니다.";
            }

            message = message.replace("\"", "\\\"");
            out.print("{\"match\": " + match + ", \"message\": \"" + message + "\"}");
            out.flush();
            out.close();


//            session.removeAttribute("emailAuthCode");
//            session.removeAttribute("emailToVerify");
        } catch (Exception e) {
            e.printStackTrace();
        }



        return null;
    }
}
