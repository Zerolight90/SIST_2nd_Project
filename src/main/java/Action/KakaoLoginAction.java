package Action;

import mybatis.dao.KakaoDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.KakaoVO;
import mybatis.vo.MemberVO;

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

        // 3. 사용자 정보를 KakaoVO에 담기
        KakaoVO K_member = new KakaoVO();
        K_member.setK_id(kakaoUserInfo.get("id"));
        K_member.setK_name(kakaoUserInfo.get("nickname"));
        K_member.setK_email(kakaoUserInfo.get("email"));

        System.out.println("Kakao ID: " + K_member.getK_id());
        System.out.println("Kakao Name: " + K_member.getK_name());
        System.out.println("Kakao Email: " + K_member.getK_email());

        // 4. DB에 카카오 사용자 정보 저장 전, ID 중복 확인
        boolean checkKakaoId = MemberDAO.checkKakaoId(K_member.getK_id()); // 카카오 ID 중복 확인

        if (!checkKakaoId) { // 중복된 ID가 없을 경우에만 삽입 진행
            int result = MemberDAO.kakaoregistry(K_member);

            if (result > 0) {
                System.out.println("카카오 사용자 정보 DB 저장 성공!");
            } else {
                System.out.println("카카오 사용자 정보 DB 저장 실패!");
                request.setAttribute("loginError", true);
                request.setAttribute("errorMessage", "카카오 사용자 정보 DB 저장에 실패했습니다.");
                return "/join/login.jsp";
            }
        } else {
            System.out.println("이미 존재하는 카카오 ID입니다. DB 삽입을 건너뜁니다.");
        }

        // 세션 설정 등
        HttpSession session = request.getSession();
        session.setAttribute("kvo", K_member);
        session.setAttribute("msg", (K_member.getK_name() != null ? K_member.getK_name() : "사용자") + "님, 카카오 계정으로 로그인되었습니다.");

        // Kakao ID로 DB에서 mvo 조회
        MemberVO mvo = MemberDAO.findByKakaoId(K_member.getK_id());
        if (mvo != null) {
            session.setAttribute("mvo", mvo); // 세션에 mvo 정보 저장
        }

        // *추가 부분: 휴대폰번호와 생년월일이 모두 들어 있으면 index.jsp로 리다이렉트
        boolean hasPhone = (mvo != null && mvo.getPhone() != null && !mvo.getPhone().trim().isEmpty());
        boolean hasBirth = (mvo != null && mvo.getBirth() != null && !mvo.getBirth().trim().isEmpty());

        if (hasPhone && hasBirth) {
            // 둘 다 있으면 index.jsp로 리다이렉트(포워드 아님, 주소 변경)
            return "redirect:Controller?type=index";
        } else {
            // 하나라도 없으면 마이페이지로 리다이렉트
            return "redirect:Controller?type=myPage";
        }
    }
}
