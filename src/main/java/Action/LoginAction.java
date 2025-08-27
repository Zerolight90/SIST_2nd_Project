package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.MemberDAO;
import mybatis.vo.CouponVO; // CouponVO import 추가
import mybatis.vo.MemberVO;
import util.ConfigUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate; // LocalDate import 추가
import java.time.ZoneId;
import java.util.Date;

public class LoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        // Action 수행 확인용 sysout
//        System.out.println("LoginAction");
        try {
            request.setCharacterEncoding("UTF-8");
            String u_id = request.getParameter("u_id");
            String u_pw = request.getParameter("u_pw");

            // 로그인 페이지에서 항상 카카오 API 키와 Redirect URI를 사용할 수 있도록 세팅
            request.setAttribute("kakaoApiKey", ConfigUtil.getProperty("kakao.api.key"));
            request.setAttribute("kakaoRedirectUri", ConfigUtil.getProperty("kakao.redirect.uri"));

            String url = "index"; // 기본값을 index로 설정

            // 만약 booking에서 Parameter를 받으면 Session에 저장함 (Request가 아닌!)
            String seaturl = request.getParameter("seat");
            String tvoIdx = request.getParameter("tvoIdx");
            System.out.println("tvoIdx: " + tvoIdx); // 1
            request.getSession().setAttribute("login_after_tvoIdx", tvoIdx); // 넘어온 tvoIdx를 바로 세션저장
            //System.out.println("seaturl parameter: " + seaturl);
            if (seaturl != null) {
                request.getSession().setAttribute("seaturl", seaturl); // Session에 저장!
                System.out.println("Saved seaturl to session: " + seaturl);
            }

            String borderurl = request.getParameter("border");
            if (borderurl != null) {
                request.getSession().setAttribute("borderurl", borderurl); // border도 Session에 저장
                //System.out.println("Saved borderurl to session: " + borderurl);
            }

            String reviewurl = request.getParameter("review");
            // 간단 추가: review 파라 없고 mIdx가 있으면 movieDetail로 복귀 URL 저장
            if (request.getSession().getAttribute("reviewurl") == null) {
                String mIdx = request.getParameter("mIdx");
                if (mIdx != null && !mIdx.trim().isEmpty()) {
                    request.getSession().setAttribute("reviewurl", "Controller?type=movieDetail&mIdx=" + mIdx);
                }
            }

            //1:1문의
            String inquiryurl = request.getParameter("userInquiryWrite");
            if (inquiryurl != null) {
                //System.out.println("Saved inquiryurl to session: " + inquiryurl);
                request.getSession().setAttribute("inquiryurl", inquiryurl); // inquiry도 Session에 저장
            }

            //극장 로그인
            String allTheaterurl = request.getParameter("all_theater");
            if (allTheaterurl != null) {
                request.getSession().setAttribute("allTheaterurl", allTheaterurl); // inquiry도 Session에 저장
                //System.out.println("Saved all_theater to session: " + allTheaterurl);
            }



            // 로그인 시도 여부 체크
            if (u_id == null || u_id.trim().isEmpty() || u_pw == null || u_pw.trim().isEmpty()) {
                // 로그인 시도 전이므로 에러 메시지 없이 로그인 페이지로 이동
                return "/join/login.jsp";
            }

            // 로그인 시도
            MemberVO mvo = MemberDAO.login(u_id, u_pw);
            HttpSession session = request.getSession();

            if (mvo != null) {
                // 로그인 성공!
//                System.out.println("Login successful for user: " + mvo.getName());

                // 세션에서 저장된 리다이렉트 URL들을 확인
                Object seaturlObj = request.getSession().getAttribute("seaturl");
                Object borderurlObj = request.getSession().getAttribute("borderurl");
                Object reviewurlobj = request.getSession().getAttribute("reviewurl");
                Object inquiryurlobj = request.getSession().getAttribute("inquiryurl");
                Object allTheaterobj = request.getSession().getAttribute("allTheaterurl");

                //.out.println(seaturlObj);
                //System.out.println(borderurlObj);
                //System.out.println(reviewurlobj);

                String seaturl2 = null;
                String borderurl2 = null;
                String reviewurl2 = null;
                String inquiryurl2 = null;
                String allTheaterurl2 = null;

                if (seaturlObj != null) {
                    seaturl2 = seaturlObj.toString();
                    System.out.println("Found seaturl2 in session: " + seaturl2);
                }

                if (borderurlObj != null) {
                    borderurl2 = borderurlObj.toString();
//                    System.out.println("Found borderurl2 in session: " + borderurl2);
                }

                if (reviewurlobj != null) {
                    reviewurl2 = reviewurlobj.toString();
                    //System.out.println("Found reviewurl2 in session: " + reviewurl2);
                }

                if (inquiryurlobj != null) {
                    inquiryurl2 = inquiryurlobj.toString();
                   //System.out.println("Found inquiryurl2 in session: " + inquiryurl2);
                }

                if (allTheaterobj != null) {
                    allTheaterurl2 = allTheaterobj.toString();
                    //System.out.println("Found theaterurl2 in session: " + allTheaterurl2);
                }

                // URL 결정 로직
                if (seaturl2 != null && !seaturl2.trim().isEmpty()) {
//                    System.out.println("Redirecting to booking page: " + seaturl2);
                    url = seaturl2;
                    // 사용 후 세션에서 제거
                    request.getSession().removeAttribute("seaturl");
                } else if (borderurl2 != null && !borderurl2.trim().isEmpty()) {
//                    System.out.println("Redirecting to border page: " + borderurl2);
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

//                    System.out.println(url); // "movieDetail&mIdx=1131759"
                }else if (inquiryurl2 != null && !inquiryurl2.trim().isEmpty()) {
//                    System.out.println("Redirecting to border page: " + inquiryurl2);
                    url = inquiryurl2;
                    // 사용 후 세션에서 제거
                    request.getSession().removeAttribute("inquiryurl");

                }else if (allTheaterurl2 != null && !allTheaterurl2.trim().isEmpty()) {
//                    System.out.println("Redirecting to border page: " + allTheaterurl2);
                    url = allTheaterurl2;
                    // 사용 후 세션에서 제거
                    request.getSession().removeAttribute("allTheaterurl");
                }
                else {
//                    System.out.println("No redirect URL found, going to index");
                    url = "index";
                }

                // 로그인 성공 시 생일 쿠폰 지급 확인
                try {
                    String birthDateStr = mvo.getBirth();
                    if (birthDateStr != null && !birthDateStr.isEmpty()) {
                        LocalDate today = LocalDate.now();
                        LocalDate birthday = LocalDate.parse(birthDateStr);

                        // 오늘이 생일인지 확인
                        if (today.getMonthValue() == birthday.getMonthValue() && today.getDayOfMonth() == birthday.getDayOfMonth()) {
                            long userIdx = Long.parseLong(mvo.getUserIdx());

                            // 올해 생일 쿠폰을 이미 받았는지 확인
                            boolean alreadyReceived = CouponDAO.hasReceivedBirthdayCouponThisYear(userIdx);

                            if (!alreadyReceived) {
                                // 1. 지급할 쿠폰 정보 생성
                                CouponVO birthdayCoupon = new CouponVO();
                                birthdayCoupon.setCouponName(today.getYear() + "년 생일 축하 2000원 할인 쿠폰");
                                birthdayCoupon.setCouponCategory("생일");
                                birthdayCoupon.setCouponInfo("생일을 진심으로 축하합니다!");
                                birthdayCoupon.setDiscountValue(String.valueOf(2000));

                                // 2. 쿠폰 생성 및 지급
                                CouponVO issuedCoupon = CouponDAO.createAndIssueCoupon(userIdx, birthdayCoupon);

                                // 3. 성공 시 세션에 알림 메시지 저장
                                if (issuedCoupon != null) {
                                    session.setAttribute("couponAlert", "생일을 축하합니다! '" + issuedCoupon.getCouponName() + "'이 발급되었습니다.");
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
//                    System.out.println("생일 쿠폰 발급 중 오류 발생");
                }

                // 리다이렉트
                session.setAttribute("mvo", mvo);
                return "redirect:Controller?type=" + url; //all_theater

            } else {
                // 로그인 실패
//                System.out.println("Login failed for user: " + u_id);
                request.setAttribute("loginError", true);
                request.setAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
                return "/join/login.jsp";
            }

        } catch (Exception e) {
            e.printStackTrace();
//            System.out.println("LoginAction 실행 중 오류 발생: " + e.getMessage());
        }
        return "/join/login_.jsp";
    }
}