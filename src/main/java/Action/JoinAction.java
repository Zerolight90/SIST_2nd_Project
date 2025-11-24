package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.CouponVO;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class JoinAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        Boolean agreed = (Boolean) session.getAttribute("agreed");
        if (agreed == null || !agreed) {
            // 동의하지 않았다면 약관 페이지로 이동
            return "redirect:Controller?type=terms";
        }
        String sessionAuthCode = (String) session.getAttribute("emailAuthCode");
        String inputAuthCode = request.getParameter("email_auth_key");
        String sessionEmail = (String) session.getAttribute("emailToVerify");
        String inputEmail = request.getParameter("u_email"); // 회원가입 폼의 이메일 필드 name

        // 1. 이메일 인증번호 유효성 검사 (서버 측 최종 검증)
        if (sessionAuthCode == null || !sessionAuthCode.equals(inputAuthCode) || !sessionEmail.equals(inputEmail)) {
//            request.setAttribute("errorMsg", "이메일 인증번호가 일치하지 않거나 이메일 인증이 필요합니다.");
            // 오류 발생 시 기존 입력 데이터 유지
            request.setAttribute("param_u_id", request.getParameter("u_id"));
            request.setAttribute("param_u_pw", request.getParameter("u_pw"));
            request.setAttribute("param_u_name", request.getParameter("u_name"));
            request.setAttribute("param_u_year", request.getParameter("u_year"));
            request.setAttribute("param_u_month", request.getParameter("u_month"));
            request.setAttribute("param_u_day", request.getParameter("u_day"));
            request.setAttribute("param_u_gender", request.getParameter("u_gender"));
            request.setAttribute("param_u_phone", request.getParameter("u_phone"));
            request.setAttribute("param_u_email", request.getParameter("u_email"));

            return "/join/join.jsp"; // 오류 메시지와 함께 회원가입 페이지로 다시 포워딩
        }

        // 2. 이메일 인증이 성공하면 세션에서 인증 정보 제거 (일회성 인증)
        session.removeAttribute("emailAuthCode");
        session.removeAttribute("emailToVerify");

        // 3. 요청 파라미터 수집 및 MemVO 객체 세팅 (이메일 인증 성공 후 실행)
        String id = request.getParameter("u_id");
        String pw = request.getParameter("u_pw");
        String birthYearStr = request.getParameter("u_year");
        String birthMonthStr = request.getParameter("u_month");
        String birthDayStr = request.getParameter("u_day");
        String formattedBirth = null;

        if (birthYearStr != null && !birthYearStr.isEmpty() &&
                birthMonthStr != null && !birthMonthStr.isEmpty() &&
                birthDayStr != null && !birthDayStr.isEmpty()) {

            String paddedMonth = String.format("%02d", Integer.parseInt(birthMonthStr));
            String paddedDay = String.format("%02d", Integer.parseInt(birthDayStr));
            formattedBirth = birthYearStr + "-" + paddedMonth + "-" + paddedDay;
        }

        String name = request.getParameter("u_name");
        String gender = request.getParameter("u_gender");
        String phone = request.getParameter("u_phone");
        String joinPath = request.getParameter("joinPath");
        // 이메일은 이미 위에서 검증되었으므로 그대로 사용

        MemberVO mvo = new MemberVO();

        mvo.setId(id);
        mvo.setPw(pw);
        mvo.setBirth(formattedBirth);
        mvo.setName(name);
        mvo.setGender(gender);
        mvo.setPhone(phone);
        mvo.setEmail(inputEmail); // 인증된 이메일 사용
        mvo.setjoinPath("Client");

        // 4. DAO 호출해서 회원가입 시도
        int result = MemberDAO.registry(mvo);

        if (result > 0) {
            // ★★★★★ [수정] 신규 가입 쿠폰 생성 및 지급 ★★★★★
            MemberVO newUser = MemberDAO.login(id, pw); // userIdx를 가져오기 위해 다시 조회
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

            // 회원가입 성공 시, 가입 완료 메시지와 사용자 이름을 request 속성에 설정
            request.setAttribute("msg", "회원가입이 완료되었습니다");
            request.setAttribute("param_u_name", name); // 로그인 페이지로 전달할 사용자 이름
            return "/join/login.jsp"; // 회원가입 성공 후 이동할 페이지 경로
        } else {
            // 회원가입 실패 시
            request.setAttribute("errorMsg", "회원가입에 실패했습니다. 다시 시도하세요.");

            // 실패 시 기존 입력 데이터 유지
            request.setAttribute("param_u_id", request.getParameter("u_id"));
            request.setAttribute("param_u_pw", request.getParameter("u_pw"));
            request.setAttribute("param_u_name", request.getParameter("u_name"));
            request.setAttribute("param_u_year", request.getParameter("u_year"));
            request.setAttribute("param_u_month", request.getParameter("u_month"));
            request.setAttribute("param_u_day", request.getParameter("u_day"));
            request.setAttribute("param_u_gender", request.getParameter("u_gender"));
            request.setAttribute("param_u_phone", request.getParameter("u_phone"));
            request.setAttribute("param_u_email", request.getParameter("u_email"));

            return "/join/join.jsp";
        }

    }
}
