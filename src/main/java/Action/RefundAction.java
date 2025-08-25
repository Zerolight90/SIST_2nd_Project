package Action;

import mybatis.Service.FactoryService;
import mybatis.dao.*;
import mybatis.vo.MemberVO;
import mybatis.vo.PaymentVO;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class RefundAction implements Action {

    // ▼▼▼ [수정] ConfigUtil을 사용하도록 변경 (다른 파일과 통일) ▼▼▼
    private static final String TOSS_SECRET_KEY = util.ConfigUtil.getProperty("toss.secret.key");

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // ▼▼▼ [수정] JSON 응답을 위한 설정 추가 ▼▼▼
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();
        // ▲▲▲ [수정] 여기까지 ▲▲▲

        String paymentKey = request.getParameter("paymentKey");
        String cancelReason = request.getParameter("cancelReason");
        String isNonMember = request.getParameter("isNonMember");

        SqlSession ss = null;

        try {
            ss = FactoryService.getFactory().openSession(false); // 트랜잭션 시작

            PaymentVO pvo = PaymentDAO.getPaymentByPaymentKey(paymentKey, ss);
            if (pvo == null) {
                throw new Exception("취소할 결제 정보를 찾을 수 없습니다.");
            }

            // ... (기존의 회원/비회원 검증 로직은 그대로 유지) ...
            if ("true".equals(isNonMember)) {
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String orderId = request.getParameter("orderId");
                String password = request.getParameter("password");
                Map<String, String> params = new HashMap<>();
                params.put("name", name);
                params.put("phone", phone);
                params.put("orderId", orderId);
                params.put("password", password);
                PaymentVO nonMemberHistory = PaymentDAO.getNmemPaymentHistory(params, ss);
                if (nonMemberHistory == null || !nonMemberHistory.getPaymentTransactionId().equals(paymentKey)) {
                    throw new Exception("제공된 정보와 일치하는 예매 내역이 없습니다.");
                }
            } else {
                MemberVO mvo = (MemberVO) request.getSession().getAttribute("mvo");
                if (mvo == null) {
                    throw new Exception("로그인이 필요한 서비스입니다.");
                }
                if (pvo.getUserIdx() != Long.parseLong(mvo.getUserIdx())) {
                    throw new Exception("본인의 결제 내역만 취소할 수 있습니다.");
                }
            }


            // 1. 토스페이먼츠 환불 API 호출
            cancelTossPayment(paymentKey, cancelReason);

            // 2. DB 처리: 결제, 예매, 쿠폰, 포인트 상태를 원래대로 되돌림
            PaymentDAO.updatePaymentToCancelled(paymentKey, ss);
            if (pvo.getReservIdx() != null) {
                ReservationDAO.updateReservationToCancelled(pvo.getReservIdx(), ss);
            }

            if (pvo.getCouponIdx() != null && pvo.getCouponIdx() > 0) {
                Long couponUserIdx = CouponDAO.getCouponUserIdxByPaymentInfo(pvo.getUserIdx(), pvo.getPaymentIdx(), ss);
                if(couponUserIdx != null) {
                    CouponDAO.revertCouponUsage(couponUserIdx, ss);
                }
            }

            if (pvo.getPointDiscount() > 0 && pvo.getUserIdx() > 0) {
                PointDAO.revertPointUsage(pvo.getUserIdx(), pvo.getPointDiscount(), pvo.getPaymentIdx(), ss);
            }

            ss.commit(); // 모든 처리가 성공하면 최종 커밋

            // ▼▼▼ [수정] 성공 시 JSON 응답 생성 ▼▼▼
            jsonResponse.put("isSuccess", true);

        } catch (Exception e) {
            if (ss != null) {
                ss.rollback(); // 오류 발생 시 롤백
            }
            e.printStackTrace();
            // ▼▼▼ [수정] 실패 시 JSON 응답 생성 ▼▼▼
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 에러 상태 코드 설정
            jsonResponse.put("isSuccess", false);
            jsonResponse.put("errorMessage", e.getMessage());

        } finally {
            if (ss != null) {
                ss.close();
            }
            // ▼▼▼ [수정] 최종적으로 JSON을 응답으로 보냄 ▼▼▼
            try {
                response.getWriter().write(jsonResponse.toJSONString());
            } catch (java.io.IOException e) {
                e.printStackTrace();
            }
        }

        // ▼▼▼ [수정] Controller가 더 이상 뷰 페이지로 이동하지 않도록 null 반환 ▼▼▼
        return null;
    }

    // cancelTossPayment 메서드는 기존과 동일
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
            InputStream errorStream = connection.getErrorStream();
            String errorBody = "응답 본문 없음";

            if (errorStream != null) {
                try (Reader reader = new InputStreamReader(errorStream, StandardCharsets.UTF_8)) {
                    JSONObject errorResponse = (JSONObject) new JSONParser().parse(reader);
                    errorBody = "Toss API Error: " + errorResponse.get("message");
                }
            }
            throw new Exception("결제 취소 실패 (HTTP Status: " + responseCode + ") - " + errorBody);
        }
    }
}