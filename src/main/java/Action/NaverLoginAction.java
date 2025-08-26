package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.NaverDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.CouponVO;
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
        // Action 수행 확인용 sysout
        System.out.println("NaverLoginAction");
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
            if (res > 0) {
                // 신규 가입 쿠폰 생성 및 지급
                MemberVO newUser = MemberDAO.findByNaverId(nvo.getN_id());
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

            // 생일 쿠폰 생성 및 지급 로직
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
            }
        }

        // 로그인 완료 후 더 이상 필요없는 oauth state는 제거
        session.removeAttribute("naver_oauth_state");

        boolean hasPhone = (mvo != null && mvo.getPhone() != null && !mvo.getPhone().trim().isEmpty());
        boolean hasBirth = (mvo != null && mvo.getBirth() != null && !mvo.getBirth().trim().isEmpty());

        //카카오 로그인
        String url = "";
        // 세션에서 저장된 리다이렉트 URL들을 확인
        Object seaturlObj = request.getSession().getAttribute("seaturl");
        Object borderurlObj = request.getSession().getAttribute("borderurl");
        Object reviewurlobj = request.getSession().getAttribute("reviewurl");
        Object inquiryurlobj = request.getSession().getAttribute("inquiryurl");
        Object allTheaterobj = request.getSession().getAttribute("allTheaterurl");


        String seaturl2 = null;
        String borderurl2 = null;
        String reviewurl2 = null;
        String inquiryurl2 = null;
        String allTheaterurl2 = null;

        if (seaturlObj != null)
            seaturl2 = seaturlObj.toString();
        if (borderurlObj != null)
            borderurl2 = borderurlObj.toString();
        if (reviewurlobj != null)
            reviewurl2 = reviewurlobj.toString();
        if (inquiryurlobj != null)
            inquiryurl2 = inquiryurlobj.toString();
        if (allTheaterobj != null)
            allTheaterurl2 = allTheaterobj.toString();


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
        }else if (inquiryurl2 != null && !inquiryurl2.trim().isEmpty()) {
            url = inquiryurl2;
            // 사용 후 세션에서 제거
            request.getSession().removeAttribute("inquiryurl");
        }else if (allTheaterurl2 != null && !allTheaterurl2.trim().isEmpty()) {
            url = allTheaterurl2;
            // 사용 후 세션에서 제거
            request.getSession().removeAttribute("allTheaterurl");
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
