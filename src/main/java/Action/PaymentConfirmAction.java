package Action;

import mybatis.Service.FactoryService;
import mybatis.dao.CouponDAO;
import mybatis.dao.PaymentDAO;
import mybatis.dao.PointDAO;
import mybatis.dao.ProductDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.NmemVO;
import mybatis.vo.PaymentVO;
import mybatis.vo.ProductVO;
import mybatis.vo.ReservationVO;

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

    // Toss 비밀 키 (운영 시 반드시 환경변수 또는 외부 설정으로 관리)
    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        SqlSession ss = null;

        try {
            String paymentKey = request.getParameter("paymentKey");
            String orderId = request.getParameter("orderId");
            long amount = parseLongSafe(request.getParameter("amount"), -1L);
            long couponUserIdx = parseLongSafe(request.getParameter("couponUserIdx"), 0L);
            int usedPoints = parseIntSafe(request.getParameter("usedPoints"), 0);
            int paymentType = -1;

            System.out.println("paymentKey = " + paymentKey);
            System.out.println("orderId = " + orderId);
            System.out.println("amount = " + amount);
            System.out.println("couponUserIdx = " + couponUserIdx);
            System.out.println("usedPoints = " + usedPoints);

            if (orderId != null) {
                if (orderId.contains("MOVIE_")) {
                    paymentType = 0;
                } else if (orderId.contains("STORE_")) {
                    paymentType = 1;
                }
            }

            if (paymentKey == null || paymentKey.isEmpty() ||
                    orderId == null || orderId.isEmpty() ||
                    amount < 0 || paymentType < 0) {
                throw new IllegalArgumentException("필수 결제 파라미터가 누락되었거나 형식이 올바르지 않습니다.");
            }

            // Toss API로 결제 정보 확인
            JSONObject tossPaymentInfo = verifyTossPayment(paymentKey);

            String status = (String) tossPaymentInfo.get("status");
            if (!"DONE".equals(status)) {
                cancelTossPayment(paymentKey, "결제 상태 이상: " + status);
                throw new Exception("결제 상태가 완료되지 않았습니다. 상태: " + status);
            }

            String tossOrderId = (String) tossPaymentInfo.get("orderId");
            Number tossAmountNum = (Number) tossPaymentInfo.get("totalAmount");
            long tossAmount = tossAmountNum != null ? tossAmountNum.longValue() : -1L;

            if (tossOrderId == null || !tossOrderId.equals(orderId)) {
                cancelTossPayment(paymentKey, "주문번호 불일치");
                throw new Exception("주문번호가 불일치합니다. 요청 orderId: " + orderId + ", 토스 orderId: " + tossOrderId);
            }

            if (tossAmount != amount) {
                cancelTossPayment(paymentKey, "결제 금액 불일치");
                throw new Exception("결제 금액이 불일치합니다. 요청 금액: " + amount + ", 토스 금액: " + tossAmount);
            }

            // 세션에서 결제 컨텍스트 가져오기
            Object sessionAttr = session.getAttribute(orderId);
            if (!(sessionAttr instanceof Map)) {
                throw new Exception("결제 정보가 세션에 존재하지 않거나 만료되었습니다. (orderId: " + orderId + ")");
            }
            @SuppressWarnings("unchecked")
            Map<String, Object> paymentContext = (Map<String, Object>) sessionAttr;

            Object paidItem = paymentContext.get("paidItem");
            MemberVO mvo = (MemberVO) paymentContext.get("mvo");
            NmemVO nmemvo = (NmemVO) paymentContext.get("nmemvo");

            long originalAmount = 0L;
            if (paymentType == 0) { // 영화 예매
                if (!(paidItem instanceof ReservationVO)) {
                    throw new Exception("paidItem 타입이 ReservationVO가 아닙니다.");
                }
                originalAmount = ((ReservationVO) paidItem).getFinalAmount();
            } else if (paymentType == 1) { // 스토어 구매
                if (!(paidItem instanceof ProductVO)) {
                    throw new Exception("paidItem 타입이 ProductVO가 아닙니다.");
                }
                originalAmount = ((ProductVO) paidItem).getProdPrice();
            } else {
                throw new Exception("알 수 없는 paymentType 값입니다: " + paymentType);
            }

            int couponDiscount = 0;
            Long couponIdx = null;

            if (mvo != null && couponUserIdx > 0) {
                try (SqlSession tempSs = FactoryService.getFactory().openSession()) {
                    MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx, tempSs);
                    if (coupon != null) {
                        couponDiscount = coupon.getDiscountValue();
                        couponIdx = coupon.getCouponIdx();
                    }
                }
            }

            long expectedAmount = originalAmount - couponDiscount - usedPoints;
            if (amount != expectedAmount) {
                cancelTossPayment(paymentKey, "결제 금액 위변조 의심");
                throw new Exception("결제 금액이 위변조되었습니다. 기대값: " + expectedAmount + ", 실제값: " + amount);
            }

            ss = FactoryService.getFactory().openSession(false);

            String userIdxStr = (mvo != null) ? mvo.getUserIdx() : null;

            PaymentVO pvo = new PaymentVO();
            if (userIdxStr != null) {
                pvo.setUserIdx(Long.parseLong(userIdxStr));
            }
            pvo.setOrderId(orderId);
            pvo.setPaymentTransactionId(paymentKey);
            pvo.setPaymentMethod("카드");
            pvo.setPaymentFinal((int) amount);
            pvo.setCouponDiscount(couponDiscount);
            pvo.setPointDiscount(usedPoints);
            // 총 결제 금액 = 최종 결제 금액 + 할인금액 + 포인트(원래 결제해야할 금액)
            pvo.setPaymentTotal((int) (amount + couponDiscount + usedPoints));
            pvo.setCouponIdx(couponIdx);

            if (paymentType == 0) { // 영화 예매
                pvo.setPaymentType(0);
                ReservationVO reservation = (ReservationVO) paidItem;
                if (mvo != null) {
                    reservation.setUserIdx(Long.parseLong(userIdxStr));
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
                    pvo.setUserIdx(Long.parseLong(userIdxStr));
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
                if (usedPoints > 0) PointDAO.usePoints(Long.parseLong(userIdxStr), usedPoints, pvo.getPaymentIdx(), ss);
            }

            ss.commit();

            // 결과를 JSP에 전달
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

            try {
                String paymentKey = request.getParameter("paymentKey");
                if (paymentKey != null && !paymentKey.isEmpty()) {
                    cancelTossPayment(paymentKey, "서버 내부 오류로 인한 자동 취소");
                }
            } catch (Exception cancelEx) {
                cancelEx.printStackTrace();
            }

            String errMsg = e.getMessage();
            if (errMsg == null || errMsg.trim().isEmpty()) {
                errMsg = e.toString();
            }
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + errMsg);

            return "paymentConfirm.jsp";
        } finally {
            if (ss != null) ss.close();
        }
    }

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
            os.write(requestData.toString().getBytes(StandardCharsets.UTF_8));
        }

        int responseCode = connection.getResponseCode();
        if (responseCode != 200) {
            try (InputStream errorStream = connection.getErrorStream();
                 Reader reader = new InputStreamReader(errorStream, StandardCharsets.UTF_8)) {
                JSONObject errorResponse = (JSONObject) new JSONParser().parse(reader);
                throw new Exception("Toss API Cancel Error: " + errorResponse.get("message"));
            }
        }
    }

    private long parseLongSafe(String value, long defaultValue) {
        if (value == null || value.isEmpty()) return defaultValue;
        try {
            return Long.parseLong(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private int parseIntSafe(String value, int defaultValue) {
        if (value == null || value.isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private JSONObject verifyTossPayment(String paymentKey) throws Exception {
        URL url = new URL("https://api.tosspayments.com/v2/payments/" + paymentKey);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        String encodedKey = Base64.getEncoder().encodeToString((TOSS_SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

        connection.setRequestProperty("Authorization", "Basic " + encodedKey);
        connection.setRequestMethod("GET");
        connection.setDoOutput(false);

        int responseCode = connection.getResponseCode();
        if (responseCode != 200) {
            try (InputStream errorStream = connection.getErrorStream();
                 Reader reader = new InputStreamReader(errorStream, StandardCharsets.UTF_8)) {
                JSONObject errorResponse = (JSONObject) new JSONParser().parse(reader);
                throw new Exception("Toss API Verify Error: " + errorResponse.get("message"));
            }
        }

        try (InputStream inputStream = connection.getInputStream();
             Reader reader = new InputStreamReader(inputStream, StandardCharsets.UTF_8)) {
            return (JSONObject) new JSONParser().parse(reader);
        }
    }
}
