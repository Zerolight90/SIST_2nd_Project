package Action;

import util.EmailSend.EmailAuthUtil;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

public class EmailAuthServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        if (email == null || email.trim().isEmpty()) {
            out.print("{\"success\":false, \"message\":\"이메일이 필요합니다.\"}");
            return;
        }

        String authCode = EmailAuthUtil.generate6DigitAuthCode();

        // 인증 코드를 세션에 저장
        HttpSession session = req.getSession();
        session.setAttribute("emailAuthCode", authCode);
        session.setAttribute("emailToVerify", email);

        try {
            sendEmail(email, authCode);
            out.print("{\"success\":true, \"message\":\"인증번호가 발송되었습니다.\"}");
        } catch (MessagingException e) {
            e.printStackTrace();
            out.print("{\"success\":false, \"message\":\"이메일 전송에 실패했습니다.\"}");
        }
    }

    /**
     * 지정된 이메일 주소로 인증 코드를 포함한 이메일을 보냅니다.
     * 여기에 SMTP 서버 설정을 구성합니다.
     */
    private void sendEmail(String toEmail, String authCode) throws MessagingException {
        String host = "smtp.gmail.com";  // 실제 SMTP 호스트로 변경
        String from = "ant7773@gmail.com";  // 실제 발신 이메일로 변경
        String password = "jsudqrxxycbqtojx";  // 실제 이메일 비밀번호 또는 앱 비밀번호로 변경

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587"); // 또는 465 (SSL 포트)
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("회원가입 인증번호");
        message.setText("귀하의 인증 코드는: " + authCode + "\n\n이 코드를 입력하여 이메일을 확인하십시오.");

        Transport.send(message);
    }
}

