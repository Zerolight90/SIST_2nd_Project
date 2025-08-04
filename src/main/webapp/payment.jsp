<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <c:set var="basePath" value="${pageContext.request.contextPath}"/>

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://js.tosspayments.com/v1/payment-widget"></script>

  <link rel="stylesheet" href="${basePath}/css/reset.css">
  <link rel="stylesheet" href="${basePath}/css/sub/sub_page_style.css">
  <link rel="stylesheet" href="${basePath}/css/payment.css">
  <link rel="icon" href="${basePath}/images/favicon.png">
</head>
<body>
<header>
  <jsp:include page="common/sub_menu.jsp"/>
</header>
<article>
  <div class="payment_container">
    <div class="payment_info_section">
      <h1>결제하기</h1>
      <c:choose>
        <c:when test="${paymentType == 'paymentMovie'}">
          <div class="info_group">
            <h2>예매정보</h2>
            <div class="booking_card">
              <img src="${basePath}/${reservationInfo.posterUrl}" alt="포스터 이미지" class="poster">
              <div class="booking_card_details">
                <p class="payment_movie_title">${reservationInfo.title}</p>
                <p class="info_line">${reservationInfo.theaterName} / ${reservationInfo.screenName}</p>
                <p class="info_line">일시: ${reservationInfo.startTime}</p>
                <p class="info_line">좌석: ${reservationInfo.seatInfo}</p>
              </div>
            </div>
          </div>
          <div class="info_group">
            <h2>할인 적용</h2>
            <div class="input_dropdown">
              <select name="coupon" id="couponSelector">
                <option value="0" data-discount="0">쿠폰 선택</option>
                <c:forEach var="coupon" items="${couponList}">
                  <option value="${coupon.couponUserIdx}" data-discount="${coupon.couponValue}">
                      ${coupon.couponName} (-${coupon.couponValue}원)
                  </option>
                </c:forEach>
              </select>
            </div>
          </div>
        </c:when>
        <c:when test="${paymentType == 'paymentStore'}">
          <div class="info_group">
            <h2>구매정보</h2>
            <div class="booking_card">
              <img src="${basePath}/${productInfo.prodImg}" alt="상품 이미지" class="poster">
              <div class="booking_card_details">
                <p class="payment_movie_title">${productInfo.prodName}</p>
                <p class="info_line">수량: 1개</p>
              </div>
            </div>
          </div>
        </c:when>
      </c:choose>
      <div class="info_group">
        <h2>결제수단</h2>
        <div id="payment-widget"></div>
      </div>
    </div>
    <div class="payment_summary_section">
      <h2>결제금액</h2>
      <c:choose>
        <c:when test="${paymentType == 'paymentMovie'}">
          <div class="summary_item">
            <span>상품 금액</span>
            <span class="value">${reservationInfo.finalAmount} 원</span>
          </div>
          <div class="summary_item discount_item">
            <span>할인 금액</span>
            <span class="value" id="discountAmountText">- 0 원</span>
          </div>
          <div class="final_amount_display">
            <span>총 결제 금액</span>
            <div class="amount">
              <span class="number" id="finalAmountNumber">${reservationInfo.finalAmount}</span>
              <span class="currency">원</span>
            </div>
          </div>
        </c:when>
        <c:when test="${paymentType == 'paymentStore'}">
          <div class="summary_item">
            <span>상품 금액</span>
            <span class="value">${finalAmount} 원</span>
          </div>
          <div class="final_amount_display">
            <span>총 결제 금액</span>
            <div class="amount">
              <span class="number">${finalAmount}</span>
              <span class="currency">원</span>
            </div>
          </div>
        </c:when>
      </c:choose>
      <div class="button_group">
        <button class="pay_button btn_prev" onclick="history.back()">이전</button>
        <button class="pay_button btn_pay" onclick="requestPayment()">결제</button>
      </div>
    </div>
  </div>
</article>
<footer>
  <jsp:include page="common/Footer.jsp"/>
</footer>

<script>
  const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
  const customerKey = "SIST_USER_${paymentType == 'paymentMovie' ? reservationInfo.userIdx : 'store_user'}";
  const paymentWidget = PaymentWidget(clientKey, customerKey);

  const originalAmount = ${paymentType == 'paymentMovie' ? reservationInfo.finalAmount : finalAmount};
  let finalAmount = originalAmount;

  const paymentMethods = paymentWidget.renderPaymentMethods("#payment-widget", { value: finalAmount });

  // 쿠폰 선택 이벤트 리스너
  $('#couponSelector').on('change', function() {
    const selectedOption = $(this).find('option:selected');
    const discount = parseInt(selectedOption.data('discount'), 10);
    finalAmount = originalAmount - discount;
    $('#discountAmountText').text("- " + discount.toLocaleString() + " 원");
    $('#finalAmountNumber').text(finalAmount.toLocaleString());
    paymentMethods.updateAmount(finalAmount);
  });

  // 결제 요청 함수
  function requestPayment() {
    const paymentType = "${paymentType}";

    let orderId = "";
    let orderName = "";
    let successUrl = "";
    const failUrl = 'http://localhost:8080/paymentFail.jsp';

    if (paymentType === 'paymentMovie') {
      const selectedCouponIdx = $('#couponSelector').val() || 0;
      orderId = "SIST_MOVIE_" + new Date().getTime();
      orderName = "${reservationInfo.title}_${reservationInfo.reservIdx}";
      successUrl = 'http://localhost:8080/Controller?type=paymentConfirm&couponUserIdx=' + selectedCouponIdx;
    } else if (paymentType === 'paymentStore') {
      orderId = "SIST_STORE_" + new Date().getTime();
      orderName = "${productInfo.prodName}_${productInfo.productIdx}";
      successUrl = 'http://localhost:8080/Controller?type=paymentConfirm&couponUserIdx=0';
    }

    // 최종적으로 위에서 설정된 정보로 결제 요청
    paymentWidget.requestPayment({
      orderId: orderId,
      orderName: orderName,
      customerName: "김자바",
      successUrl: successUrl,
      failUrl: failUrl
    });
  }
</script>
</body>
</html>