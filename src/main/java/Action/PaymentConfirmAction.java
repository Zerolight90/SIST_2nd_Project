package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.PaymentDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.PaymentVO;
import mybatis.vo.ReservationVO;
import mybatis.vo.MemberVO;

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
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
        if (mvo == null) {
            return "Controller?type=loginPage";
        }
        long userIdx = Long.parseLong(mvo.getUserIdx());

        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        long amount = Long.parseLong(request.getParameter("amount"));
        long couponUserIdx = Long.parseLong(request.getParameter("couponUserIdx"));

        try {
            // 1. 토스페이먼츠 결제 승인 API 호출
            String secretKey = "test_sk_E92LAa5PVbNq5g2vNlrG8pWDOxmA"; // 실제 키로 변경
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
                request.setAttribute("errorMessage", (String) tossResponse.get("message"));
                request.setAttribute("isSuccess", false);
                return "paymentConfirm.jsp";
            }

            // 2. 결제 성공 시 DB 처리
            String orderName = (String) tossResponse.get("orderName");
            long reservIdx = Long.parseLong(orderName.split("_")[1]);

            // 2-1. payment 테이블에 결제 정보 저장
            PaymentVO pvo = new PaymentVO();
            pvo.setUserIdx(userIdx);
            pvo.setReservIdx(reservIdx);
            pvo.setPaymentType(0); // 영화
            pvo.setOrderId(orderId);
            pvo.setPaymentTransactionId(paymentKey);
            pvo.setPaymentMethod((String) tossResponse.get("method"));

            int finalAmount = ((Long) tossResponse.get("totalAmount")).intValue();
            int originalAmount = ReservationDAO.getReservationDetails(reservIdx).getFinalAmount();

            pvo.setPaymentFinal(finalAmount);
            pvo.setPaymentTotal(originalAmount);
            pvo.setCouponDiscount(originalAmount - finalAmount);
            pvo.setCouponUserIdx(couponUserIdx > 0 ? couponUserIdx : null);

            PaymentDAO.addPayment(pvo);

            // 2-2. 사용한 쿠폰 상태 변경
            if (couponUserIdx > 0) {
                CouponDAO.useCoupon((int) couponUserIdx);
            }

            // 2-3. 예매 테이블 상태 '결제완료'로 변경
            ReservationDAO.updateStatusToPaid(reservIdx);

            // 3. 최종 확인 페이지로 정보 전달
            ReservationVO paidReservation = ReservationDAO.getReservationDetails(reservIdx);

            request.setAttribute("isSuccess", true);
            request.setAttribute("paymentType", "paymentMovie");
            request.setAttribute("tossResponse", tossResponse); // 토스 응답
            request.setAttribute("paidReservation", paidReservation); // 최종 예매 정보

            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 서버 오류가 발생했습니다.");
            return "paymentConfirm.jsp";
        }
    }
}