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

    // (수정) TOSS_SECRET_KEY는 결제 취소 API 호출을 위해 유지
    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        SqlSession ss = null;

        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        long amount = Long.parseLong(request.getParameter("amount")); // Toss로부터 전달받은 최종 결제 금액
        long couponUserIdx = Long.parseLong(request.getParameter("couponUserIdx"));
        int usedPoints = Integer.parseInt(request.getParameter("usedPoints"));
        int paymentType = Integer.parseInt(request.getParameter("paymentType"));

        try {
            // [수정] orderId로 세션에서 결제 정보 가져오기
            Map<String, Object> paymentContext = (Map<String, Object>) session.getAttribute(orderId);
            if (paymentContext == null) {
                throw new Exception("결제 정보가 세션에 존재하지 않거나 만료되었습니다. (orderId: " + orderId + ")");
            }

            Object paidItem = paymentContext.get("paidItem");
            MemberVO mvo = (MemberVO) paymentContext.get("mvo");
            NmemVO nmemvo = (NmemVO) paymentContext.get("nmemvo");

            // [수정] 금액 위변조 검증 (Toss API 호출 대신 세션 정보와 비교)
            long originalAmount = 0;
            if (paymentType == 0) { // 영화 예매
                originalAmount = ((ReservationVO) paidItem).getFinalAmount();
            } else { // 스토어 구매
                originalAmount = ((ProductVO) paidItem).getProdPrice();
            }

            int couponDiscount = 0;
            Long couponIdx = null; // coupon_idx를 저장하기 위해 변수 추가

            // DB 접근 전에 쿠폰 할인액을 먼저 계산
            if (mvo != null && couponUserIdx > 0) {
                // SqlSession이 아직 없으므로, 새로운 세션을 열어 할인액만 가져옴
                try(SqlSession tempSs = FactoryService.getFactory().openSession()) {
                    MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx, tempSs);
                    if(coupon != null) {
                        couponDiscount = coupon.getDiscountValue();
                        couponIdx = coupon.getCouponIdx();
                    }
                }
            }

            long expectedAmount = originalAmount - couponDiscount - usedPoints;

            if (amount != expectedAmount) {
                // 실제 결제된 금액과 서버에서 계산한 기대 금액이 다를 경우, 위변조로 간주하고 결제 취소
                cancelTossPayment(paymentKey, "결제 금액 불일치");
                throw new Exception("결제 금액이 위변조되었습니다. 기대값: " + expectedAmount + ", 실제값: " + amount);
            }

            // [수정] Toss API 승인(confirm) 호출 로직 완전 삭제

            ss = FactoryService.getFactory().openSession(false);

            String userIdx = (mvo != null) ? mvo.getUserIdx() : null;

            // [수정] createPaymentVO 메서드 대신 직접 PaymentVO 객체 생성 및 값 설정
            PaymentVO pvo = new PaymentVO();
            if (userIdx != null) pvo.setUserIdx(Long.parseLong(userIdx));
            pvo.setOrderId(orderId);
            pvo.setPaymentTransactionId(paymentKey);
            pvo.setPaymentMethod("카드"); // V2 위젯에서는 successUrl에서 결제수단을 바로 알 수 없으므로, 필요 시 별도 API로 조회하거나 DB 컬럼을 nullable로 변경
            pvo.setPaymentFinal((int) amount);
            pvo.setCouponDiscount(couponDiscount);
            pvo.setPointDiscount(usedPoints);
            pvo.setPaymentTotal((int) (amount + couponDiscount + usedPoints));
            pvo.setCouponIdx(couponIdx); // 사용한 쿠폰의 고유 ID 저장

            // --- 이하 DB 저장 로직은 기존과 거의 동일 ---
            if (paymentType == 0) { // 영화 예매
                pvo.setPaymentType(0);
                ReservationVO reservation = (ReservationVO) paidItem;
                if (mvo != null) {
                    reservation.setUserIdx(Long.parseLong(userIdx));
                } else if (nmemvo != null) {
                    long nIdx = Long.parseLong(nmemvo.getnIdx());
                    reservation.setnIdx(nIdx);
                    pvo.setnIdx(nIdx);
                }
                ReservationDAO.insertReservation(reservation, ss);
                pvo.setReservIdx(reservation.getReservIdx());
            } else { // 스토어 구매
                pvo.setPaymentType(1);
                ProductVO product = (ProductVO) paidItem;
                pvo.setProdIdx(product.getProdIdx());
                if (mvo != null) {
                    pvo.setUserIdx(Long.parseLong(userIdx));
                }
                Map<String, Object> params = new HashMap<>();
                params.put("prodIdx", product.getProdIdx());
                params.put("quantity", product.getQuantity());
                int updatedRows = ProductDAO.updateProductStock(params, ss);
                if (updatedRows == 0) {
                    throw new Exception("상품 재고가 부족합니다.");
                }
            }

            PaymentDAO.addPayment(pvo, ss);
            if (mvo != null) {
                if (couponUserIdx > 0) CouponDAO.useCoupon(couponUserIdx, ss);
                if (usedPoints > 0) PointDAO.usePoints(Long.parseLong(userIdx), usedPoints, pvo.getPaymentIdx(), ss);
            }

            ss.commit();

            // [수정] JSP로 넘겨줄 정보 재구성 (tossResponse 객체 대신)
            request.setAttribute("isSuccess", true);
            request.setAttribute("isGuest", (mvo == null));
            request.setAttribute("paymentType", (paymentType == 0 ? "paymentMovie" : "paymentStore"));
            request.setAttribute("finalAmount", amount);
            request.setAttribute("orderId", orderId);
            request.setAttribute("paidItem", paidItem);
            request.setAttribute("couponDiscount", couponDiscount);
            request.setAttribute("pointDiscount", usedPoints);

            session.removeAttribute(orderId);

            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            if (ss != null) ss.rollback();

            // 오류 발생 시 결제 자동 취소 로직은 유지
            if (paymentKey != null) {
                try {
                    cancelTossPayment(paymentKey, "서버 내부 오류로 인한 자동 취소");
                } catch (Exception cancelEx) {
                    e.addSuppressed(cancelEx);
                }
            }

            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "paymentConfirm.jsp";
        } finally {
            if (ss != null) ss.close();
        }
    }

    // (수정) 결제 취소 메서드는 필요하므로 유지
    private void cancelTossPayment(String paymentKey, String cancelReason) throws Exception {
        URL url = new URL("https://api.tosspayments.com/v2/payments/" + paymentKey + "/cancel");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        String encodedKey = Base64.getEncoder().encodeToString((TOSS_SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));
        connection.setRequestProperty("Authorization", "Basic " + encodedKey);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        JSONObject requestData = new JSONObject();
        requestData.put("cancelReason", cancelReason);
        try (OutputStream os = connection.getOutputStream()) {
            os.write(requestData.toString().getBytes("UTF-8"));
        }
        if (connection.getResponseCode() != 200) {
            try (InputStream errorStream = connection.getErrorStream();
                 Reader reader = new InputStreamReader(errorStream, StandardCharsets.UTF_8)) {
                JSONObject errorResponse = (JSONObject) new JSONParser().parse(reader);
                throw new Exception("Toss API Cancel Error: " + errorResponse.get("message"));
            }
        }
    }

}