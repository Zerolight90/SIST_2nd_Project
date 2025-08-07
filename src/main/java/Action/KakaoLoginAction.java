package Action;

import mybatis.dao.KakaoDAO;
import mybatis.vo.KakaoVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class KakaoLoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String code = request.getParameter("code"); // 카카오로부터 인가 받은 코드

        if (code == null || code.isEmpty()) {
            request.setAttribute("loginError", true);
            request.setAttribute("errorMessage", "카카오 로그인 인가 코드를 받을 수 없습니다.");
            return "/join/login.jsp";
        }

        KakaoDAO kakaoAPi = new KakaoDAO();

        // 1. 인가 코드로 액세스 토큰 발급 요청
        String accessToken = null;
        try {
            accessToken = kakaoAPi.getAccessToken(code);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        if (accessToken == null || accessToken.isEmpty()) {
            request.setAttribute("loginError", true);
            request.setAttribute("errorMessage", "카카오 액세스 토큰 발급에 실패했습니다.");
            return "/join/login.jsp";
        }

        // 2. 액세스 토큰으로 카카오 사용자 정보 가져오기
        Map<String, String> kakaoUserInfo = null;
        try {
            kakaoUserInfo = kakaoAPi.getUserInfo(accessToken);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        if (kakaoUserInfo == null || kakaoUserInfo.isEmpty()) {
            request.setAttribute("loginError", true);
            request.setAttribute("errorMessage", "카카오 사용자 정보를 가져오는 데 실패했습니다.");
            return "/join/login.jsp";
        }

        // 3. 사용자 정보를 KakaoVO에 담아 세션에 저장
        KakaoVO K_member = new KakaoVO();
        K_member.setK_id(kakaoUserInfo.get("id"));
        K_member.setK_name(kakaoUserInfo.get("nickname"));
        K_member.setK_email(kakaoUserInfo.get("email"));

        System.out.println("Kakao ID: " + K_member.getK_id());
        System.out.println("Kakao Name: " + K_member.getK_name());
        System.out.println("Kakao Email: " + K_member.getK_email());

        HttpSession session = request.getSession();
        session.setAttribute("kvo", K_member);
        session.setAttribute("msg", (K_member.getK_name() != null ? K_member.getK_name() : "사용자") + "님, 카카오 계정으로 로그인되었습니다.");

        return "redirect:/index.jsp";

    }
}
