package Action;

import mybatis.Service.FactoryService;
import mybatis.dao.CouponDAO;
import mybatis.dao.PaymentDAO;
import mybatis.dao.PointDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.PaymentVO;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class RefundAction implements Action {

    private static final String TOSS_SECRET_KEY = "test_sk_d46qopOB89ZPBdzwDdQO3ZmM75y0";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String paymentKey = request.getParameter("paymentKey");
        String cancelReason = request.getParameter("cancelReason");

        JSONObject jsonResponse = new JSONObject();
        SqlSession ss = null;

        try {
            // 1. 토스페이먼츠 환불 API 호출
             cancelTossPayment(paymentKey, cancelReason);

            // 2. DB 처리 (트랜잭션 시작)
            ss = FactoryService.getFactory().openSession(false);

            // ## 수정된 부분: 모든 DAO 호출에 ss 객체 전달 ##
            PaymentVO pvo = PaymentDAO.getPaymentByPaymentKey(paymentKey, ss);
            if (pvo == null) {
                throw new Exception("취소할 결제 정보를 찾을 수 없습니다.");
            }

            PaymentDAO.updatePaymentToCancelled(paymentKey, ss);

            if (pvo.getReservIdx() != null) {
                ReservationDAO.updateReservationToCancelled(pvo.getReservIdx(), ss);
            }
            if (pvo.getCouponUserIdx() != null) {
                CouponDAO.revertCouponUsage(pvo.getCouponUserIdx(), ss);
            }
            if (pvo.getPointDiscount() > 0) {
                PointDAO.revertPointUsage(pvo.getUserIdx(), pvo.getPointDiscount(), pvo.getPaymentIdx(), ss);
            }

            ss.commit();

            jsonResponse.put("isSuccess", true);

        } catch (Exception e) {
            if (ss != null) ss.rollback();
            jsonResponse.put("isSuccess", false);
            jsonResponse.put("errorMessage", e.getMessage());
            e.printStackTrace();
        } finally {
            if (ss != null) ss.close();
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            response.getWriter().write(jsonResponse.toJSONString());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    /**
     * 토스페이먼츠에 결제 취소(환불)를 요청하는 메소드
     */
    private void cancelTossPayment(String paymentKey, String cancelReason) throws Exception {
        URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        // Base64 인코딩된 시크릿 키를 헤더에 추가
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
        // API 호출 실패 시 예외 발생
        if (responseCode != 200) {
            try (InputStream errorStream = connection.getErrorStream();
                 Reader reader = new InputStreamReader(errorStream, StandardCharsets.UTF_8)) {
                JSONObject errorResponse = (JSONObject) new JSONParser().parse(reader);
                throw new Exception("Toss API Error: " + errorResponse.get("message"));
            }
        }
    }
}