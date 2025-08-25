package Action.loginAction;

import Action.Action;
import mybatis.dao.CouponDAO;
import mybatis.dao.KakaoDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.CouponVO;
import mybatis.vo.KakaoVO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.Map;

public class KakaoLoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // Action 수행 확인용 sysout
        System.out.println("KakaoLoginAction");

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


        HttpSession session = request.getSession();
        // 4. DB에 카카오 사용자 정보 저장 전, ID 중복 확인
        boolean checkKakaoId = MemberDAO.checkKakaoId(K_member.getK_id()); // 카카오 ID 중복 확인

        if (!checkKakaoId) { // 중복된 ID가 없을 경우에만 삽입 진행
            int result = MemberDAO.kakaoregistry(K_member);
            if (result > 0) {
                // 신규 가입 쿠폰 생성 및 지급
                MemberVO newUser = MemberDAO.findByKakaoId(K_member.getK_id());
                if (newUser != null) {
                    long newUserIdx = Long.parseLong(newUser.getUserIdx());

                    CouponVO welcomeCoupon = new CouponVO();
                    welcomeCoupon.setCouponName("신규 가입 축하 2,000원 할인 쿠폰");
                    welcomeCoupon.setCouponCategory("신규가입");
                    welcomeCoupon.setCouponInfo("첫 방문을 환영합니다!");
                    welcomeCoupon.setDiscountValue(String.valueOf(2000));

                    CouponVO issuedCoupon = CouponDAO.createAndIssueCoupon(newUserIdx, welcomeCoupon);

                    if (issuedCoupon != null) {
                        session.setAttribute("couponAlert", "'" + issuedCoupon.getCouponName() + "' 쿠폰이 발급되었습니다!");
                    }
                }
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
        session.setAttribute("kvo", K_member);
        session.setAttribute("msg", (K_member.getK_name() != null ? K_member.getK_name() : "사용자") + "님, 카카오 계정으로 로그인되었습니다.");

        // Kakao ID로 DB에서 mvo 조회
        MemberVO mvo = MemberDAO.findByKakaoId(K_member.getK_id());
        if (mvo != null) {
            session.setAttribute("mvo", mvo); // 세션에 mvo 정보 저장


            // ★★★★★ [수정] 생일 쿠폰 생성 및 지급 로직 ★★★★★
            try {
                String birthDateStr = mvo.getBirth();
                if (birthDateStr != null && !birthDateStr.isEmpty()) {
                    LocalDate today = LocalDate.now();
                    LocalDate birthday = LocalDate.parse(birthDateStr);

                    if (today.getMonthValue() == birthday.getMonthValue() && today.getDayOfMonth() == birthday.getDayOfMonth()) {
                        long userIdx = Long.parseLong(mvo.getUserIdx());

                        boolean alreadyReceived = CouponDAO.hasReceivedBirthdayCouponThisYear(userIdx);
                        if (!alreadyReceived) {
                            CouponVO birthdayCoupon = new CouponVO();
                            birthdayCoupon.setCouponName(today.getYear() + "년 생일 축하 2000원 할인 쿠폰");
                            birthdayCoupon.setCouponCategory("생일");
                            birthdayCoupon.setCouponInfo("생일을 진심으로 축하합니다!");
                            birthdayCoupon.setDiscountValue(String.valueOf(2000));

                            CouponVO issuedCoupon = CouponDAO.createAndIssueCoupon(userIdx, birthdayCoupon);
                            if (issuedCoupon != null) {
                                session.setAttribute("couponAlert", "생일을 축하합니다! '" + issuedCoupon.getCouponName() + "'이 발급되었습니다.");
                            }
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("생일 쿠폰 발급 중 오류 발생");
            }
            // ################################### !!!
        }

        // *추가 부분: 휴대폰번호와 생년월일이 모두 들어 있으면 index.jsp로 리다이렉트
        boolean hasPhone = (mvo != null && mvo.getPhone() != null && !mvo.getPhone().trim().isEmpty());
        boolean hasBirth = (mvo != null && mvo.getBirth() != null && !mvo.getBirth().trim().isEmpty());

        //카카오 로그인
        String url = "";
        // 세션에서 저장된 리다이렉트 URL들을 확인
        Object seaturlObj = request.getSession().getAttribute("seaturl");
        Object borderurlObj = request.getSession().getAttribute("borderurl");
        Object reviewurlobj = request.getSession().getAttribute("reviewurl");

        String seaturl2 = null;
        String borderurl2 = null;
        String reviewurl2 = null;

        if (seaturlObj != null)
            seaturl2 = seaturlObj.toString();
        if (borderurlObj != null)
            borderurl2 = borderurlObj.toString();
        if (reviewurlobj != null)
            reviewurl2 = reviewurlobj.toString();


        // URL 결정 로직
        if (seaturl2 != null && !seaturl2.trim().isEmpty()) {
            url = seaturl2;
            // 사용 후 세션에서 제거
            request.getSession().removeAttribute("seaturl");
        } else if (borderurl2 != null && !borderurl2.trim().isEmpty()) {
            url = borderurl2;
            // 사용 후 세션에서 제거
            request.getSession().removeAttribute("reviewurl");
        }else if (reviewurl2 != null && !reviewurl2.trim().isEmpty()) {
            url = reviewurl2;

            int idx = url.indexOf("type="); // "type=" 시작 위치 찾기
            if (idx != -1) {
                // "type=" 뒤부터 끝까지 잘라서 url에 다시 저장
                url = url.substring(idx + "type=".length());
            }
            request.getSession().removeAttribute("reviewurl");
        }
        else { // 위 경우가 모두 해당되지않으면 첫화면 이동
            url = "index";
        }

        if (hasPhone && hasBirth) {
            // 둘 다 있으면 index.jsp로 리다이렉트(포워드 아님, 주소 변경)
            return "redirect:Controller?type="+url;
        } else {
            // 하나라도 없으면 마이페이지로 리다이렉트
            return "redirect:Controller?type=myPage";
        }
    }
}
