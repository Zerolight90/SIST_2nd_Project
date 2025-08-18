// RefundAction.java

package Action;

import mybatis.Service.FactoryService;
import mybatis.dao.CouponDAO;
import mybatis.dao.PaymentDAO;
import mybatis.dao.PointDAO;
import mybatis.dao.ReservationDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.PaymentVO;
import mybatis.vo.TimeTableVO;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

public class RefundAction implements Action {

    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String paymentKey = request.getParameter("paymentKey");
        String cancelReason = request.getParameter("cancelReason");

        JSONObject jsonResponse = new JSONObject();
        SqlSession ss = null;

        try {
            ss = FactoryService.getFactory().openSession(false); // 트랜잭션 시작

            MemberVO mvo = (MemberVO)request.getSession().getAttribute("mvo");
            if (mvo == null) {
                throw new Exception("로그인이 필요한 서비스입니다.");
            }

            PaymentVO pvo = PaymentDAO.getPaymentByPaymentKey(paymentKey, ss);
            if (pvo == null) {
                throw new Exception("취소할 결제 정보를 찾을 수 없습니다.");
            }

            // MemberVO의 userIdx(String)를 long으로 변환하여 PaymentVO의 userIdx(long)와 비교
            if (pvo.getUserIdx() != Long.parseLong(mvo.getUserIdx())) {
                throw new Exception("본인의 결제 내역만 취소할 수 있습니다.");
            }

            // 서버단에서 환불 마감 시간 검증
            if (pvo.getPaymentType() == 0 && pvo.getReservIdx() != null) {
                TimeTableVO tvo = ReservationDAO.getScreeningTimeByReservIdx(pvo.getReservIdx(), ss);
                if (tvo != null && tvo.getStartTime() != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date screeningDateTime = sdf.parse(tvo.getStartTime());
                    long screeningTime = screeningDateTime.getTime();
                    long cancellationDeadline = screeningTime - (30 * 60 * 1000); // 상영 30분 전
                    long now = System.currentTimeMillis();

//                    if (now > cancellationDeadline) {
//                        throw new Exception("상영 30분 전까지만 취소가 가능합니다.");
//                    }
                }
            }

            // 1. 토스페이먼츠 환불 API 호출
            cancelTossPayment(paymentKey, cancelReason);

            // 2. DB 처리
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
            if (ss != null) {
                ss.rollback();
            }
            jsonResponse.put("isSuccess", false);
            jsonResponse.put("errorMessage", e.getMessage());
            e.printStackTrace();
        } finally {
            if (ss != null) {
                ss.close();
            }
        }

        // 클라이언트에 JSON 응답 전송
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            response.getWriter().write(jsonResponse.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
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
                throw new Exception("Toss API Error: " + errorResponse.get("message"));
            }
        }
    }
}