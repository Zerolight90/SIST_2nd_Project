<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <link rel="stylesheet" href="../CSS/reset.css">
  <link rel="stylesheet" href="../CSS/style.css">
  <script src="https://js.tosspayments.com/v2/standard"></script>
  <style>
    /* 토스 기본 스타일 */
    .payment-wrapper { max-width: 800px; margin: 40px auto; padding: 40px; background: #fff; border-radius: 8px; }
    .pay-button { width: 100%; padding: 15px; font-size: 18px; color: #fff; background-color: #3182f6; border: none; border-radius: 5px; cursor: pointer; margin-top: 20px; }
  </style>
</head>
<body>
<header>
  <jsp:include page="./menu.jsp"/>
</header>
<article>
  <div class="payment-wrapper">
    <h2>결제 정보 확인</h2>
    <hr/>
    <p><strong>영화:</strong> ${movieTitle}</p>
    <p><strong>결제 금액:</strong> ${finalAmount}원</p>
    <button class="pay-button" onclick="requestPayment()">결제하기</button>
  </div>
</article>
<jsp:include page="./Footer.jsp"/>

<script>
  // 수정: 내 테스트 클라이언트 키로 변경
  const clientKey = "test_ck_oEjb0gm23PW1eebeLJmo8pGwBJn5";
  const tossPayments = TossPayments(clientKey);
  const payment = tossPayments.payment({ customerKey: "${customerName}" });

  function requestPayment() {
    payment.requestPayment({
      method: "CARD",
      amount: { currency: "KRW", value: ${finalAmount} },
      orderId: "SISTBOX_" + new Date().getTime(),
      orderName: "${movieTitle} 예매",
      customerName: "${customerName}",
      successUrl: window.location.origin + "/jsp/paymentSuccess.jsp",
      failUrl: window.location.origin + "/jsp/paymentFail.jsp",
    });
  }
</script>
</body>
</html>