package Action;

import mybatis.dao.NaverDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.NaverVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

public class NaverLoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String code = request.getParameter("code");
        String state = request.getParameter("state");

        HttpSession session = request.getSession();
        String sessionState = (String) session.getAttribute("naver_oauth_state");
        if (code == null || state == null || sessionState == null || !sessionState.equals(state)) {
            request.setAttribute("loginError", true);
            request.setAttribute("errorMessage", "네이버 인증 정보가 유효하지 않습니다.");
            return "/join/login.jsp";
        }

        NaverDAO ndao = new NaverDAO();
        String accessToken;
        try {
            accessToken = ndao.getAccessToken(code, state);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if (accessToken == null) {
            request.setAttribute("loginError", true);
            request.setAttribute("errorMessage", "네이버 액세스 토큰 발급 실패");
            return "/join/login.jsp";
        }

        Map<String, String> userInfo;
        try {
            userInfo = ndao.getUserInfo(accessToken);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if (userInfo == null || userInfo.isEmpty()) {
            request.setAttribute("loginError", true);
            request.setAttribute("errorMessage", "네이버 사용자 정보 조회 실패");
            return "/join/login.jsp";
        }

        NaverVO nvo = ndao.buildNaverVoFromMap(userInfo);

        boolean exists = MemberDAO.checkNaverId(nvo.getN_id());
        if (!exists) {
            int res = MemberDAO.naverRegistry(nvo);
            if (res <= 0) {
                request.setAttribute("loginError", true);
                request.setAttribute("errorMessage", "DB 회원 등록 실패");
                return "/join/login.jsp";
            }
        }

        // 로그인 성공 처리 — 세션에 필요한 항목만 명확히 저장
        session.setAttribute("nvo", nvo);
        session.setAttribute("naver_access_token", accessToken);
        session.setAttribute("msg", (nvo.getN_name() != null ? nvo.getN_name() : "사용자") + "님, 네이버로 로그인되었습니다.");

        // 사용자가 DB에 존재하면 mvo도 세션에 넣음
        MemberVO mvo = MemberDAO.findByNaverId(nvo.getN_id());
        if (mvo != null) {
            session.setAttribute("mvo", mvo);
        }

        // 로그인 완료 후 더 이상 필요없는 oauth state는 제거
        session.removeAttribute("naver_oauth_state");

        boolean hasPhone = (mvo != null && mvo.getPhone() != null && !mvo.getPhone().trim().isEmpty());
        boolean hasBirth = (mvo != null && mvo.getBirth() != null && !mvo.getBirth().trim().isEmpty());

        String url = "";
        String seaturl = request.getParameter("booking");
        String borderurl = request.getParameter("border");

        if (seaturl == null || borderurl ==null) {
            url = "index";
        } else if (seaturl != null) {
            url = seaturl;

        } else if (borderurl != null) {
            url = borderurl;
        }

        if (hasPhone && hasBirth) {
            return "redirect:Controller?type="+url;
        } else {
            return "redirect:Controller?type=myPage";
        }
    }
}
