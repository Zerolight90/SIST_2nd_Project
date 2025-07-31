package Action;

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
        try {
            request.setCharacterEncoding("UTF-8");

            // 1. Toss Payments로부터 받은 파라미터
            String orderId = request.getParameter("orderId");
            String paymentKey = request.getParameter("paymentKey");
            String amount = request.getParameter("amount");

            // 로그 추가: 파라미터 확인 (디버깅용)
            System.out.println("PaymentConfirmAction: orderId=" + orderId + ", paymentKey=" + paymentKey + ", amount=" + amount);


            // 2. 결제 승인 API 호출
            String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6"; // 테스트 시크릿 키
            String keyColon = secretKey + ":";
            String authorizations = "Basic " + Base64.getEncoder().encodeToString(keyColon.getBytes(StandardCharsets.UTF_8));

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
            outputStream.flush(); // outputStream.close() 대신 flush()만 할 수도 있음

            int code = connection.getResponseCode();
            boolean isSuccess = (code == 200);

            // 응답 스트림 읽기
            BufferedReader reader;
            if (isSuccess) {
                reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
            } else {
                reader = new BufferedReader(new InputStreamReader(connection.getErrorStream(), StandardCharsets.UTF_8));
            }
            JSONParser parser = new JSONParser();
            JSONObject resObj = (JSONObject) parser.parse(reader);
            reader.close(); // BufferedReader도 닫아줘야 함

            // 로그 추가: Toss Payments 응답 확인 (디버깅용)
            System.out.println("Toss Payments Response: " + resObj.toJSONString());

            // 3. 결제 타입 구분 및 DB 저장 로직
            String paymentTypeForView = "pay_movie";

            if (isSuccess) {
                String orderName = resObj.get("orderName").toString();
                PaymentVO vo = new PaymentVO();

                if (orderName.endsWith("구매")) {
                    paymentTypeForView = "pay_store";
                    vo.setPaymentType(2); // 2: 상품
                    // 실제 product 테이블에 있는 ID로 설정 (임시)
                    vo.setProductIdx(1); // 이 부분은 실제 상품 ID로 교체 필요!
                } else {
                    paymentTypeForView = "pay_movie";
                    vo.setPaymentType(1); // 1: 영화
                    vo.setReservationIdx(100L); // 이 부분은 실제 예약 ID로 교체 필요!
                }

                // 임시 테스트용 userIdx 설정
                vo.setUserIdx(1L); // 로그인된 사용자 ID로 교체 필요!

                // 공통 정보 설정
                vo.setOrderId(resObj.get("orderId").toString());
                vo.setPaymentTransactionId(resObj.get("paymentKey").toString());
                vo.setPaymentMethod(resObj.get("method").toString());
                vo.setPaymentFinal(Integer.parseInt(resObj.get("totalAmount").toString()));

                int dbResult = PaymentDAO.addPayment(vo);

                // 로그 추가: DB 저장 결과 (디버깅용)
                System.out.println("DB Save Result: " + (dbResult > 0 ? "Success" : "Fail"));

            }

            // 4. JSTL에서 사용할 수 있도록 request에 데이터 저장
            request.setAttribute("isSuccess", isSuccess);
            request.setAttribute("paymentType", paymentTypeForView);
            request.setAttribute("resObj", resObj); // Toss Payments 응답 객체를 그대로 전달

            // 성공 페이지로 포워딩
            return "paymentConfirm.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 처리
            request.setAttribute("isSuccess", false);
            request.setAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
            // 에러 페이지로 포워딩 (paymentFail.jsp가 있다면 해당 경로로)
            return "paymentFail.jsp"; // 또는 오류 메시지를 표시할 다른 JSP 페이지
        }
    }
}