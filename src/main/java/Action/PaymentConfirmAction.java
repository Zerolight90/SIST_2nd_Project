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
import java.util.HashMap;
import java.util.Map;

public class PaymentConfirmAction implements Action {

    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // --- DEBUG: 액션 시작 ---

        HttpSession session = request.getSession();
        SqlSession ss = null;

        // --- 1. JSP로부터 결제 관련 파라미터 수신 ---
        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");
        String couponUserIdxStr = request.getParameter("couponUserIdx");
        String usedPointsStr = request.getParameter("usedPoints");
        String paymentTypeStr = request.getParameter("paymentType");

        // (주석) 파라미터 null 체크 및 형 변환
        long amount = (amountStr == null || amountStr.isEmpty()) ? 0L : Long.parseLong(amountStr);
        long couponUserIdx = (couponUserIdxStr == null || couponUserIdxStr.isEmpty()) ? 0L : Long.parseLong(couponUserIdxStr);
        int usedPoints = (usedPointsStr == null || usedPointsStr.isEmpty()) ? 0 : Integer.parseInt(usedPointsStr);
        int paymentType = (paymentTypeStr == null || paymentTypeStr.isEmpty()) ? 0 : Integer.parseInt(paymentTypeStr); // 0: 영화, 1: 스토어


        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        Object paidItem = (paymentType == 0)
                ? session.getAttribute("reservationInfoForPayment")
                : session.getAttribute("productInfoForPayment");

        try {
            // --- 2. Toss Payments 결제 승인 API 호출 ---
            JSONObject tossResponse = confirmTossPayment(paymentKey, orderId, amount);


            // (주석) Toss API 에러 처리
            if (tossResponse.get("code") != null) {
                throw new Exception("Toss API Error: " + tossResponse.get("message"));
            }

            // (주석) 위변조 방지를 위한 금액 검증
            long approvedAmount = (long) tossResponse.get("totalAmount");
            if (amount != approvedAmount) {
                throw new Exception("결제 금액 불일치");
            }

            // --- 3. DB 처리를 위한 트랜잭션 시작 ---
            ss = FactoryService.getFactory().openSession(false); // 오토커밋 비활성화

            String userIdx = (mvo != null) ? mvo.getUserIdx() : null;
            int couponDiscount = 0; // 쿠폰 할인액을 저장할 변수
            Long couponIdx = null;

            // (주석) 회원이 쿠폰을 사용한 경우, 실제 할인액과 couponIdx를 DB에서 조회
            if (userIdx != null && couponUserIdx > 0) {
                MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx, ss);
                if (coupon != null) {
                    couponDiscount = coupon.getDiscountValue();
                    couponIdx = coupon.getCouponIdx();
                } else {
                }
            } else {
            }

            // (주석) PaymentVO 객체 생성 및 정보 채우기
            PaymentVO pvo = createPaymentVO(tossResponse, userIdx, orderId, couponIdx, usedPoints, couponDiscount);


            // (주석) 결제 타입에 따른 분기 처리 (영화 예매 or 스토어 구매)
            if (paymentType == 0) { // 영화 예매
                pvo.setPaymentType(0);

                ReservationVO reservation = (ReservationVO) paidItem;

                if (mvo != null) {
                    // 회원 정보만 추가로 설정
                    reservation.setUserIdx(Long.parseLong(userIdx));
                } else {
                    // 비회원 정보만 추가로 설정
                    Map<String, String> nmemInfo = (Map<String, String>) session.getAttribute("nmemInfoForPayment");
                    NmemVO nvo = new NmemVO(null, nmemInfo.get("name"), null, null, nmemInfo.get("phone"), nmemInfo.get("password"), null);
                    NmemDAO.insertNmember(nvo, ss);
                    long newNIdx = Long.parseLong(nvo.getnIdx());
                    reservation.setnIdx2(newNIdx);
                    pvo.setnIdx(newNIdx);
                }

                ReservationDAO.insertReservation(reservation, ss); // 모든 정보가 담긴 객체를 저장
                pvo.setReservIdx(reservation.getReservIdx());      // 생성된 예매 ID를 결제정보에 연결

            } else { // 스토어 구매 (paymentType == 1)
                pvo.setPaymentType(1);
                ProductVO product = (ProductVO) paidItem;
                pvo.setProdIdx(product.getProdIdx());

                // --- 💡 추가된 부분 시작 💡 ---

                // (주석) 현재는 수량을 1로 가정. 추후 장바구니 등에서 실제 구매수량을 받아와야 합니다.
                int quantity = 1;

                // (주석) 재고 차감을 위한 파라미터 준비
                Map<String, Object> params = new HashMap<>();
                params.put("prodIdx", product.getProdIdx());
                params.put("quantity", quantity);

                // (주석) DB에서 재고를 차감하고, 결과를 반환받음
                int updatedRows = ProductDAO.updateProductStock(params, ss);

                // (주석) 재고가 부족하여 업데이트가 실패한 경우(updatedRows == 0), 예외를 발생시켜 롤백 처리
                if (updatedRows == 0) {
                    throw new Exception("상품 재고가 부족합니다.");
                }
            }
            // --- 4. DB에 결제 정보 및 할인/포인트 사용 내역 반영 (핵심) ---
            PaymentDAO.addPayment(pvo, ss);

            // (주석) 회원인 경우에만 쿠폰과 포인트 사용을 처리
            if (mvo != null) {
                if (couponUserIdx > 0) {
                    CouponDAO.useCoupon(couponUserIdx, ss);
                }
                if (usedPoints > 0) {
                    long paymentIdx = pvo.getPaymentIdx();
                    PointDAO.usePoints(Long.parseLong(userIdx), usedPoints, paymentIdx, ss);
                }
            }

            ss.commit(); // 모든 DB 작업이 성공하면 커밋

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

            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            if (ss != null) {
                ss.rollback(); // 오류 발생 시 롤백
            }
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "paymentConfirm.jsp";
        } finally {
            if (ss != null) {
                ss.close();
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