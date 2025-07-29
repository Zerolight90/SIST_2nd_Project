<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.nio.charset.StandardCharsets, java.util.Base64" %>
<%@ page import="org.json.simple.JSONObject, org.json.simple.parser.JSONParser" %>
<%@ page import="mybatis.vo.PaymentVO, mybatis.dao.PaymentDAO" %>
<%
  request.setCharacterEncoding("UTF-8");
  String orderId = request.getParameter("orderId");
  String paymentKey = request.getParameter("paymentKey");
  String amount = request.getParameter("amount");

  String secretKey = "test_sk_d46qopOB89ZPBdzwDdQO3ZmM75y0:"; // 본인의 테스트 시크릿 키
  Base64.Encoder encoder = Base64.getEncoder();
  byte[] encodedBytes = encoder.encode(secretKey.getBytes(StandardCharsets.UTF_8));
  String authorizations = "Basic " + new String(encodedBytes);

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

  int code = connection.getResponseCode();
  boolean isSuccess = (code == 200);

  InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
  Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
  JSONParser parser = new JSONParser();
  JSONObject resObj = (JSONObject) parser.parse(reader);
  responseStream.close();

  int dbResult = 0;
  if (isSuccess) {
    // 성공 시, DB에 결제 정보 저장 (나중에 실제 데이터로 채워야 함)
    PaymentVO vo = new PaymentVO();
    vo.setOrderId(resObj.get("orderId").toString());
    vo.setPaymentTransactionId(resObj.get("paymentKey").toString());
    vo.setPaymentMethod(resObj.get("method").toString());
    vo.setPaymentFinal(Integer.parseInt(resObj.get("totalAmount").toString()));
    // ... vo에 나머지 실제 예매 정보(userIdx, reservationIdx 등) 설정 ...
    // dbResult = PaymentDAO.addPayment(vo);
  }

  // isSuccess = true; // DB 저장과 무관하게 성공 화면을 보기 위한 임시 코드
%>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 예매완료</title>
  <link rel="stylesheet" href="../CSS/reset.css">
  <link rel="stylesheet" href="../CSS/style.css">
  <link rel="stylesheet" href="../CSS/paymentsuccess.css"> <%-- 예매 완료 페이지 전용 스타일 --%>
  <link rel="icon" href="./images/favicon.png">
</head>
<body>
<header>
  <jsp:include page="./menu.jsp"/>
</header>
<article>
  <div class="confirmation_container">
    <h1>예매완료</h1>
    <% if (isSuccess) { %>
    <div class="confirmation_box">
      <%-- 1. 왼쪽 티켓 정보 --%>
      <div class="ticket_info">
        <img src="https://search.pstatic.net/common?type=o&size=178x267&quality=95&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20240718_172%2F1721285223063RTw6L_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2" alt="캡틴 아메리카 포스터" class="poster">
        <div class="ticket_label">
          <p>티켓 예매번호</p>
          <p class="ticket_number">20250211-0035</p>
        </div>
      </div>

      <%-- 2. 오른쪽 예매 상세 내역 --%>
      <div class="booking_details">
        <h2>예매가 완료되었습니다!</h2>
        <table class="details_table">
          <tr><td class="label">예매영화</td><td class="value">캡틴 아메리카: 브레이브 뉴 월드</td></tr>
          <tr><td class="label">관람극장/상영관</td><td class="value">강남 / 프리미엄 IMAX 5관</td></tr>
          <tr><td class="label">관람일시</td><td class="value">2025-02-12 09:00:00</td></tr>
          <tr><td class="label">좌석번호</td><td class="value">A2 (성인), A3 (성인)</td></tr>
          <tr><td class="label">결제정보</td><td class="value">30000 원</td></tr>
          <tr><td class="label">할인금액</td><td class="value">4000 원</td></tr>
          <tr><td class="label">결제금액</td><td class="value"><%= resObj.get("totalAmount") %> 원</td></tr>
        </table>
      </div>
    </div>
    <div class="button_container">
      <button class="btn_history">예매내역</button>
    </div>
    <% } else { %>
    <div style="text-align:center; padding: 50px;">
      <h2>결제 처리 중 오류가 발생했습니다.</h2>
      <p>에러 메시지: <%= resObj.get("message") %></p>
      <div class="button_container">
        <button class="btn_history" onclick="location.href='main.jsp'">메인으로 돌아가기</button>
      </div>
    </div>
    <% } %>

    <div class="screening_guide">
      <h3>&#9654; 상영안내</h3>
      <p>- 쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</p>
    </div>
  </div>
</article>
<footer>
  <jsp:include page="./Footer.jsp"/>
</footer>
</body>
</html>