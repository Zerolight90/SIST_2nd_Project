package Action;

import mybatis.Service.FactoryService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;

public class RefundAction implements Action {

    // IMPORTANT: 실제 서비스에서는 이 Secret Key를 환경 변수나 외부 설정 파일로 관리해야 합니다.
    private static final String TOSS_SECRET_KEY = "test_sk_d46qopOB89ZPBdzwDdQO3ZmM75y0:"; // 여기에 실제 토스 Secret Key를 입력하세요.

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;

        String paymentKey = request.getParameter("paymentKey"); // paymentTransactionId
        String cancelReason = request.getParameter("cancelReason");

        if (paymentKey == null || paymentKey.isEmpty()) {
            request.setAttribute("errorMessage", "환불할 결제 정보(paymentKey)가 없습니다.");
            return "/WEB-INF/views/error.jsp";
        }
        if (cancelReason == null || cancelReason.isEmpty()) {
            cancelReason = "고객 요청";
        }

        boolean refundSuccess = false;
        String apiResponseStatus = "FAILED";
        String apiResponseMessage = "알 수 없는 오류가 발생했습니다.";
        int cancelAmount = 0; // 토스 API 응답에서 추출된 환불 금액

        try {
            // 1. 토스 API 호출
            String tossApiUrl = "https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel";
            String encodedAuth = "Basic " + Base64.getEncoder().encodeToString((TOSS_SECRET_KEY + ":").getBytes());

            URL url = new URL(tossApiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", encodedAuth);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            JSONObject requestBody = new JSONObject();
            requestBody.put("cancelReason", cancelReason);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = requestBody.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            StringBuilder responseBody = new StringBuilder();

            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(
                            responseCode >= 200 && responseCode < 300 ? conn.getInputStream() : conn.getErrorStream(), "utf-8"))) {
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    responseBody.append(responseLine.trim());
                }
            }

            JSONParser parser = new JSONParser();
            JSONObject jsonObject = (JSONObject) parser.parse(responseBody.toString());

            if (responseCode >= 200 && responseCode < 300) {
                String status = (String) jsonObject.get("status");
                if ("CANCELED".equals(status)) {
                    refundSuccess = true;
                    apiResponseStatus = "SUCCESS";
                    apiResponseMessage = "환불이 성공적으로 처리되었습니다.";

                    if (jsonObject.containsKey("cancels")) {
                        JSONArray cancelsArray = (JSONArray) jsonObject.get("cancels");
                        if (cancelsArray != null && !cancelsArray.isEmpty()) {
                            JSONObject firstCancel = (JSONObject) cancelsArray.get(0);
                            Long amount = (Long) firstCancel.get("cancelAmount");
                            if (amount != null) {
                                cancelAmount = amount.intValue();
                            }
                        }
                    }

                } else {
                    apiResponseStatus = status != null ? status : "UNKNOWN_STATUS";
                    apiResponseMessage = "토스 환불 처리 중 예상치 못한 상태: " + jsonObject.get("message");
                }
            } else {
                apiResponseStatus = "API_ERROR";
                apiResponseMessage = "토스 API 호출 실패 (HTTP " + responseCode + "): " + jsonObject.get("message");
                if (jsonObject.containsKey("code") && jsonObject.containsKey("message")) {
                    apiResponseMessage += " (Code: " + jsonObject.get("code") + ", Message: " + jsonObject.get("message") + ")";
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            apiResponseStatus = "SYSTEM_ERROR";
            apiResponseMessage = "환불 처리 중 시스템 오류가 발생했습니다: " + e.getMessage();
        }

        // 2. 데이터베이스 업데이트 (Payment 테이블 하나만 사용)
        SqlSession session = null;
        try {
            session = FactoryService.getFactory().openSession();

            Map<String, Object> params = new HashMap<>();
            params.put("paymentKey", paymentKey); // paymentTransactionId
            // paymentStatus 0: 완료, 1: 취소
            params.put("paymentStatus", refundSuccess ? 1 : 0); // 성공 시 1(취소)로 업데이트
            params.put("paymentCancelDate", refundSuccess ? new java.util.Date() : null); // 성공 시 취소일 업데이트

            // Payment 테이블의 상태 및 취소일 업데이트
            // Mapper namespace와 id는 PaymentMapper.xml에 정의된 것과 일치해야 합니다.
            session.update("payment.updatePaymentStatusAndCancelDate", params);

            session.commit();
        } catch (Exception e) {
            if (session != null) {
                session.rollback();
            }
            e.printStackTrace();
            request.setAttribute("errorMessage", "데이터베이스 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "/WEB-INF/views/error.jsp";
        } finally {
            if (session != null) {
                session.close();
            }
        }

        // 3. 요청 속성 설정 및 뷰 경로 반환 (JSP에서 표시될 정보)
        request.setAttribute("refundSuccess", refundSuccess);
        request.setAttribute("paymentKey", paymentKey);
        request.setAttribute("cancelReason", cancelReason);
        request.setAttribute("refundAmount", cancelAmount); // 실제 환불된 금액
        request.setAttribute("apiResponseStatus", apiResponseStatus);
        request.setAttribute("apiResponseMessage", apiResponseMessage);

        viewPath = "./jsp/refundResult.jsp";
        return viewPath;
    }
}