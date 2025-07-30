<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/payment.css">
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">

  <script src="https://js.tosspayments.com/v1/payment-widget"></script>
</head>
<body>
<header>
  <jsp:include page="./menu.jsp"/>
</header>
<article>
  <div class="payment_container">
    <div class="payment_info_section">
      <h1>결제하기</h1>

      <c:choose>
        <c:when test="${paymentType == 'pay_movie'}">
          <div class="info_group">
            <h2>예매정보</h2>
            <div class="booking_card">
              <img src="${displayInfo.posterUrl}" alt="포스터 이미지" class="poster">
              <div class="booking_card_details">
                <p class="payment_movie_title">${displayInfo.title}</p>
                <c:forEach var="detail" items="${displayInfo.details}">
                  <p class="info_line">${detail}</p>
                </c:forEach>
              </div>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <div class="info_group">
            <h2>구매정보</h2>
            <div class="booking_card">
              <img src="${productInfo.prodImg}" alt="상품 이미지" class="poster">
              <div class="booking_card_details">
                <p class="payment_movie_title">${productInfo.prodName}</p>
              </div>
            </div>
          </div>
        </c:otherwise>
      </c:choose>

      <c:if test="${paymentType == 'pay_movie'}">
        <div class="info_group">
          <h2>할인 적용</h2>
          <div class="input_dropdown">
            <select name="coupon">
              <option value="">쿠폰 선택</option>
              <option value="4000">가입 영화 4000원 할인 쿠폰</option>
              <option value="2000">생일 영화 10% 할인 쿠폰</option>
            </select>
          </div>
        </div>
        <div class="info_group">
          <h2>포인트 사용</h2>
          <div class="input_field">
            <input type="text" placeholder="0">
            <span class="point_info">보유 0원</span>
            <button class="btn_apply">사용</button>
          </div>
        </div>
      </c:if>

      <div class="info_group">
        <h2>결제수단</h2>
        <div id="payment-widget"></div>
      </div>
    </div>

    <div class="payment_summary_section">
      <h2>결제금액</h2>
      <c:choose>
        <c:when test="${paymentType == 'pay_movie'}">
          <div class="summary_item"><span>금액</span><span class="value">${displayInfo.price} 원</span></div>
          <div class="summary_item"><span>할인적용</span><span class="value">- ${displayInfo.discount} 원</span></div>
          <div class="final_amount_display"><span>최종결제금액</span><span class="amount">${displayInfo.finalAmount} 원</span></div>
        </c:when>
        <c:otherwise>
          <div class="summary_item"><span>금액</span><span class="value">${productInfo.prodPrice} 원</span></div>
          <div class="final_amount_display"><span>최종결제금액</span><span class="amount">${productInfo.prodPrice} 원</span></div>
        </c:otherwise>
      </c:choose>
      <div class="button_group">
        <button class="pay_button btn_prev" onclick="history.back()">이전</button>
        <button class="pay_button btn_pay" onclick="requestPayment()">결제</button>
      </div>
    </div>
  </div>
</article>
<footer>
  <jsp:include page="./Footer.jsp"/>
</footer>

<script>
  const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
  const customerKey = "temp_customer_123";

  // 1. 결제 위젯 객체 생성
  const paymentWidget = PaymentWidget(clientKey, customerKey);

  // 2. 렌더링할 금액 계산
  const amount = {
    value: <c:out value='${paymentType == "pay_store" ? productInfo.prodPrice : displayInfo.finalAmount}' />
  };

  // 3. 결제 위젯 렌더링
  paymentWidget.renderPaymentMethods("#payment-widget", amount);

  // 4. 결제 요청 함수
  function requestPayment() {
    const orderName = "<c:out value='${paymentType == "pay_store" ? productInfo.prodName.concat(" 구매") : displayInfo.title.concat(" 예매")}' />";

    paymentWidget.requestPayment({
      orderId: "SISTBOX_" + new Date().getTime(),
      orderName: orderName,
      customerName: "김쌍용",
      successUrl: window.location.origin + "<%= request.getContextPath() %>/jsp/paymentSuccess.jsp",
      failUrl: window.location.origin + "<%= request.getContextPath() %>/jsp/paymentFail.jsp"
    });
  }
</script>
</body>
</html>