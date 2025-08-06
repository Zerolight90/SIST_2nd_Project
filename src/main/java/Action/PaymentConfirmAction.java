package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.PaymentDAO;

import mybatis.dao.PointDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.*;
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

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();

        // 1. 세션에서 로그인 정보 및 임시 결제 정보 가져오기
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
        String userIdx = (mvo == null) ? String.valueOf(1L) : mvo.getUserIdx();

        ReservationVO tempReservation = (ReservationVO) session.getAttribute("reservationInfoForPayment");
        ProductVO tempProduct = (ProductVO) session.getAttribute("productInfoForPayment");

        String paymentType = "";
        Object paidItem;

        if (tempReservation != null) {
            paymentType = "paymentMovie";
            paidItem = tempReservation;
        } else if (tempProduct != null) {
            paymentType = "paymentStore";
            paidItem = tempProduct;
        } else {
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 정보가 만료되었습니다. 다시 시도해 주세요.");
            return "paymentConfirm.jsp";
        }

        // 2. URL 파라미터 받기
        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        long amount = Long.parseLong(request.getParameter("amount"));
        long couponUserIdx = Long.parseLong(request.getParameter("couponUserIdx"));
        int usedPoints = Integer.parseInt(request.getParameter("usedPoints"));

        try {
            // 3. 토스페이먼츠 결제 승인 API 호출
            String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6"; // 본인 키로 변경
            Base64.Encoder encoder = Base64.getEncoder();
            byte[] encodedBytes = encoder.encode((secretKey + ":").getBytes(StandardCharsets.UTF_8));
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
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(obj.toString().getBytes(StandardCharsets.UTF_8));
            int code = connection.getResponseCode();
            boolean isSuccess = code == 200;
            InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
            Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
            JSONParser parser = new JSONParser();
            JSONObject tossResponse = (JSONObject) parser.parse(reader);
            responseStream.close();

            if (!isSuccess) {
                request.setAttribute("isSuccess", false);
                request.setAttribute("errorMessage", (String) tossResponse.get("message"));
                return "paymentConfirm.jsp";
            }

            // 4. 결제 성공 시 DB 처리

            int couponDiscount = 0;
            if (couponUserIdx > 0) {
                MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx);
                if (coupon != null) couponDiscount = coupon.getCouponValue();
            }

            PaymentVO pvo = new PaymentVO();
            pvo.setUserIdx(Long.parseLong(userIdx));
            pvo.setOrderId(orderId);
            pvo.setPaymentTransactionId(paymentKey);
            pvo.setPaymentMethod((String) tossResponse.get("method"));
            pvo.setPaymentFinal((int) amount);
            pvo.setCouponDiscount(couponDiscount);
            pvo.setPointDiscount(usedPoints);
            pvo.setPaymentTotal((int)amount + couponDiscount + usedPoints);
            pvo.setCouponUserIdx(couponUserIdx > 0 ? couponUserIdx : null);

            if (paymentType.equals("paymentMovie")) {
                ReservationVO reservation = (ReservationVO) paidItem;
                reservation.setUserIdx(Long.parseLong(userIdx));
                long newReservIdx = ReservationDAO.insertReservation(reservation);
                pvo.setReservIdx(newReservIdx);
            } else { // paymentStore
                ProductVO product = (ProductVO) paidItem;
                pvo.setProdIdx(product.getProdIdx());
            }

            long paymentIdx = PaymentDAO.addPayment(pvo);

            if (couponUserIdx > 0) {
                CouponDAO.useCoupon(couponUserIdx);
            }

            if (usedPoints > 0) {
                PointDAO.usePoints(Long.parseLong(userIdx), usedPoints, paymentIdx);
            }

            // 5. 최종 확인 페이지(JSP)로 정보 전달
            request.setAttribute("isSuccess", true);
            request.setAttribute("paymentType", paymentType); // [수정] 올바른 paymentType 변수 사용
            request.setAttribute("tossResponse", tossResponse);
            request.setAttribute("paidItem", paidItem);
            request.setAttribute("couponDiscount", couponDiscount);
            request.setAttribute("pointDiscount", usedPoints);

            // 6. 사용 완료된 임시 정보 세션에서 제거
            if (paymentType.equals("paymentMovie")) {
                session.removeAttribute("reservationInfoForPayment");
            } else {
                session.removeAttribute("productInfoForPayment");
            }
            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 서버 오류가 발생했습니다: " + e.getMessage());
            return "paymentConfirm.jsp";
        }
    }
}