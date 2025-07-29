<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>환불 결과</title>
  <link rel="stylesheet" href="./CSS/style.css">
  <link rel="stylesheet" href="./CSS/reset.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* (나머지 style 태그 내의 CSS 코드는 변경 없음) */
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f0f2f5;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      margin: 0;
      padding: 0;
    }
    header, footer {
      flex-shrink: 0;
    }
    .refund-result-container {
      flex-grow: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }
    .refund-box {
      background-color: #fff;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 450px;
      box-sizing: border-box;
    }
    .refund-box h2 {
      font-size: 28px;
      color: #333;
      margin-bottom: 20px;
      font-weight: 700;
    }
    .refund-box .icon {
      font-size: 60px;
      margin-bottom: 20px;
    }
    .refund-box .success-icon {
      color: #28a745;
    }
    .refund-box .fail-icon {
      color: #dc3545;
    }
    .refund-box p {
      font-size: 16px;
      color: #555;
      line-height: 1.6;
      margin-bottom: 10px;
    }
    .refund-box .details {
      background-color: #f9f9f9;
      border: 1px solid #eee;
      padding: 15px;
      margin-top: 20px;
      border-radius: 5px;
      text-align: left;
    }
    .refund-box .details strong {
      color: #333;
      display: inline-block;
      width: 120px;
    }
    .refund-box .button-group {
      margin-top: 30px;
      display: flex;
      justify-content: center;
      gap: 15px;
    }
    .refund-box .button-group a {
      display: inline-block;
      background-color: #007bff;
      color: #fff;
      padding: 12px 25px;
      border-radius: 5px;
      text-decoration: none;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }
    .refund-box .button-group a:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<header>
  <jsp:include page="/jsp/menu.jsp"/>
</header>

<article>
  <div class="refund-result-container">
    <div class="refund-box">
      <%
        boolean refundSuccess = (Boolean) request.getAttribute("refundSuccess");
        String paymentKey = (String) request.getAttribute("paymentKey");
        String cancelReason = (String) request.getAttribute("cancelReason");
        int refundAmount = (Integer) request.getAttribute("refundAmount");
        String apiResponseStatus = (String) request.getAttribute("apiResponseStatus");
        String apiResponseMessage = (String) request.getAttribute("apiResponseMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
      %>

      <% if (errorMessage != null) { %>
      <div class="icon fail-icon">&#x2716;</div>
      <h2>환불 처리 오류</h2>
      <p><%= errorMessage %></p>
      <p>다시 시도하거나 고객센터에 문의해주세요.</p>
      <% } else if (refundSuccess) { %>
      <div class="icon success-icon">&#x2714;</div>
      <h2>환불 요청 완료!</h2>
      <p>선택하신 예매의 환불 요청이 성공적으로 처리되었습니다.</p>
      <div class="details">
        <p><strong>결제 고유 번호:</strong> <%= paymentKey %></p>
        <p><strong>환불 금액:</strong> <%= String.format("%,d원", refundAmount) %></p>
        <p><strong>환불 사유:</strong> <%= cancelReason %></p>
        <p><strong>API 응답 상태:</strong> <%= apiResponseStatus %></p>
        <p><strong>메시지:</strong> <%= apiResponseMessage %></p>
      </div>
      <p>환불은 영업일 기준 3~5일 이내에 처리될 예정입니다.</p>
      <% } else { %>
      <div class="icon fail-icon">&#x2716;</div>
      <h2>환불 요청 실패</h2>
      <p>환불 요청 중 문제가 발생했습니다.</p>
      <div class="details">
        <p><strong>결제 고유 번호:</strong> <%= paymentKey %></p>
        <p><strong>환불 사유:</strong> <%= cancelReason %></p>
        <p><strong>API 응답 상태:</strong> <%= apiResponseStatus %></p>
        <p><strong>메시지:</strong> <%= apiResponseMessage %></p>
      </div>
      <p>문제가 지속될 경우 고객센터에 문의해주세요.</p>
      <% } %>

      <div class="button-group">
        <a href="Controller?type=myPayment">나의 결제 내역으로 돌아가기</a>
        <a href="Controller?type=index">메인 페이지로 돌아가기</a>
      </div>
    </div>
  </div>
</article>
  <jsp:include page="./Footer.jsp"/>
</body>
</html>