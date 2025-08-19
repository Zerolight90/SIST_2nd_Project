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

        // Action 수행 확인용 sysout
//        System.out.println("LoginAction");
        try {
            request.setCharacterEncoding("UTF-8");
            String u_id = request.getParameter("u_id");
            String u_pw = request.getParameter("u_pw");

            // 로그인 페이지에서 항상 카카오 API 키와 Redirect URI를 사용할 수 있도록 세팅
            request.setAttribute("kakaoApiKey", ConfigUtil.getProperty("kakao.api.key"));
            request.setAttribute("kakaoRedirectUri", ConfigUtil.getProperty("kakao.redirect.uri"));

            String url = "index"; // 기본값을 index로 설정

            // 만약 booking에서 Parameter를 받으면 Session에 저장함 (Request가 아닌!)
            String seaturl = request.getParameter("booking");
//            System.out.println("seaturl parameter: " + seaturl);
            if (seaturl != null) {
                request.getSession().setAttribute("seaturl", seaturl); // Session에 저장!
//                System.out.println("Saved seaturl to session: " + seaturl);
            }

            String borderurl = request.getParameter("border");
            if (borderurl != null) {
                request.getSession().setAttribute("borderurl", borderurl); // border도 Session에 저장
//                System.out.println("Saved borderurl to session: " + borderurl);
            }

            // 로그인 시도 여부 체크
            if (u_id == null || u_id.trim().isEmpty() || u_pw == null || u_pw.trim().isEmpty()) {
                // 로그인 시도 전이므로 에러 메시지 없이 로그인 페이지로 이동
                return "/join/login.jsp";
            }

            // 로그인 시도
            MemberVO mvo = MemberDAO.login(u_id, u_pw);

            if (mvo != null) {
                // 로그인 성공!
//                System.out.println("Login successful for user: " + mvo.getName());

                // 세션에서 저장된 리다이렉트 URL들을 확인
                Object seaturlObj = request.getSession().getAttribute("seaturl");
                Object borderurlObj = request.getSession().getAttribute("borderurl");

                String seaturl2 = null;
                String borderurl2 = null;

                if (seaturlObj != null) {
                    seaturl2 = seaturlObj.toString();
//                    System.out.println("Found seaturl2 in session: " + seaturl2);
                }

                if (borderurlObj != null) {
                    borderurl2 = borderurlObj.toString();
//                    System.out.println("Found borderurl2 in session: " + borderurl2);
                }

                // URL 결정 로직
                if (seaturl2 != null && !seaturl2.trim().isEmpty()) {
//                    System.out.println("Redirecting to booking page: " + seaturl2);
                    url = seaturl2;
                    // 사용 후 세션에서 제거
                    request.getSession().removeAttribute("seaturl");
                } else if (borderurl2 != null && !borderurl2.trim().isEmpty()) {
//                    System.out.println("Redirecting to border page: " + borderurl2);
                    url = borderurl2;
                    // 사용 후 세션에서 제거
                    request.getSession().removeAttribute("borderurl");
                } else {
//                    System.out.println("No redirect URL found, going to index");
                    url = "index";
                }

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
//                                System.out.println(mvo.getName() + "님에게 생일 축하 쿠폰이 발급되었습니다.");
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
//                    System.out.println("생일 쿠폰 발급 중 오류 발생");
                }

                // 리다이렉트
                HttpSession session = request.getSession();
                session.setAttribute("mvo", mvo);
//                System.out.println("Final redirect URL: " + url);
                return "Controller?type=" + url;

            } else {
                // 로그인 실패
//                System.out.println("Login failed for user: " + u_id);
                request.setAttribute("loginError", true);
                request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
                return "/join/login.jsp";
            }

        } catch (Exception e) {
            e.printStackTrace();
//            System.out.println("LoginAction 실행 중 오류 발생: " + e.getMessage());
        }
        return "/join/login.jsp";
    }


}
