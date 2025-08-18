package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.NaverDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.NaverVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
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

            // ########### [추가된 로직] ########### !!!
            // 로그인 성공 시 생일 쿠폰 지급 확인
            try {
                String birthDateStr = mvo.getBirth();
                if (birthDateStr != null && !birthDateStr.isEmpty()) {
                    LocalDate today = LocalDate.now();
                    LocalDate birthday = LocalDate.parse(birthDateStr);

                    // 오늘 날짜와 생일의 월, 일이 일치하는지 확인
                    if (today.getMonthValue() == birthday.getMonthValue() && today.getDayOfMonth() == birthday.getDayOfMonth()) {
                        long userIdx = Long.parseLong(mvo.getUserIdx());
                        long birthdayCouponIdx = 6; // DB에 명시된 생일 쿠폰 ID

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
            // ################################### !!!
        }

        // 로그인 완료 후 더 이상 필요없는 oauth state는 제거
        session.removeAttribute("naver_oauth_state");

        boolean hasPhone = (mvo != null && mvo.getPhone() != null && !mvo.getPhone().trim().isEmpty());
        boolean hasBirth = (mvo != null && mvo.getBirth() != null && !mvo.getBirth().trim().isEmpty());

        if (hasPhone && hasBirth) {
            return "redirect:Controller?type=index";
        } else {
            return "redirect:Controller?type=myPage";
        }
    }
}
