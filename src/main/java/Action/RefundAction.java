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

/**
 * 회원 및 비회원의 결제 환불을 처리하고, 결과에 따라 페이지를 리다이렉트하는 Action
 */
public class RefundAction implements Action {

    private static final String TOSS_SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
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

            if ("true".equals(isNonMember)) {
                // [비회원] 환불 요청 시 넘어온 정보로 다시 한번 DB와 대조하여 검증
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
                // [회원] 세션을 이용한 본인인증
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

            // [수정됨] pvo.getCouponUserIdx() -> pvo.getCouponIdx() 로 변경
            // 쿠폰을 사용한 결제 건일 경우에만 쿠폰 상태를 되돌립니다.
            if (pvo.getCouponIdx() != null && pvo.getCouponIdx() > 0) {
                // payment 테이블의 userIdx와 couponIdx를 사용해 원래의 couponUserIdx를 찾아야 합니다.
                // 이 로직은 CouponDAO에 추가되어야 합니다. (예: getCouponUserIdxByPaymentInfo)
                // 여기서는 CouponDAO에 해당 기능이 있다고 가정하고 호출합니다.
                Long couponUserIdx = CouponDAO.getCouponUserIdxByPaymentInfo(pvo.getUserIdx(), pvo.getPaymentIdx(), ss);
                if(couponUserIdx != null) {
                    CouponDAO.revertCouponUsage(couponUserIdx, ss);
                }
            }

            if (pvo.getPointDiscount() > 0 && pvo.getUserIdx() > 0) {
                PointDAO.revertPointUsage(pvo.getUserIdx(), pvo.getPointDiscount(), pvo.getPaymentIdx(), ss);
            }

            ss.commit(); // 모든 처리가 성공하면 최종 커밋

        } catch (Exception e) {
            if (ss != null) {
                ss.rollback(); // 오류 발생 시 롤백
            }
            e.printStackTrace();
            // TODO: 에러 발생 시 사용자에게 에러 페이지를 보여주는 로직 추가 필요
            // 예를 들어, request에 에러 메시지를 담아서 에러 페이지로 포워딩
            request.setAttribute("errorMessage", "환불 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "error.jsp"; // 에러 페이지 경로
        } finally {
            if (ss != null) {
                ss.close();
            }
        }

        // 환불 처리 후, 회원/비회원에 따라 지정된 페이지로 리다이렉트합니다.
        String viewPath;
        if ("true".equals(isNonMember)) {
            // 비회원인 경우, 비회원 예매 조회 페이지 초기화면으로 이동
            viewPath = "redirect:nmemInfo.do"; // 컨트롤러를 통해 이동하도록 수정
        } else {
            // 회원인 경우, 마이페이지의 예매 내역 페이지로 이동
            viewPath = "redirect:Controller?type=myReservation";
        }

        return viewPath;
    }

    /**
     * 토스페이먼츠 결제 취소 API를 호출하는 메소드
     */
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