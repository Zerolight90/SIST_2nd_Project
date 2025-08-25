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
import util.ConfigUtil; // ConfigUtil 임포트

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

    // config.properties 파일에서 시크릿 키를 안전하게 불러온다.
    private static final String TOSS_SECRET_KEY = ConfigUtil.getProperty("toss.secret.key");

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        SqlSession ss = null;

        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        String amountStr = request.getParameter("amount");
//
//        System.out.println("✅ 1. paymentConfirm 액션 시작");
//        System.out.println("  - paymentKey: " + paymentKey + ", orderId: " + orderId + ", amount: " + amountStr);

        try {
            long amount = parseLongSafe(amountStr, -1L);

            if (paymentKey == null || orderId == null || amount < 0) {
                throw new IllegalArgumentException("필수 결제 파라미터가 누락되었습니다.");
            }
//
//            System.out.println("✅ 2. 토스 결제 승인 API 호출 시작");
            JSONObject tossPaymentInfo = confirmTossPayment(paymentKey, orderId, amount);
//            System.out.println("✅ 3. 토스 API 응답 수신: " + tossPaymentInfo.toJSONString());

            String status = (String) tossPaymentInfo.get("status");
            if (!"DONE".equals(status)) {
                throw new Exception("결제가 최종 승인되지 않았습니다. 상태: " + status);
            }

            Object sessionAttr = session.getAttribute(orderId);
            if (sessionAttr == null) {
                throw new Exception("세션 정보 유실: 결제 시간이 초과되었거나, 올바르지 않은 접근입니다.");
            }
//            System.out.println("  - 세션 정보 확인 완료");

            @SuppressWarnings("unchecked")
            Map<String, Object> paymentContext = (Map<String, Object>) sessionAttr;

            Object paidItem = paymentContext.get("paidItem");
            MemberVO mvo = (MemberVO) paymentContext.get("mvo");
            NmemVO nmemvo = (NmemVO) paymentContext.get("nmemvo");

            long couponUserIdx = parseLongSafe(request.getParameter("couponUserIdx"), 0L);
            int usedPoints = parseIntSafe(request.getParameter("usedPoints"), 0);

            // 서버 측 금액 검증 로직
            long originalAmount = 0L;
            int paymentType = orderId.contains("MOVIE_") ? 0 : 1;

            if (paymentType == 0) { // 영화 예매
                originalAmount = ((ReservationVO) paidItem).getFinalAmount();
            } else { // 스토어 구매
                originalAmount = ((ProductVO) paidItem).getProdPrice();
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
//            System.out.println("  - 서버 측 금액 검증 완료");

            ss = FactoryService.getFactory().openSession(false);
//            System.out.println("✅ 4. 데이터베이스 트랜잭션 시작");

            PaymentVO pvo = new PaymentVO();
            String userIdxStr = (mvo != null) ? mvo.getUserIdx() : null;

            if (userIdxStr != null) pvo.setUserIdx(Long.parseLong(userIdxStr));
            pvo.setOrderId(orderId);
            pvo.setPaymentTransactionId(paymentKey);
            pvo.setPaymentMethod((String) tossPaymentInfo.get("method"));
            pvo.setPaymentFinal((int) amount);
            pvo.setCouponDiscount(couponDiscount);
            pvo.setPointDiscount(usedPoints);
            pvo.setPaymentTotal((int) (amount + couponDiscount + usedPoints));
            pvo.setCouponIdx(couponIdx);

            if (paymentType == 0) {
                pvo.setPaymentType(0);
                ReservationVO reservation = (ReservationVO) paidItem;
                if (mvo != null) {
                    reservation.setUserIdx(Long.parseLong(userIdxStr));
                } else if (nmemvo != null) {
                    long nIdx = Long.parseLong(nmemvo.getnIdx());
                    reservation.setnIdx(nIdx);
                    pvo.setnIdx(nIdx);
                }
//                System.out.println("  - ReservationDAO.insertReservation 호출 전");
                ReservationDAO.insertReservation(reservation, ss);
//                System.out.println("  - ReservationDAO.insertReservation 호출 후");
                pvo.setReservIdx(reservation.getReservIdx());
            } else {
                pvo.setPaymentType(1);
                ProductVO product = (ProductVO) paidItem;
                pvo.setProdIdx(product.getProdIdx());
                if (mvo != null) pvo.setUserIdx(Long.parseLong(userIdxStr));

//                System.out.println("  - ProductDAO.updateProductStock 호출 전");
                Map<String, Object> params = new HashMap<>();
                params.put("prodIdx", product.getProdIdx());
                params.put("quantity", product.getQuantity());
                int updatedRows = ProductDAO.updateProductStock(params, ss);
//                System.out.println("  - ProductDAO.updateProductStock 호출 후");
                if (updatedRows == 0) throw new Exception("상품 재고가 부족합니다.");
            }

//            System.out.println("  - PaymentDAO.addPayment 호출 전");
            PaymentDAO.addPayment(pvo, ss);
//            System.out.println("  - PaymentDAO.addPayment 호출 후, 생성된 paymentIdx: " + pvo.getPaymentIdx());

            if (mvo != null) {
                if (couponUserIdx > 0) {
//                    System.out.println("  - CouponDAO.useCoupon 호출 전");
                    CouponDAO.useCoupon(couponUserIdx, ss);
//                    System.out.println("  - CouponDAO.useCoupon 호출 후");
                }
                if (usedPoints > 0) {
//                    System.out.println("  - PointDAO.usePoints 호출 전");
                    PointDAO.usePoints(Long.parseLong(userIdxStr), usedPoints, pvo.getPaymentIdx(), ss);
//                    System.out.println("  - PointDAO.usePoints 호출 후");
                }
            }

//            System.out.println("✅ 5. 데이터베이스 commit 시도");
            ss.commit();
//            System.out.println("✅ 6. Commit 성공!");

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
//            System.err.println("❌ 오류 발생!: " + e.getMessage());
            e.printStackTrace();
            if (ss != null) {
//                System.err.println("  - 데이터베이스 rollback 실행");
                ss.rollback();
            }

            if (paymentKey != null) {
                try {
//                    System.err.println("  - 토스 결제 취소 API 호출 시도");
                    cancelTossPayment(paymentKey, "서버 내부 오류로 인한 자동 취소");
                } catch (Exception cancelEx) {
//                    System.err.println("  - 토스 결제 취소 중 추가 오류 발생: " + cancelEx.getMessage());
                    cancelEx.printStackTrace();
                }
            }

            request.setAttribute("isSuccess", false);
            String errMsg = e.getMessage();
            if (errMsg == null || errMsg.trim().isEmpty()) {
                errMsg = e.toString();
            }
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + errMsg);
            return "paymentConfirm.jsp";
        } finally {
            if (ss != null) {
//                System.out.println("✅ 7. SqlSession 종료");
                ss.close();
            }
        }
    }

    private JSONObject confirmTossPayment(String paymentKey, String orderId, long amount) throws Exception {
        JSONObject obj = new JSONObject();
        obj.put("orderId", orderId);
        obj.put("amount", amount);
        obj.put("paymentKey", paymentKey);

        String authorizations = "Basic " + Base64.getEncoder().encodeToString((TOSS_SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);

        try (OutputStream outputStream = connection.getOutputStream()) {
            outputStream.write(obj.toString().getBytes("UTF-8"));
        }

        int responseCode = connection.getResponseCode();
        boolean isSuccess = responseCode == 200;

        try (InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
             Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8)) {

            JSONObject jsonResponse = (JSONObject) new JSONParser().parse(reader);

            if (!isSuccess) {
                throw new Exception("Toss API Error: " + jsonResponse.get("message"));
            }
            return jsonResponse;
        }
    }

    private void cancelTossPayment(String paymentKey, String cancelReason) throws Exception {
        URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
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
//                System.err.println("Toss 결제 취소 실패: " + errorResponse.toJSONString());
            }
        } else {
//            System.out.println("  - 토스 결제 취소 성공");
        }
    }

    private long parseLongSafe(String value, long defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Long.parseLong(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private int parseIntSafe(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}