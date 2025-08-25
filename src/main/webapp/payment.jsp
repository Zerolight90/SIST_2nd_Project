<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 상품 타입에 따라 공통으로 사용할 변수 설정 --%>
<c:choose>
  <c:when test="${paymentType == 'paymentMovie'}">
    <c:set var="itemName" value="${reservationInfo.title}" />
    <c:set var="itemPosterUrl" value="${reservationInfo.posterUrl}" />
    <c:set var="itemFinalAmount" value="${reservationInfo.finalAmount}" />
  </c:when>
  <c:otherwise> <%-- paymentStore --%>
    <c:set var="itemName" value="${productInfo.prodName}" />
    <c:set var="itemPosterUrl" value="${pageContext.request.contextPath}/images/store/${productInfo.prodImg}" />
    <c:set var="itemFinalAmount" value="${productInfo.prodPrice}" />
  </c:otherwise>
</c:choose>

<%--
  [수정] 문제가 되었던 스크립틀릿(<% ... %>) 블록 전체 삭제.
--%>

<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <c:set var="basePath" value="${pageContext.request.contextPath}" />
  <c:set var="full_base_url" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" />
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
      <div class="info_group">
        <h2>${paymentType == 'paymentMovie' ? '예매정보' : '상품정보'}</h2>
        <div class="booking_card">
          <img src="${itemPosterUrl}" alt="포스터/상품 이미지" class="poster">
          <div class="booking_card_details">
            <p class="payment_movie_title">${itemName}</p>
            <c:choose>
              <c:when test="${paymentType == 'paymentMovie'}">
                <p class="info_line">${reservationInfo.theaterName} / ${reservationInfo.screenName}</p>
                <p class="info_line">일시: ${fn:substring(reservationInfo.startTime, 0, 16)}</p>
                <p class="info_line">좌석: ${reservationInfo.seatInfo}</p>
              </c:when>
              <c:otherwise>
                <p class="info_line">수량: ${productInfo.quantity}개</p>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

      <c:if test="${!isGuest}">
        <div class="info_group">
          <h2>할인 적용</h2>
          <div class="input_dropdown">
            <select name="coupon" id="couponSelector">
              <option value="0" data-discount="0">쿠폰 선택</option>
              <c:forEach var="coupon" items="${couponList}">
                <option value="${coupon.couponUserIdx}" data-discount="${coupon.discountValue}">
                    ${coupon.couponName} (-<fmt:formatNumber value="${coupon.discountValue}" pattern="#,##0"/>원)
                </option>
              </c:forEach>
            </select>
          </div>
        </div>

        <div class="info_group">
          <h2>포인트 사용</h2>
          <div class="input_field">
            <input type="text" id="pointInput" placeholder="0">
            <span class="point_info">보유
              <span id="availablePoints"><fmt:formatNumber value="${memberInfo.totalPoints}" pattern="#,##0" /></span> P
            </span>
            <button class="btn_apply" id="applyPointBtn">사용</button>
          </div>
          <p id="pointWarningMessage" class="warning_message" style="display: none;"></p>
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
        <c:when test="${paymentType == 'paymentMovie'}">
          <div class="summary_group">
            <c:if test="${reservationInfo.adultCount > 0}">
              <div class="summary_item">
                <span>성인 ${reservationInfo.adultCount}</span>
                <span class="value"><fmt:formatNumber value="${reservationInfo.adultCount * (price.week - price.day)}" pattern="#,##0"/> 원</span>
              </div>
            </c:if>
            <c:if test="${reservationInfo.teenCount > 0}">
              <div class="summary_item">
                <span>청소년 ${reservationInfo.teenCount}</span>
                <span class="value"><fmt:formatNumber value="${reservationInfo.teenCount * price.teen}" pattern="#,##0"/> 원</span>
              </div>
            </c:if>
            <c:if test="${reservationInfo.seniorCount > 0}">
              <div class="summary_item">
                <span>경로 ${reservationInfo.seniorCount}</span>
                <span class="value"><fmt:formatNumber value="${reservationInfo.seniorCount * price.elder}" pattern="#,##0"/> 원</span>
              </div>
            </c:if>
            <c:if test="${reservationInfo.specialCount > 0}">
              <div class="summary_item">
                <span>우대 ${reservationInfo.specialCount}</span>
                <span class="value"><fmt:formatNumber value="${reservationInfo.specialCount * price.elder}" pattern="#,##0"/> 원</span>
              </div>
            </c:if>
          </div>
          <c:if test="${reservationInfo.timeDiscountAmount > 0 || reservationInfo.seatDiscountAmount > 0}">
            <div class="summary_group">
              <c:if test="${reservationInfo.timeDiscountAmount > 0}">
                <div class="summary_item discount_item_detail">
                  <span>${reservationInfo.timeDiscountName}</span>
                  <span class="value">- <fmt:formatNumber value="${reservationInfo.timeDiscountAmount}" pattern="#,##0"/> 원</span>
                </div>
              </c:if>
              <c:if test="${reservationInfo.seatDiscountAmount > 0}">
                <div class="summary_item discount_item_detail">
                  <span>좌석 할인</span>
                  <span class="value">- <fmt:formatNumber value="${reservationInfo.seatDiscountAmount}" pattern="#,##0"/> 원</span>
                </div>
              </c:if>
            </div>
          </c:if>
        </c:when>
        <c:otherwise>
          <div class="summary_group">
            <div class="summary_item">
              <span>상품</span>
              <span class="value"><fmt:formatNumber value="${productInfo.prodPrice}" pattern="#,##0"/> 원</span>
            </div>
          </div>
        </c:otherwise>
      </c:choose>

      <div class="summary_group">
        <div class="summary_item subtotal_item">
          <span>상품 금액</span>
          <span class="value"><fmt:formatNumber value="${itemFinalAmount}" pattern="#,##0"/> 원</span>
        </div>
      </div>

      <c:if test="${!isGuest}">
        <div class="summary_group">
          <div class="summary_item discount_item">
            <span>쿠폰 할인</span>
            <span class="value" id="couponDiscountText">- 0 원</span>
          </div>
          <div class="summary_item discount_item">
            <span>포인트 사용</span>
            <span class="value" id="pointDiscountText">- 0 원</span>
          </div>
        </div>
      </c:if>

      <div class="final_amount_display">
        <span>총 결제 금액</span>
        <div class="amount">
          <span class="number" id="finalAmountNumber"><fmt:formatNumber value="${itemFinalAmount}" pattern="#,##0"/></span>
          <span class="currency">원</span>
        </div>
      </div>
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
  const isGuest = ${!empty isGuest and isGuest};
  const paymentType = "${paymentType}";
  const full_base_url = "${full_base_url}";

  $(document).ready(function() {
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const customerKey = isGuest ? "SIST_GUEST_" + new Date().getTime() : "SIST_USER_${memberInfo.userIdx}";
    const originalAmount = parseInt('${itemFinalAmount}', 10);
    const availablePoints = isGuest ? 0 : parseInt('<c:out value="${memberInfo.totalPoints}" default="0"/>', 10);

    const paymentWidget = PaymentWidget(clientKey, customerKey);
    const paymentMethods = paymentWidget.renderPaymentMethods("#payment-widget", { value: originalAmount });

    function updatePaymentSummary() {
      let finalAmount = originalAmount;
      if (!isGuest) {
        let couponDiscount = parseInt($('#couponSelector').find('option:selected').data('discount'), 10) || 0;
        let pointDiscount = parseInt($('#pointInput').val()) || 0;
        let maxPoints = originalAmount - couponDiscount;
        if(pointDiscount < 0) pointDiscount = 0;
        if(pointDiscount > maxPoints) pointDiscount = maxPoints;
        if(pointDiscount > availablePoints) pointDiscount = availablePoints;
        $('#pointInput').val(pointDiscount);
        finalAmount = originalAmount - couponDiscount - pointDiscount;
        $('#couponDiscountText').text("- " + couponDiscount.toLocaleString() + " 원");
        $('#pointDiscountText').text("- " + pointDiscount.toLocaleString() + " 원");
      }
      $('#finalAmountNumber').text(finalAmount.toLocaleString());
      paymentMethods.updateAmount(finalAmount);
    }

    if (!isGuest) {
      $('#couponSelector').on('change', updatePaymentSummary);
      $('#pointInput').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
        updatePaymentSummary();
      });
      $('#applyPointBtn').on('click', updatePaymentSummary);
    }

    window.requestPayment = function() {
      const finalAmountForPayment = parseInt($('#finalAmountNumber').text().replace(/,/g, ''));
      const orderId = "SIST_" + (paymentType === 'paymentMovie' ? "MOVIE_" : "STORE_") + new Date().getTime();

      // [수정] 스크립틀릿 대신 JSTL/EL을 사용하여 JavaScript 변수 직접 생성
      const orderName = "${fn:replace(itemName, '"', '\\"')}";

      const couponUserIdx = isGuest ? 0 : $('#couponSelector').val();
      const usedPoints = isGuest ? 0 : (parseInt($('#pointInput').val()) || 0);
      const paymentTypeValue = (paymentType === 'paymentMovie' ? 0 : 1);
      const successUrl = full_base_url + "/Controller?type=paymentConfirm&couponUserIdx=" + couponUserIdx + "&usedPoints=" + usedPoints + "&paymentType=" + paymentTypeValue;
      const failUrl = full_base_url + "/paymentFail.jsp";

      console.log("========== [결제 요청] 서버로 전송할 최종 데이터 ==========");
      console.log({
        finalAmountForPayment: finalAmountForPayment,
        orderId: orderId,
        orderName: orderName,
        couponUserIdx: couponUserIdx,
        usedPoints: usedPoints,
        paymentTypeValue: paymentTypeValue,
        successUrl: successUrl
      });
      console.log("==========================================================");

      paymentWidget.requestPayment({
        amount: finalAmountForPayment,
        orderId: orderId,
        orderName: orderName,
        customerName: isGuest ? "${sessionScope.nmemInfoForPayment.name}" : "<c:out value='${memberInfo.name}'/>",
        customerEmail: isGuest ? "" : "<c:out value='${memberInfo.email}'/>",
        successUrl: successUrl,
        failUrl: failUrl,
      });
    }
    });
</script>
</body>
</html>