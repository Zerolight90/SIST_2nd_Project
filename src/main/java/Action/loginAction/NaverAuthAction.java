package Action.loginAction;

import Action.Action;
import util.ConfigUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.math.BigInteger;

public class NaverAuthAction implements Action {
    // 프로퍼티에서 실제 네이버 API 키와 Redirect URI를 읽어옵니다.
    private final String CLIENT_ID = ConfigUtil.getProperty("naver.api.key");
    private final String REDIRECT_URI = ConfigUtil.getProperty("naver.redirect.uri");

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            // CSRF 방지를 위한 state 값 생성 및 세션 저장
            SecureRandom random = new SecureRandom();
            String state = new BigInteger(130, random).toString(32);
            request.getSession().setAttribute("naver_oauth_state", state);

            // Redirect URI 인코딩
            String redirectURI = URLEncoder.encode(REDIRECT_URI, "UTF-8");

            // 네이버 인증 요청 URL 완성 (예: https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=... )
            String apiURL = "https://nid.naver.com/oauth2.0/authorize"
                    + "?response_type=code"
                    + "&client_id=" + CLIENT_ID
                    + "&redirect_uri=" + redirectURI
                    + "&state=" + state;

            // Controller가 처리하도록 "redirect:" 접두어를 붙여 반환 (Controller에서 한 번만 sendRedirect 수행)
            return "redirect:" + apiURL;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "네이버 인증 요청 중 오류가 발생했습니다.");
            return "/error.jsp";
        }
    }
}
