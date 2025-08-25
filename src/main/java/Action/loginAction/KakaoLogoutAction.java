package Action.loginAction;

import Action.Action;
import mybatis.dao.KakaoDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 추가: 카카오 로그아웃 처리를 위한 Action 클래스
public class KakaoLogoutAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false); // 기존 세션이 없으면 새로 생성하지 않음

        if (session != null) {
            String accessToken = (String) session.getAttribute("kakao_access_token"); // 세션에서 액세스 토큰 가져오기

            if (accessToken != null && !accessToken.isEmpty()) {
                KakaoDAO kakaoApi = new KakaoDAO();
                try {
                    // 추가: 카카오 로그아웃 API 호출
                    boolean result = kakaoApi.logout(accessToken);
                    if (result) {
                        System.out.println("카카오 로그아웃 성공");
                    } else {
                        System.err.println("카카오 로그아웃 실패");
                    }
                } catch (Exception e) {
                    // 수정: 로깅 처리 강화
                    System.err.println("카카오 로그아웃 API 호출 중 오류 발생: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // 수정: 서비스 세션의 모든 속성 무효화 및 세션 제거
            session.invalidate();
            System.out.println("서비스 세션 무효화 완료.");
        }

        // 수정: 로그아웃 후 리다이렉트할 페이지
        return "Controller?type=index"; // 또는 로그인 페이지로 리다이렉트
    }
}
