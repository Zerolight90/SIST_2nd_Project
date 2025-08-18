package Action;

import mybatis.Service.FactoryService;
import mybatis.dao.CouponDAO;
import mybatis.dao.PaymentDAO;
import mybatis.dao.PointDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyCouponVO;
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

public class PaymentConfirmAction implements Action {

    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        SqlSession ss = null;

        // --- 필수 정보 확인 및 파라미터 수신 ---
        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        if (mvo == null) {
            return "error.jsp";
        }
        String userIdx = mvo.getUserIdx();

        Object paidItem = session.getAttribute("reservationInfoForPayment");
        String paymentType = "paymentMovie";
        if (paidItem == null) {
            paidItem = session.getAttribute("productInfoForPayment");
            paymentType = "paymentStore";
        }

        if (paidItem == null) {
            request.setAttribute("errorMessage", "결제 정보가 만료되었습니다. 다시 시도해 주세요.");
            return "paymentConfirm.jsp";
        }

        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        long amount = Long.parseLong(request.getParameter("amount"));
        long couponUserIdx = Long.parseLong(request.getParameter("couponUserIdx"));
        int usedPoints = Integer.parseInt(request.getParameter("usedPoints"));


        try {
            // --- 토스페이먼츠 결제 최종 승인 API 호출 ---
            JSONObject tossResponse = confirmTossPayment(paymentKey, orderId, amount);

            long approvedAmount = (long) tossResponse.get("totalAmount");
            if (amount != approvedAmount) {
                throw new Exception("결제 금액 불일치 (요청: " + amount + ", 승인: " + approvedAmount + ")");
            }

            // --- 데이터베이스 처리 (트랜잭션 시작) ---
            ss = FactoryService.getFactory().openSession(false);

            int couponDiscount = 0;
            if (couponUserIdx > 0) {
                MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx, ss);
                if (coupon != null) couponDiscount = coupon.getCouponValue();
            }

            PaymentVO pvo = createPaymentVO(tossResponse, userIdx, orderId, couponUserIdx, usedPoints, couponDiscount);

            pvo.setPaymentType("paymentMovie".equals(paymentType) ? 0 : 1);

            if ("paymentMovie".equals(paymentType)) {
                ReservationVO reservation = (ReservationVO) paidItem;
                reservation.setUserIdx(Long.parseLong(userIdx));
                long newReservIdx = ReservationDAO.insertReservation(reservation, ss);
                pvo.setReservIdx(newReservIdx);
            } else {
                ProductVO product = (ProductVO) paidItem;
                pvo.setProdIdx(product.getProdIdx());
            }

            long paymentIdx = PaymentDAO.addPayment(pvo, ss);

            if (couponUserIdx > 0) {
                CouponDAO.useCoupon(couponUserIdx, ss);
            }
            if (usedPoints > 0) {
                PointDAO.usePoints(Long.parseLong(userIdx), usedPoints, paymentIdx, ss);
            }

            ss.commit();

            // --- 최종 결과 페이지로 정보 전달 ---
            request.setAttribute("isSuccess", true);
            request.setAttribute("paymentType", paymentType);
            request.setAttribute("tossResponse", tossResponse);
            request.setAttribute("paidItem", paidItem);
            request.setAttribute("couponDiscount", couponDiscount);
            request.setAttribute("pointDiscount", usedPoints);

            // --- 사용 완료된 세션 정보 제거 ---
            session.removeAttribute("reservationInfoForPayment");
            session.removeAttribute("productInfoForPayment");

            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            if (ss != null) {
                ss.rollback();
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
     * Toss Payments API에 결제 승인을 요청하고 결과를 반환
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
            JSONObject tossResponse = (JSONObject) parser.parse(reader);

            if (!isSuccess) {
                throw new Exception((String) tossResponse.get("message"));
            }
            return tossResponse;
        }
    }

    /**
     * 응답 데이터와 파라미터를 바탕으로 PaymentVO 객체를 생성하고 초기화
     */
    private PaymentVO createPaymentVO(JSONObject tossResponse, String userIdx, String orderId, long couponUserIdx, int usedPoints, int couponDiscount) {
        PaymentVO pvo = new PaymentVO();
        pvo.setUserIdx(Long.parseLong(userIdx));
        pvo.setOrderId(orderId);
        pvo.setPaymentTransactionId((String) tossResponse.get("paymentKey"));
        pvo.setPaymentMethod((String) tossResponse.get("method"));
        pvo.setPaymentFinal(((Long) tossResponse.get("totalAmount")).intValue());
        pvo.setCouponDiscount(couponDiscount);
        pvo.setPointDiscount(usedPoints);
        pvo.setPaymentTotal(pvo.getPaymentFinal() + couponDiscount + usedPoints);
        pvo.setCouponUserIdx(couponUserIdx > 0 ? couponUserIdx : null);
        return pvo;
    }
}