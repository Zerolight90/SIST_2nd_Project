package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import util.ConfigUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

public class LoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");
            String u_id = request.getParameter("u_id");
            String u_pw = request.getParameter("u_pw");

            // 로그인 페이지에서 항상 카카오 API 키와 Redirect URI를 사용할 수 있도록 세팅
            request.setAttribute("kakaoApiKey", ConfigUtil.getProperty("kakao.api.key"));
            request.setAttribute("kakaoRedirectUri", ConfigUtil.getProperty("kakao.redirect.uri"));

            // 로그인 시도 여부 체크
            if (u_id == null || u_id.trim().isEmpty() || u_pw == null || u_pw.trim().isEmpty()) {
                // 로그인 시도 전이므로 에러 메시지 없이 로그인 페이지로 이동
                return "/join/login.jsp";
            }

            MemberVO mvo = MemberDAO.login(u_id, u_pw);

            if (mvo != null) {
                // 로그인 성공 시 생일 쿠폰 지급 확인
                try {
                    String birthDate = mvo.getBirth();
                    if (birthDate != null) {
                        LocalDate today = LocalDate.now();
                        LocalDate birthday = LocalDate.parse(birthDate);

                        // 오늘이 생일인지 확인
                        if (today.getMonthValue() == birthday.getMonthValue() && today.getDayOfMonth() == birthday.getDayOfMonth()) {
                            long userIdx = Long.parseLong(mvo.getUserIdx());
                            long birthdayCouponIdx = 7; // DB에 명시된 생일 쿠폰 ID

                            // 올해 생일 쿠폰을 이미 받았는지 확인
                            boolean alreadyReceived = CouponDAO.hasReceivedBirthdayCouponThisYear(userIdx, birthdayCouponIdx);
                            if (!alreadyReceived) {
                                CouponDAO.issueCouponToUser(userIdx, birthdayCouponIdx);
                                System.out.println(mvo.getName() + "님에게 생일 축하 쿠폰이 발급되었습니다.");
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("생일 쿠폰 발급 중 오류 발생");
                }

                HttpSession session = request.getSession();
                session.setAttribute("mvo", mvo);
                return "./index.jsp";
            } else {
                request.setAttribute("loginError", true);
                request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
                return "/join/login.jsp";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/join/login.jsp";
    }


}
