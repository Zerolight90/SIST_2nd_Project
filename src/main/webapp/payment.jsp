<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
  // reservationInfo.title에서 '를 \'로 치환해 JavaScript safe 문자열로 변환
  String jsSafeTitle = "";
  if (request.getAttribute("reservationInfo") != null) {
    Object reservationInfoObj = request.getAttribute("reservationInfo");
    try {
      Class<?> cls = reservationInfoObj.getClass();
      java.lang.reflect.Method getTitleMethod = cls.getMethod("getTitle");
      String originalTitle = (String) getTitleMethod.invoke(reservationInfoObj);
      if (originalTitle != null) {
        jsSafeTitle = originalTitle.replace("'", "\\'");
      }
    } catch (Exception e) {
      jsSafeTitle = "제목없음";
    }
  }
  request.setAttribute("jsSafeTitle", jsSafeTitle);
%>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <c:set var="basePath" value="${pageContext.request.contextPath}" />

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
        <%-- ==================== 영화 예매 결제 화면 ==================== --%>
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
        </c:when>
        <%-- ==================== 스토어 상품 결제 화면 ==================== --%>
        <c:when test="${paymentType == 'paymentStore'}">
          <div class="info_group">
            <h2>구매정보</h2>
            <div class="booking_card">
              <img src="${basePath}/${productInfo.prodImg}" alt="상품 이미지" class="poster">
              <div class="booking_card_details">
                <p class="payment_movie_title">${productInfo.prodName}</p>
                <p class="info_line">수량: 1개</p>
                <p class="info_line">
                  가격: <fmt:formatNumber value="${productInfo.prodPrice}" pattern="#,##0" />원
                </p>
              </div>
            </div>
          </div>
        </c:when>
      </c:choose>

      <%-- 할인 및 포인트 사용 (공통 영역) --%>
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

      <div class="info_group">
        <h2>포인트 사용</h2>
        <div class="input_field">
          <input type="text" id="pointInput" placeholder="0">
          <span class="point_info">보유
            <span id="availablePoints">
                <fmt:formatNumber value="${memberInfo.totalPoints}" pattern="#,##0" />
            </span> P
          </span>
          <button class="btn_apply" id="applyPointBtn">사용</button>
        </div>
        <p id="pointWarningMessage" class="warning_message" style="display: none;"></p>
      </div>

      <div class="info_group">
        <h2>결제수단</h2>
        <div id="payment-widget"></div>
      </div>
    </div>

    <div class="payment_summary_section">
      <h2>결제금액</h2>
      <div class="summary_item">
        <span>상품 금액</span>
        <span class="value">
          <c:choose>
            <c:when test="${paymentType == 'paymentMovie'}">${reservationInfo.finalAmount}</c:when>
            <c:otherwise>${productInfo.prodPrice}</c:otherwise>
          </c:choose> 원
        </span>
      </div>
      <div class="summary_item discount_item">
        <span>쿠폰 할인</span>
        <span class="value" id="couponDiscountText">- 0 원</span>
      </div>
      <div class="summary_item discount_item">
        <span>포인트 사용</span>
        <span class="value" id="pointDiscountText">- 0 원</span>
      </div>
      <div class="final_amount_display">
        <span>총 결제 금액</span>
        <div class="amount">
          <span class="number" id="finalAmountNumber">
            <c:choose>
              <c:when test="${paymentType == 'paymentMovie'}">${reservationInfo.finalAmount}</c:when>
              <c:otherwise>${productInfo.prodPrice}</c:otherwise>
            </c:choose>
          </span>
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

  const paymentType = "${paymentType}";

  $(document).ready(function() {
    // ----------------------------------------------------------------
    // 초기 변수 설정
    // ----------------------------------------------------------------
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const customerKey = "SIST_USER_<c:out value="${reservationInfo.userIdx}" default="UNKNOWN"/>";

    // 영화/스토어 타입에 따라 원금(originalAmount)을 다르게 설정
    const originalAmount = parseInt('<c:out value="${paymentType == 'paymentMovie' ? reservationInfo.finalAmount : productInfo.prodPrice}" default="0"/>', 10);

    const availablePoints = parseInt('<c:out value="${memberInfo.totalPoints}" default="0"/>', 10);
    let couponDiscount = 0;
    let pointDiscount = 0;
    let finalAmount = originalAmount;

    const paymentWidget = PaymentWidget(clientKey, customerKey);
    const paymentMethods = paymentWidget.renderPaymentMethods("#payment-widget", { value: finalAmount });
    const $pointWarningMessage = $('#pointWarningMessage');

    // ----------------------------------------------------------------
    // 함수 정의
    // ----------------------------------------------------------------
    function updatePaymentSummary() {
      let amountAfterCoupon = originalAmount - couponDiscount;
      pointDiscount = parseInt($('#pointInput').val()) || 0;
      if (pointDiscount > amountAfterCoupon) {
        pointDiscount = amountAfterCoupon;
        $('#pointInput').val(pointDiscount);
      }
      finalAmount = originalAmount - couponDiscount - pointDiscount;
      $('#couponDiscountText').text("- " + couponDiscount.toLocaleString() + " 원");
      $('#pointDiscountText').text("- " + pointDiscount.toLocaleString() + " 원");
      $('#finalAmountNumber').text(finalAmount.toLocaleString());
      paymentMethods.updateAmount(finalAmount);
    }

    function displayPointWarning(message) { $pointWarningMessage.text(message).show(); }
    function clearPointWarning() { $pointWarningMessage.text('').hide(); }

    // ----------------------------------------------------------------
    // 이벤트 리스너 바인딩
    // ----------------------------------------------------------------
    $('#couponSelector').on('change', function() {
      couponDiscount = parseInt($(this).find('option:selected').data('discount'), 10) || 0;
      updatePaymentSummary();
    });
    $('#pointInput').on('input', function() {
      this.value = this.value.replace(/[^0-9]/g, '');
      let inputPoints = parseInt(this.value) || 0;
      clearPointWarning();
      if (inputPoints > availablePoints) {
        displayPointWarning("보유 포인트를 초과할 수 없습니다.");
        this.value = availablePoints;
      }
      updatePaymentSummary();
    });
    $('#useAllPointsBtn').on('click', function() {
      clearPointWarning();
      let amountAfterCoupon = originalAmount - couponDiscount;
      let pointsToUse = Math.min(amountAfterCoupon, availablePoints);
      $('#pointInput').val(pointsToUse);
      updatePaymentSummary();
    });

    // ----------------------------------------------------------------
    // 최종 결제 요청
    // ----------------------------------------------------------------
    window.requestPayment = function() {
      const currentCouponDiscount = parseInt($('#couponSelector').find('option:selected').data('discount'), 10) || 0;
      let currentPointDiscount = parseInt($('#pointInput').val()) || 0;
      if (currentPointDiscount > availablePoints) currentPointDiscount = availablePoints;
      const amountAfterCoupon = originalAmount - currentCouponDiscount;
      if (currentPointDiscount > amountAfterCoupon) currentPointDiscount = amountAfterCoupon;
      const finalAmountForPayment = originalAmount - currentCouponDiscount - currentPointDiscount;

      console.log("결제 요청 직전 계산된 최종 금액:", finalAmountForPayment);
      paymentMethods.updateAmount(finalAmountForPayment);

      const orderId = "SIST_" + (paymentType === 'paymentMovie' ? "MOVIE_" : "STORE_") + new Date().getTime();

      let orderName = "";
      if (paymentType === 'paymentMovie') {
        orderName = '<c:out value="${jsSafeTitle}"/>_<c:out value="${reservationInfo.reservIdx}"/>';
      } else { // [추가] 스토어용 orderName 설정
        orderName = '<c:out value="${jsSafeProdName}"/>_<c:out value="${productInfo.prodIdx}"/>';
      }
      const successUrl = window.location.origin + '${basePath}/Controller?type=paymentConfirm&couponUserIdx=' + $('#couponSelector').val() + "&usedPoints=" + currentPointDiscount;
      const failUrl = window.location.origin + '${basePath}/paymentFail.jsp';

      paymentWidget.requestPayment({
        amount: finalAmountForPayment,
        orderId: orderId,
        orderName: orderName,
        customerName: "<c:out value='${memberInfo.name}'/>",
        customerEmail: "<c:out value='${memberInfo.email}'/>",
        successUrl: successUrl,
        failUrl: failUrl,
      });
    }

    // ----------------------------------------------------------------
    // 페이지 로드 시 초기화
    // ----------------------------------------------------------------
    $('#availablePointsText').text(availablePoints.toLocaleString());
  });
</script>
</body>
</html>

