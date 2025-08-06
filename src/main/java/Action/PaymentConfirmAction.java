package Action;

import mybatis.dao.CouponDAO;
import mybatis.dao.PaymentDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.MyCouponVO;
import mybatis.vo.PaymentVO;
import mybatis.vo.ReservationVO;
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

        // 1. 세션에서 로그인 정보 및 임시 예매 정보 가져오기
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");

        ReservationVO tempReservation = (ReservationVO) session.getAttribute("reservationInfoForPayment");

        // 세션 정보가 없는 경우 (예: 시간이 너무 오래 지남)
        if (tempReservation == null) {
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 정보가 만료되었습니다. 다시 시도해 주세요.");
            return "paymentConfirm.jsp";
        }

        // 2. URL 파라미터 받기
        String paymentKey = request.getParameter("paymentKey");
        String orderId = request.getParameter("orderId");
        long amount = Long.parseLong(request.getParameter("amount")); // 최종 결제 금액
        long couponUserIdx = Long.parseLong(request.getParameter("couponUserIdx"));
        int usedPoints = Integer.parseInt(request.getParameter("usedPoints"));

        try {
            // 3. 토스페이먼츠 결제 승인 API 호출
            String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
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
            // 4-1. 세션의 예매 정보를 reservation 테이블에 INSERT 하고, 생성된 reservIdx 받기
            long newReservIdx = ReservationDAO.insertReservation(tempReservation);

            // 4-2. 사용한 쿠폰이 있다면 할인액 조회
            int couponDiscount = 0;
            if (couponUserIdx > 0) {
                MyCouponVO coupon = CouponDAO.getCouponByCouponUserIdx(couponUserIdx);
                if (coupon != null) {
                    couponDiscount = coupon.getCouponValue();
                }
            }

            // 4-3. payment 테이블에 결제 정보 저장
            PaymentVO pvo = new PaymentVO();
            pvo.setReservIdx(newReservIdx);
            pvo.setOrderId(orderId);
            pvo.setPaymentTransactionId(paymentKey);
            pvo.setPaymentMethod((String) tossResponse.get("method"));
            pvo.setPaymentFinal((int) amount);
            pvo.setCouponDiscount(couponDiscount);
            pvo.setPointDiscount(usedPoints);
            pvo.setPaymentTotal((int)amount + couponDiscount + usedPoints); // 원금 계산
            pvo.setCouponUserIdx(couponUserIdx > 0 ? couponUserIdx : null);
            long paymentIdx = PaymentDAO.addPayment(pvo); // 수정된 addPayment 메소드 사용

            // 4-4. 사용한 쿠폰 상태 변경
            if (couponUserIdx > 0) {
                CouponDAO.useCoupon(couponUserIdx);
            }

            // 4-5. 사용한 포인트 차감 및 내역 기록
            if (usedPoints > 0) {
            }

            // 5. 최종 확인 페이지(JSP)로 정보 전달
            request.setAttribute("isSuccess", true);
            request.setAttribute("paymentType", "paymentMovie");
            request.setAttribute("tossResponse", tossResponse); // 토스로부터 받은 최종 응답
            request.setAttribute("paidReservation", tempReservation); // 화면 표시를 위해 세션의 정보 재사용
            request.setAttribute("couponDiscount", couponDiscount); // 할인된 쿠폰 금액 전달
            request.setAttribute("pointDiscount", usedPoints); // 사용된 포인트 전달

            // 6. 사용 완료된 임시 예매 정보 세션에서 제거
            session.removeAttribute("reservationInfoForPayment");

            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 서버 오류가 발생했습니다: " + e.getMessage());
            return "paymentConfirm.jsp";
        }
    }
}