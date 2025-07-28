<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.nio.charset.StandardCharsets, java.util.Base64" %>
<%@ page import="org.json.simple.JSONObject, org.json.simple.parser.JSONParser" %>
<%@ page import="mybatis.vo.PaymentVO, mybatis.dao.PaymentDAO" %>
<%
  request.setCharacterEncoding("UTF-8");
  String orderId = request.getParameter("orderId");
  String paymentKey = request.getParameter("paymentKey");
  String amount = request.getParameter("amount");

  // [수정 필요] 본인의 테스트 시크릿 키
  String secretKey = "test_sk_d46qopOB89ZPBdzwDdQO3ZmM75y0:";
  Base64.Encoder encoder = Base64.getEncoder();
  byte[] encodedBytes = encoder.encode(secretKey.getBytes(StandardCharsets.UTF_8));
  String authorizations = "Basic " + new String(encodedBytes);

  URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
  connection.setRequestProperty("Authorization", authorizations);
  connection.setRequestProperty("Content-Type", "application/json");
  connection.setRequestMethod("POST");
  connection.setDoOutput(true);

  JSONObject obj = new JSONObject();
  obj.put("paymentKey", paymentKey);
  obj.put("orderId", orderId);
  obj.put("amount", Integer.parseInt(amount));

  OutputStream outputStream = connection.getOutputStream();
  outputStream.write(obj.toString().getBytes("UTF-8"));

  int code = connection.getResponseCode();
  boolean isSuccess = (code == 200);

  InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
  Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
  JSONParser parser = new JSONParser();
  JSONObject jsonObject = (JSONObject) parser.parse(reader);
  responseStream.close();

  int dbResult = 0;
  if (isSuccess) {
    // Users 테이블에 userIdx=1인 데이터가 있어야 함
    long userIdx = 1;

    // Reservation 테이블에 미리 INSERT한 reservationIdx 값 사용
    Long reservationIdx = 100L;

    Integer productIdx = null; // 상품 결제가 아니므로 null로 설정

    PaymentVO vo = new PaymentVO();
    vo.setUserIdx(userIdx);
    vo.setReservationIdx(reservationIdx);
    vo.setProductIdx(productIdx);
    vo.setOrderId(jsonObject.get("orderId").toString());
    vo.setPaymentTransactionId(jsonObject.get("paymentKey").toString());
    vo.setPaymentQuantity(1); // 실제 예매 수량
    vo.setPaymentMethod(jsonObject.get("method").toString());
    vo.setPaymentTotal(1000); // 실제 할인 전 금액
    vo.setPaymentDiscount(0); // 실제 할인액
    vo.setPaymentFinal(Integer.parseInt(jsonObject.get("totalAmount").toString()));

    dbResult = PaymentDAO.addPayment(vo);
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>결제 결과</title>
</head>
<body>
<h1>결제 <%= isSuccess ? "성공" : "실패" %></h1>
<% if (isSuccess && dbResult > 0) { %>
<p>결제가 성공적으로 처리되었고, DB에 저장되었습니다.</p>
<% } else { %>
<p>결제 처리 중 오류가 발생했습니다.</p>
<p>에러 메시지: <%= jsonObject.get("message") %></p>
<% } %>
</body>
</html>