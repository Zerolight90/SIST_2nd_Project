package Action;

import mybatis.Service.FactoryService;
import mybatis.dao.*;
import mybatis.vo.*;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;

public class PaymentConfirmAction implements Action {

    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // --- DEBUG: 액션 시작 ---
        System.out.println("\n[DEBUG] ========== PaymentConfirmAction 시작 ==========");

        HttpSession session = request.getSession();
        SqlSession ss = null;

        // --- 1. JSP로부터 결제 관련 파라미터 수신 ---
        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");
        String couponUserIdxStr = request.getParameter("couponUserIdx");
        String usedPointsStr = request.getParameter("usedPoints");
        String paymentTypeStr = request.getParameter("paymentType");

        // --- DEBUG: 수신된 파라미터 출력 ---
        System.out.println("[DEBUG] 1. JSP에서 수신된 파라미터:");
        System.out.println(" - paymentKey: " + paymentKey);
        System.out.println(" - orderId: " + orderId);
        System.out.println(" - amount: " + amountStr);
        System.out.println(" - couponUserIdx: " + couponUserIdxStr);
        System.out.println(" - usedPoints: " + usedPointsStr);
        System.out.println(" - paymentType: " + paymentTypeStr);

        // (주석) 파라미터 null 체크 및 형 변환
        long amount = (amountStr == null || amountStr.isEmpty()) ? 0L : Long.parseLong(amountStr);
        long couponUserIdx = (couponUserIdxStr == null || couponUserIdxStr.isEmpty()) ? 0L : Long.parseLong(couponUserIdxStr);
        int usedPoints = (usedPointsStr == null || usedPointsStr.isEmpty()) ? 0 : Integer.parseInt(usedPointsStr);
        int paymentType = (paymentTypeStr == null || paymentTypeStr.isEmpty()) ? 0 : Integer.parseInt(paymentTypeStr); // 0: 영화, 1: 스토어

        // --- DEBUG: 파라미터 형 변환 후 값 출력 ---
        System.out.println("[DEBUG] 2. 형 변환 후 변수 값:");
        System.out.println(" - amount (long): " + amount);
        System.out.println(" - couponUserIdx (long): " + couponUserIdx);
        System.out.println(" - usedPoints (int): " + usedPoints);
        System.out.println(" - paymentType (int): " + paymentType);

        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        Object paidItem = (paymentType == 0)
                ? session.getAttribute("reservationInfoForPayment")
                : session.getAttribute("productInfoForPayment");

        try {
            // --- 2. Toss Payments 결제 승인 API 호출 ---
            System.out.println("[DEBUG] 3. 토스 결제 승인 API 호출 시작...");
            JSONObject tossResponse = confirmTossPayment(paymentKey, orderId, amount);
            System.out.println("[DEBUG]    ... 토스 API 응답 수신 완료. 응답 내용: " + tossResponse.toJSONString());


            // (주석) Toss API 에러 처리
            if (tossResponse.get("code") != null) {
                throw new Exception("Toss API Error: " + tossResponse.get("message"));
            }

            // (주석) 위변조 방지를 위한 금액 검증
            long approvedAmount = (long) tossResponse.get("totalAmount");
            System.out.println("[DEBUG] 4. 결제 금액 검증: (요청된 금액: " + amount + ", 토스 승인 금액: " + approvedAmount + ")");
            if (amount != approvedAmount) {
                throw new Exception("결제 금액 불일치");
            }
            System.out.println("[DEBUG]    ... 금액 검증 통과.");

            // --- 3. DB 처리를 위한 트랜잭션 시작 ---
            ss = FactoryService.getFactory().openSession(false); // 오토커밋 비활성화
            System.out.println("[DEBUG] 5. 데이터베이스 트랜잭션 시작 (AutoCommit=false)");

            String userIdx = (mvo != null) ? mvo.getUserIdx() : null;
            int couponDiscount = 0; // 쿠폰 할인액을 저장할 변수
            Long couponIdx = null;

            // (주석) 회원이 쿠폰을 사용한 경우, 실제 할인액과 couponIdx를 DB에서 조회
            if (userIdx != null && couponUserIdx > 0) {
                System.out.println("[DEBUG] 6. 쿠폰 사용 내역 확인. couponUserIdx(" + couponUserIdx + ")로 쿠폰 정보 조회 시도...");
                MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx, ss);
                if (coupon != null) {
                    couponDiscount = coupon.getDiscountValue();
                    couponIdx = coupon.getCouponIdx();
                    System.out.println("[DEBUG]    ... 쿠폰 정보 조회 성공. (할인액: " + couponDiscount + ", 쿠폰ID: " + couponIdx + ")");
                } else {
                    System.out.println("[DEBUG]    ... 쿠폰 정보 조회 실패. 해당 쿠폰이 DB에 없습니다.");
                }
            } else {
                System.out.println("[DEBUG] 6. 쿠폰 사용되지 않음.");
            }

            // (주석) PaymentVO 객체 생성 및 정보 채우기
            PaymentVO pvo = createPaymentVO(tossResponse, userIdx, orderId, couponIdx, usedPoints, couponDiscount);

            // --- DEBUG: 생성된 PaymentVO 객체 내용 출력 ---
            System.out.println("[DEBUG] 7. DB 저장을 위해 생성된 PaymentVO 객체 정보:");
            System.out.println(" - UserIdx: " + pvo.getUserIdx());
            System.out.println(" - CouponIdx: " + pvo.getCouponIdx());
            System.out.println(" - PaymentTotal(원가): " + pvo.getPaymentTotal());
            System.out.println(" - CouponDiscount: " + pvo.getCouponDiscount());
            System.out.println(" - PointDiscount: " + pvo.getPointDiscount());
            System.out.println(" - PaymentFinal(최종결제액): " + pvo.getPaymentFinal());

            // (주석) 결제 타입에 따른 분기 처리 (영화 예매 or 스토어 구매)
            if (paymentType == 0) { // 영화 예매
                System.out.println("[DEBUG] 8. '영화 예매' 타입으로 DB 작업 진행.");
                pvo.setPaymentType(0);
                ReservationVO reservation = (ReservationVO) paidItem;

                if (mvo != null) {
                    reservation.setUserIdx(Long.parseLong(userIdx));
                } else {
                    // (주석) 비회원 예매 처리 로직
                    System.out.println("[DEBUG]    ... 비회원 예매 처리 시작.");
                    Map<String, String> nmemInfo = (Map<String, String>) session.getAttribute("nmemInfoForPayment");
                    NmemVO nvo = new NmemVO(null, nmemInfo.get("name"), null, null, nmemInfo.get("phone"), nmemInfo.get("password"), null);
                    NmemDAO.insertNmember(nvo, ss);
                    long newNIdx = Long.parseLong(nvo.getnIdx());
                    reservation.setnIdx2(newNIdx);
                    pvo.setnIdx(newNIdx);
                    System.out.println("[DEBUG]    ... 비회원 정보 저장 완료 (nIdx: " + newNIdx + ")");
                }
                System.out.println("[DEBUG]    ... 예매 정보(Reservation) 저장 시도.");
                ReservationDAO.insertReservation(reservation, ss);
                pvo.setReservIdx(reservation.getReservIdx()); // MyBatis useGeneratedKeys 덕분에 Idx가 채워짐
                System.out.println("[DEBUG]    ... 예매 정보 저장 완료 (reservIdx: " + pvo.getReservIdx() + ")");

            } else { // 스토어 구매 (paymentType == 1)
                System.out.println("[DEBUG] 8. '스토어 구매' 타입으로 DB 작업 진행.");
                pvo.setPaymentType(1);
                ProductVO product = (ProductVO) paidItem;
                pvo.setProdIdx(product.getProdIdx());
            }

            // --- 4. DB에 결제 정보 및 할인/포인트 사용 내역 반영 (핵심) ---
            System.out.println("[DEBUG] 9. 결제 정보(Payment) 저장 시도...");
            PaymentDAO.addPayment(pvo, ss);
            System.out.println("[DEBUG]    ... 결제 정보 저장 완료 (paymentIdx: " + pvo.getPaymentIdx() + ")");

            // (주석) 회원인 경우에만 쿠폰과 포인트 사용을 처리
            if (mvo != null) {
                if (couponUserIdx > 0) {
                    System.out.println("[DEBUG] 10. 쿠폰 사용 처리 (couponUserIdx: " + couponUserIdx + " 상태 변경)...");
                    CouponDAO.useCoupon(couponUserIdx, ss);
                    System.out.println("[DEBUG]     ... 쿠폰 사용 처리 완료.");
                }
                if (usedPoints > 0) {
                    System.out.println("[DEBUG] 11. 포인트 사용 처리 (userIdx: " + userIdx + ", 사용포인트: " + usedPoints + ")...");
                    long paymentIdx = pvo.getPaymentIdx();
                    PointDAO.usePoints(Long.parseLong(userIdx), usedPoints, paymentIdx, ss);
                    System.out.println("[DEBUG]     ... 포인트 사용 처리 완료.");
                }
            }

            ss.commit(); // 모든 DB 작업이 성공하면 커밋
            System.out.println("[DEBUG] 12. 모든 DB 작업 성공. 트랜잭션 커밋(Commit) 완료.");

            // --- 5. 결제 완료 페이지(JSP)로 정보 전달 ---
            request.setAttribute("isSuccess", true);
            request.setAttribute("isGuest", (mvo == null));
            request.setAttribute("paymentType", (paymentType == 0 ? "paymentMovie" : "paymentStore"));
            request.setAttribute("tossResponse", tossResponse);
            request.setAttribute("paidItem", paidItem);
            request.setAttribute("couponDiscount", couponDiscount); // 실제 할인액 전달
            request.setAttribute("pointDiscount", usedPoints);      // 사용한 포인트 전달

            // (주석) 세션에 저장된 임시 결제 정보 삭제
            session.removeAttribute("reservationInfoForPayment");
            session.removeAttribute("productInfoForPayment");
            session.removeAttribute("nmemInfoForPayment");

            System.out.println("[DEBUG] ========== PaymentConfirmAction 정상 종료 ==========");
            return "paymentConfirm.jsp";

        } catch (Exception e) {
            System.err.println("[DEBUG] ========== PaymentConfirmAction 오류 발생 ==========");
            e.printStackTrace();
            if (ss != null) {
                ss.rollback(); // 오류 발생 시 롤백
                System.err.println("[DEBUG] 데이터베이스 트랜잭션 롤백(Rollback) 완료.");
            }
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "paymentConfirm.jsp";
        } finally {
            if (ss != null) {
                ss.close();
                System.out.println("[DEBUG] 데이터베이스 세션(SqlSession) 종료.");
            }
        }
    }

    /**
     * (주석) Toss Payments API에 결제 승인을 요청하고 결과를 반환하는 메소드
     */
    private JSONObject confirmTossPayment(String paymentKey, String orderId, long amount) throws Exception {
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode((TOSS_SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));
        String authorizations = "Basic " + new String(encodedBytes);

        URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);

        JSONObject obj = new JSONObject();
        obj.put("orderId", orderId);
        obj.put("amount", amount);

        try (OutputStream outputStream = connection.getOutputStream()) {
            outputStream.write(obj.toString().getBytes(StandardCharsets.UTF_8));
        }

        int code = connection.getResponseCode();
        boolean isSuccess = (code == 200);

        try (InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
             Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8)) {
            JSONParser parser = new JSONParser();
            return (JSONObject) parser.parse(reader);
        }
    }

    /**
     * (주석) 응답 데이터와 파라미터를 바탕으로 PaymentVO 객체를 생성하고 초기화하는 메소드
     */
    private PaymentVO createPaymentVO(JSONObject tossResponse, String userIdx, String orderId, Long couponIdx, int usedPoints, int couponDiscount) {
        PaymentVO pvo = new PaymentVO();
        if (userIdx != null) {
            pvo.setUserIdx(Long.parseLong(userIdx));
        }
        pvo.setOrderId(orderId);
        pvo.setPaymentTransactionId((String) tossResponse.get("paymentKey"));
        pvo.setPaymentMethod((String) tossResponse.get("method"));
        pvo.setPaymentFinal(((Long) tossResponse.get("totalAmount")).intValue());
        pvo.setCouponDiscount(couponDiscount);
        pvo.setPointDiscount(usedPoints);
        pvo.setPaymentTotal(pvo.getPaymentFinal() + couponDiscount + usedPoints);
        pvo.setCouponIdx(couponIdx);
        return pvo;
    }
}