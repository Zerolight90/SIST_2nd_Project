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

/**
 * 토스페이먼츠 결제 승인을 처리하는 Action 클래스
 * 회원과 비회원의 결제를 분기하여 처리합니다.
 */
public class PaymentConfirmAction implements Action {

    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        SqlSession ss = null;

        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        long amount = Long.parseLong(request.getParameter("amount"));
        long couponUserIdx = Long.parseLong(request.getParameter("couponUserIdx"));
        int usedPoints = Integer.parseInt(request.getParameter("usedPoints"));

        MemberVO mvo = (MemberVO) session.getAttribute("mvo");
        Object paidItem = session.getAttribute("reservationInfoForPayment");
        String paymentType = (paidItem instanceof ReservationVO) ? "paymentMovie" : "paymentStore";

        try {
            // --- 토스페이먼츠 결제 최종 승인 API 호출 ---
            JSONObject tossResponse = confirmTossPayment(paymentKey, orderId, amount);

            long approvedAmount = (long) tossResponse.get("totalAmount");
            if (amount != approvedAmount) {
                throw new Exception("결제 금액 불일치 (요청: " + amount + ", 승인: " + approvedAmount + ")");
            }

            // --- 데이터베이스 처리 (트랜잭션 시작) ---
            ss = FactoryService.getFactory().openSession(false);

            PaymentVO pvo;
            int couponDiscount = 0;

            // --- 회원/비회원 분기 처리 ---
            if (mvo != null) {
                // [회원]
                String userIdx = mvo.getUserIdx();
                if (couponUserIdx > 0) {
                    MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx, ss);
                    if (coupon != null) couponDiscount = coupon.getCouponValue();
                }

                pvo = createPaymentVO(tossResponse, userIdx, orderId, couponUserIdx, usedPoints, couponDiscount);
                pvo.setPaymentType(0); // 영화 예매

                ReservationVO reservation = (ReservationVO) paidItem;
                reservation.setUserIdx(Long.parseLong(userIdx));
                long newReservIdx = ReservationDAO.insertReservation(reservation, ss);
                pvo.setReservIdx(newReservIdx);

                long paymentIdx = PaymentDAO.addPayment(pvo, ss);

                if (couponUserIdx > 0) CouponDAO.useCoupon(couponUserIdx, ss);
                if (usedPoints > 0) PointDAO.usePoints(Long.parseLong(userIdx), usedPoints, paymentIdx, ss);

            } else {
                // [비회원]
                Map<String, String> nmemInfo = (Map<String, String>) session.getAttribute("nmemInfoForPayment");

                // 1. 비회원 정보 DB에 저장
                NmemVO nvo = new NmemVO();
                nvo.setName(nmemInfo.get("name"));
                nvo.setPhone(nmemInfo.get("phone"));
                nvo.setPassword(nmemInfo.get("password"));
                NmemDAO.insertNmember(nvo, ss);
                long newNIdx = nvo.getnIdx();

                // 2. 결제 정보 생성 (할인 없음)
                pvo = createPaymentVO(tossResponse, null, orderId, 0, 0, 0);
                pvo.setPaymentType(0); // 영화 예매
                pvo.setnIdx(newNIdx); // nIdx 설정

                // 3. 예매 정보 생성 및 nIdx 연결
                ReservationVO reservation = (ReservationVO) paidItem;
                reservation.setnIdx2(newNIdx);
                long newReservIdx = ReservationDAO.insertReservation(reservation, ss);
                pvo.setReservIdx(newReservIdx);

                // 4. 최종 결제 정보 저장
                PaymentDAO.addPayment(pvo, ss);
            }

            ss.commit();

            // --- 최종 결과 페이지로 정보 전달 ---
            request.setAttribute("isSuccess", true);
            request.setAttribute("isGuest", (mvo == null));
            request.setAttribute("paymentType", paymentType);
            request.setAttribute("tossResponse", tossResponse);
            request.setAttribute("paidItem", paidItem);
            request.setAttribute("couponDiscount", couponDiscount);
            request.setAttribute("pointDiscount", usedPoints);

            // --- 사용 완료된 세션 정보 제거 ---
            session.removeAttribute("reservationInfoForPayment");
            session.removeAttribute("productInfoForPayment");
            session.removeAttribute("nmemInfoForPayment");

            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            if (ss != null) ss.rollback();
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "paymentConfirm.jsp";
        } finally {
            if (ss != null) ss.close();
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
            return (JSONObject) parser.parse(reader);
        }
    }

    /**
     * 응답 데이터와 파라미터를 바탕으로 PaymentVO 객체를 생성하고 초기화
     */
    private PaymentVO createPaymentVO(JSONObject tossResponse, String userIdx, String orderId, long couponUserIdx, int usedPoints, int couponDiscount) {
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
        pvo.setCouponUserIdx(couponUserIdx > 0 ? couponUserIdx : null);
        return pvo;
    }
}