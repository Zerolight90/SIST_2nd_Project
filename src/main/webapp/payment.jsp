<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <c:set var="basePath" value="${pageContext.request.contextPath}"/>

  <%-- 필수 라이브러리 추가 --%>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://js.tosspayments.com/v1/payment-widget"></script>

  <link rel="stylesheet" href="${basePath}/css/reset.css">
  <link rel="stylesheet" href="${basePath}/css/style.css">
  <link rel="stylesheet" href="${basePath}/css/payment.css">
  <link rel="icon" href="${basePath}/images/favicon.png">
</head>
<body>
<header>
  <jsp:include page="jsp/sub_menu.jsp"/>
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
            <select name="coupon" id="couponSelector">
              <option value="0" data-uservalue="0">쿠폰 선택</option>
              <c:forEach var="coupon" items="${couponList}">
                <option value="${coupon.couponUserIdx}" data-uservalue="${coupon.couponValue}">
                    ${coupon.couponName}
                </option>
              </c:forEach>
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
          <%-- ▼▼▼▼▼▼▼▼▼▼▼ CSS 구조에 맞게 수정 ▼▼▼▼▼▼▼▼▼▼▼ --%>
          <div class="summary_item">
            <span>상품 금액</span>
            <span class="value">${displayInfo.price} 원</span>
          </div>
          <div class="summary_item">
            <span>할인 금액</span>
            <span class="value">- ${displayInfo.discount} 원</span>
          </div>
          <div class="final_amount_display">
            <span>총 결제 금액</span>
            <div class="amount">
              <span class="number">${displayInfo.finalAmount}</span>
              <span class="currency">원</span>
            </div>
          </div>
          <%-- ▲▲▲▲▲▲▲▲▲▲▲ CSS 구조에 맞게 수정 ▲▲▲▲▲▲▲▲▲▲▲ --%>
        </c:when>
        <c:otherwise>
          <div class="summary_item">
            <span>상품 금액</span>
            <span class="value">${productInfo.prodPrice} 원</span>
          </div>
          <div class="final_amount_display">
            <span>총 결제 금액</span>
            <div class="amount">
              <span class="number">${productInfo.prodPrice}</span>
              <span class="currency">원</span>
            </div>
          </div>
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
  <jsp:include page="./jsp/Footer.jsp"/>
</footer>

<script>
  const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
  const customerKey = "temp_customer_123";

  const paymentWidget = PaymentWidget(clientKey, customerKey);

  const originalFinalAmount = <c:out value='${paymentType == "pay_store" ? productInfo.prodPrice : displayInfo.finalAmount}' />;

  paymentWidget.renderPaymentMethods("#payment-widget", { value: originalFinalAmount });

  function requestPayment() {
    const orderName = "<c:out value='${paymentType == "pay_store" ? productInfo.prodName.concat(" 구매") : displayInfo.title.concat(" 예매")}' />";

    paymentWidget.requestPayment({
      orderId: "SISTBOX_" + new Date().getTime(),
      orderName: orderName,
      customerName: "김쌍용",
      successUrl: window.location.origin + "<%= request.getContextPath() %>/Controller?type=paymentConfirm",
      failUrl: window.location.origin + "<%= request.getContextPath() %>/Controller?type=paymentFail.jsp"

    });
  }
</script>
</body>
</html>