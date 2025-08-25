    package Action.loginAction;

    import Action.Action;
    import util.ConfigUtil;
    import util.EmailSend.EmailAuthUtil;
    import javax.mail.*;
    import javax.mail.internet.*;
    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;
    import javax.servlet.http.HttpSession;
    import java.io.PrintWriter;
    import java.util.Properties;


    public class EmailAuthAction implements Action {

        @Override
        public String execute(HttpServletRequest request, HttpServletResponse response){
            try {
                request.setCharacterEncoding("UTF-8"); // 요청 인코딩 설정

                String email = request.getParameter("email");

                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();

                if (email == null || email.trim().isEmpty()) {
                    out.print("{\"success\":false, \"message\":\"이메일이 필요합니다.\"}");
                    out.flush();
                    return null;
                }

                String authCode = EmailAuthUtil.AuthCode();

                HttpSession session = request.getSession(); // 현재 사용자와 연결된 세션 객체를 가져오는 코드
                session.setAttribute("emailAuthCode", authCode);
                session.setAttribute("emailToVerify", email);

                try {
                    sendEmail(email, authCode);
                    out.print("{\"success\":true, \"message\":\"인증번호가 발송되었습니다.\"}");
                } catch (Exception e) {
                    e.printStackTrace(); // 예외 로그 출력
                    out.print("{\"success\":false, \"message\":\"이메일 전송에 실패했습니다.\"}");

                } finally {
                    out.flush();
                    out.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return null;
        }

        /**
         * 지정된 이메일 주소로 인증 코드를 포함한 이메일을 보냅니다.
         * SMTP 서버 설정을 구성합니다.
         */
        private void sendEmail(String toEmail, String authCode){

            try {
                String host = "smtp.gmail.com";
                String from = "ant7773@gmail.com";
                String password = ConfigUtil.getProperty("gmail.app.password");

                Properties props = new Properties();
                props.put("mail.smtp.host", host);
                props.put("mail.smtp.port", "587"); // 또는 465 (SSL 포트)
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true"); // TLS 활성화

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

            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }
