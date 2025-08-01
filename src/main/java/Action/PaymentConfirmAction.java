package Action;

import mybatis.dao.CouponDAO; // CouponDAO import 추가
import mybatis.dao.PaymentDAO;
import mybatis.vo.PaymentVO;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class PaymentConfirmAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String paymentTypeForView = ""; // 뷰 구분을 위한 변수

        try {
            request.setCharacterEncoding("UTF-8");

            // 1. Toss Payments로부터 받은 파라미터 + JSP에서 넘겨준 쿠폰 ID
            String orderId = request.getParameter("orderId");
            String paymentKey = request.getParameter("paymentKey");
            String amount = request.getParameter("amount");
            int couponUserIdx = Integer.parseInt(request.getParameter("couponUserIdx")); // 쿠폰 ID 받기

            // 2. 결제 승인 API 호출 (기존과 동일)
            String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
            String authorizations = "Basic " + Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

            URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestProperty("Authorization", authorizations);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);

            JSONObject reqObj = new JSONObject();
            reqObj.put("paymentKey", paymentKey);
            reqObj.put("orderId", orderId);
            reqObj.put("amount", Integer.parseInt(amount));

            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(reqObj.toString().getBytes("UTF-8"));
            outputStream.flush();

            int code = connection.getResponseCode();
            boolean isSuccess = (code == 200);

            BufferedReader reader = new BufferedReader(new InputStreamReader(isSuccess ? connection.getInputStream() : connection.getErrorStream(), StandardCharsets.UTF_8));
            JSONParser parser = new JSONParser();
            JSONObject resObj = (JSONObject) parser.parse(reader);
            reader.close();

            // 3. 결제 성공 시 DB 저장 로직
            if (isSuccess) {
                PaymentVO vo = new PaymentVO();
                String resOrderId = resObj.get("orderId").toString();
                String resOrderName = resObj.get("orderName").toString();

                // 🔴 수정: orderId의 접두사로 영화/스토어 구분
                if (resOrderId.startsWith("SIST_STORE_")) {
                    paymentTypeForView = "paymentStore";
                    vo.setPaymentType(2); // 2: 상품

                    // 🔴 수정: orderName에서 실제 상품 ID 추출 (예: "상품명_1" -> 1)
                    String productIdxStr = resOrderName.substring(resOrderName.lastIndexOf("_") + 1);
                    vo.setProductIdx(Integer.parseInt(productIdxStr));

                } else if (resOrderId.startsWith("SIST_MOVIE_")) {
                    paymentTypeForView = "paymentMovie";
                    vo.setPaymentType(1); // 1: 영화

                    // 🔴 수정: orderName에서 실제 예매 ID 추출 (예: "영화제목_1" -> 1)
                    String reservIdxStr = resOrderName.substring(resOrderName.lastIndexOf("_") + 1);
                    vo.setReservationIdx(Long.parseLong(reservIdxStr));
                }

                // 🔴 수정: 쿠폰 사용 정보 저장 및 처리
                if (couponUserIdx > 0) {
                    vo.setCouponUserIdx(couponUserIdx);
                    // (심화) 실제 할인액을 DB에서 조회하여 vo.setCouponDiscount()에 저장할 수 있음
                    CouponDAO.useCoupon(couponUserIdx); // 쿠폰 상태를 '사용 완료'로 변경
                }

                // 공통 정보 설정
                vo.setUserIdx(1L); // TODO: 실제 로그인된 사용자 ID로 교체 필요
                vo.setOrderId(resOrderId);
                vo.setPaymentTransactionId(resObj.get("paymentKey").toString());
                vo.setPaymentMethod(resObj.get("method").toString());
                vo.setPaymentFinal(Integer.parseInt(resObj.get("totalAmount").toString()));
                // (심화) 할인액, 할인 전 금액 계산 로직 추가...

                PaymentDAO.addPayment(vo);
            }

            // 4. JSTL에서 사용할 수 있도록 request에 데이터 저장
            request.setAttribute("isSuccess", isSuccess);
            request.setAttribute("paymentType", paymentTypeForView); // 🔴 올바르게 구분된 paymentType 전달
            request.setAttribute("resObj", resObj);

            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "paymentConfirm.jsp"; // 에러 발생 시에도 paymentConfirm.jsp로 포워딩하여 실패 화면 표시
        }
    }
}