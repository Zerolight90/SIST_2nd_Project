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
        String accessToken = null;
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

        Map<String, String> userInfo = null;
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

        NaverVO nvo = new NaverVO();
        nvo.setN_id(userInfo.get("id"));
        nvo.setN_name(userInfo.get("name"));
        nvo.setN_email(userInfo.get("email"));
        nvo.setN_birthday(userInfo.get("birthday"));
        nvo.setN_gender(userInfo.get("gender"));
        nvo.setN_Phone(userInfo.get("phone"));
        nvo.setBirthYear(userInfo.get("birthYear"));

        // DB 처리: MemberDAO에 checkNaverId, naverRegistry, findByNaverId 메서드가 있어야 합니다.
        boolean exists = MemberDAO.checkNaverId(nvo.getN_id()); // 구현 필요
        if (!exists) {
            int res = MemberDAO.naverRegistry(nvo); // 구현 필요
            if (res <= 0) {
                request.setAttribute("loginError", true);
                request.setAttribute("errorMessage", "DB 회원 등록 실패");
                return "/join/login.jsp";
            }
        }

        session.setAttribute("nvo", nvo);
        session.setAttribute("naver_access_token", accessToken);
        session.setAttribute("msg", (nvo.getN_name() != null ? nvo.getN_name() : "사용자") + "님, 네이버로 로그인되었습니다.");

        MemberVO mvo = MemberDAO.findByNaverId(nvo.getN_id()); // 구현 필요
        if (mvo != null) {
            session.setAttribute("mvo", mvo);
        }

        boolean hasPhone = (mvo != null && mvo.getPhone() != null && !mvo.getPhone().trim().isEmpty());
        boolean hasBirth = (mvo != null && mvo.getBirth() != null && !mvo.getBirth().trim().isEmpty());

        if (hasPhone && hasBirth) {
            return "redirect:Controller?type=index";
        } else {
            return "redirect:Controller?type=myPage";
        }
    }
}
