<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <link rel="stylesheet" href="../CSS/reset.css">
  <link rel="stylesheet" href="../CSS/style.css">
  <link rel="stylesheet" href="../CSS/payment.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <link rel="icon" href="./images/favicon.png">
  <script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
<header>
  <jsp:include page="./menu.jsp"/>
</header><article>
  <div class="payment-container">
    <div class="payment-info-section">
      <h2>결제하기</h2>
      <div class="info-group">
        <h3>구매 정보</h3>
        <div class="product-card">
          <img src="https://via.placeholder.com/80" alt="상품 이미지"> <div class="product-details">
          <p>${movieTitle}</p>
          <p class="price">${finalAmount}원</p>
        </div>
        </div>
      </div>

      <hr/>

      <div class="info-group payment-method-section">
        <h3>결제수단</h3>
        <div class="payment-method-options">
          <div class="payment-method-option selected" data-method="CARD">
            신용/체크카드
          </div>
        </div>
        <div style="margin-top: 20px; font-size: 14px; color: #777;">
          자주 사용하는 카드는 등록하고 다음에도 빠르게 결제하세요!
        </div>
      </div>
    </div>

    <div class="payment-summary-section">
      <h2>결제 금액</h2>
      <div class="info-item">
        <span>금액</span>
        <strong>${finalAmount}원</strong>
      </div>
      <div class="info-item">
        <span>할인적용</span>
        <strong>0원</strong>
      </div>

      <div class="final-amount-display">
        <span>최종결제금액</span>
        <strong>${finalAmount}원</strong>
      </div>

      <div class="pay-button-wrapper">
        <button class="pay-button" onclick="requestPayment()">결제하기</button>
      </div>
    </div>
  </div>
</article>
<jsp:include page="./Footer.jsp"/>

<script>
  // 수정: 토스 테스트 클라이언트 키로 변경함
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