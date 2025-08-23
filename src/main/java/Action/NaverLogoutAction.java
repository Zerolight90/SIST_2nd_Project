package Action;

import mybatis.dao.NaverDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

public class NaverLogoutAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        String naverLogoutUrl = null;
//        System.out.println("-----"+session);
        if (session != null) {
            // 1) 액세스 토큰을 먼저 읽음 (세션에서 제거하기 전에)
            String accessToken = (String) session.getAttribute("naver_access_token");

            // 2) 서버 측 토큰 삭제 시도 (성공/실패 로깅)
            if (accessToken != null && !accessToken.trim().isEmpty()) {
                NaverDAO ndao = new NaverDAO();
                try {
                    boolean ok = ndao.deleteToken(accessToken);
                    System.out.println("Naver deleteToken result: " + ok);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // 3) 애플리케이션 세션 관련 속성 제거
            session.removeAttribute("naver_access_token");
            session.removeAttribute("naver_refresh_token");
            session.removeAttribute("nvo");
            session.removeAttribute("mvo");
            session.removeAttribute("naver_oauth_state");

            // 4) 세션 무효화
            try {
                session.invalidate();
            } catch (IllegalStateException ignored) {}

            // 5) JSESSIONID 및 네이버 관련 쿠키 만료 (클라이언트에서 제거 유도)
            javax.servlet.http.Cookie jsess = new javax.servlet.http.Cookie("JSESSIONID", "");
            jsess.setPath("/");
            jsess.setMaxAge(0);
            response.addCookie(jsess);

            javax.servlet.http.Cookie nid = new javax.servlet.http.Cookie("NID_AUT", "");
            nid.setPath("/");
            nid.setMaxAge(0);
            response.addCookie(nid);
        }

        // 6) 네이버 로그아웃 URL을 생성하되 직접 sendRedirect 호출은 하지 않음

        try {
            String contextUrl = request.getRequestURL().toString().replace(request.getRequestURI(), request.getContextPath());
            String returnTo = contextUrl + "/Controller?type=index";
            naverLogoutUrl =  "https://nid.naver.com/nidlogin.logout?returl=" + URLEncoder.encode(returnTo, "UTF-8");


        } catch (Exception e) {
            e.printStackTrace();

        }

        return "Controller?type=index";
    }
}
