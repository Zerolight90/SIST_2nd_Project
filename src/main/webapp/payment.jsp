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
<<<<<<< Updated upstream
  <c:set var="basePath" value="${pageContext.request.contextPath}" />
  <c:set var="full_base_url" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" />
=======
  <c:set var="basePath" value="${pageContext.request.contextPath}"/>

  <%-- 필수 라이브러리 추가 --%>
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        </div>

        <div class="info_group">
          <h2>포인트 사용</h2>
          <div class="input_field">
            <input type="text" id="pointInput" placeholder="0">
            <span class="point_info">보유
              <span id="availablePoints"><fmt:formatNumber value="${memberInfo.totalPoints}" pattern="#,##0" /></span> P
            </span>
            <button class="btn_apply" id="applyPointBtn">사용</button>
=======
          <%-- 포인트 사용 기능 추가 --%>
          <div class="info_group">
            <h2>포인트 사용</h2>
            <div class="input_field">
              <input type="text" id="pointInput" placeholder="0">
              <span class="point_info">보유 <span id="availablePoints">0</span>원</span> <%-- 초기값은 JS에서 설정 --%>
              <button class="btn_apply" id="applyPointBtn">사용</button>
            </div>
          </div>
          <%-- 포인트 경고 메시지 추가 --%>
          <p id="pointWarningMessage" class="warning_message" style="display: none;"></p>
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
          <div class="summary_item">
            <span>상품 금액</span>
            <span class="value" id="originalPriceDisplay">${reservationInfo.finalAmount} 원</span>
          </div>
          <div class="summary_item discount_item">
            <span>쿠폰 할인</span> <%-- 할인 금액을 쿠폰 할인으로 변경 --%>
            <span class="value" id="couponDiscountText">- 0 원</span>
          </div>
          <div class="summary_item discount_item">
            <span>포인트 사용</span> <%-- 포인트 사용 항목 추가 --%>
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
  const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
  // customerKey는 항상 유효한 문자열이 되도록 c:out default 값을 사용
  const customerKey = "SIST_USER_<c:out value="${paymentType == 'paymentMovie' ? reservationInfo.userIdx : 'store_user'}" default="UNKNOWN"/>";
  const paymentWidget = PaymentWidget(clientKey, customerKey);

  // 초기 금액 설정 (영화 예매 시 reservationInfo.finalAmount, 스토어 구매 시 productInfo.prodPrice)
  // JSP/EL 표현식이 JavaScript에서 유효한 숫자로 파싱되도록 parseInt와 c:out default를 사용
  const initialOriginalAmount = parseInt('<c:out value="${paymentType == 'paymentMovie' ? reservationInfo.finalAmount : productInfo.prodPrice}" default="0"/>', 10);
  let currentFinalAmount = initialOriginalAmount;
  let currentCouponDiscount = 0;
  let currentPointDiscount = 0;
  const availablePoints = 500; // 임시 보유 포인트 (예시)

  // 경고 메시지 엘리먼트
  const $pointWarningMessage = $('#pointWarningMessage');

  // 금액 업데이트 함수
  function updatePaymentSummary() {
    currentFinalAmount = initialOriginalAmount - currentCouponDiscount - currentPointDiscount;

    // 최종 금액이 0보다 작아지지 않도록 처리
    if (currentFinalAmount < 0) {
      currentFinalAmount = 0;
      // 포인트 할인을 최종 금액에 맞춰 조정
      currentPointDiscount = initialOriginalAmount - currentCouponDiscount;
      if (currentPointDiscount < 0) currentPointDiscount = 0; // 혹시 쿠폰 할인이 더 커서 음수가 되는 경우 방지
      $('#pointInput').val(currentPointDiscount); // 조정된 포인트 값으로 input 업데이트
      displayPointWarning("포인트 사용으로 결제 금액이 0원이 되었습니다.");
    } else {
      clearPointWarning(); // 유효한 경우 경고 메시지 숨김
    }

    $('#couponDiscountText').text("- " + currentCouponDiscount.toLocaleString() + " 원");
    $('#pointDiscountText').text("- " + currentPointDiscount.toLocaleString() + " 원");
    $('#finalAmountNumber').text(currentFinalAmount.toLocaleString());
    paymentWidget.updateAmount(currentFinalAmount);
  }

  // 경고 메시지 표시 함수
  function displayPointWarning(message) {
    $pointWarningMessage.text(message).show();
  }

  // 경고 메시지 숨김 함수
  function clearPointWarning() {
    $pointWarningMessage.text('').hide();
  }

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
      // orderName에 포함될 수 있는 단일 따옴표를 이스케이프 처리
      orderName = "<c:out value='${fn:replace(reservationInfo.title, "\'", "\\\'")}'/>_<c:out value='${reservationInfo.reservIdx}'/>";
      successUrl = 'http://localhost:8080/Controller?type=paymentConfirm&couponUserIdx=' + selectedCouponIdx + '&usedPoints=' + currentPointDiscount;
    } else if (paymentType === 'paymentStore') {
      orderId = "SIST_STORE_" + new Date().getTime();
      // orderName에 포함될 수 있는 단일 따옴표를 이스케이프 처리
      orderName = "<c:out value='${fn:replace(productInfo.prodName, "\'", "\\\'")}'/>_<c:out value='${productInfo.prodIdx}'/>";
      successUrl = 'http://localhost:8080/Controller?type=paymentConfirm&couponUserIdx=0&usedPoints=' + currentPointDiscount; // 스토어 구매 시에도 포인트 사용 가능하도록 수정
    }

    // 최종적으로 위에서 설정된 정보로 결제 요청
    paymentWidget.requestPayment({
      orderId: orderId,
      orderName: orderName,
      customerName: "김자바", // 실제 로그인 사용자 이름으로 대체 필요
      successUrl: successUrl,
      failUrl: failUrl
    });
  }

  // 모든 jQuery 의존 코드와 paymentWidget 렌더링을 DOM 로드 완료 후 실행
  $(document).ready(function() {
    paymentWidget.renderPaymentMethods("#payment-widget", { value: currentFinalAmount });

    // 쿠폰 선택 이벤트 리스너
    $('#couponSelector').on('change', function() {
      const selectedOption = $(this).find('option:selected');
      currentCouponDiscount = parseInt(selectedOption.data('discount'), 10);
      // 쿠폰 할인 변경 시 포인트 할인 초기화 (필요에 따라 정책 변경 가능)
      currentPointDiscount = 0;
      $('#pointInput').val(0);
      updatePaymentSummary();
    });

    // 포인트 입력 필드 숫자만 입력 가능하도록
    $('#pointInput').on('input', function() {
      this.value = this.value.replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거
      clearPointWarning(); // 입력 시 경고 메시지 숨김
    });

    // 포인트 사용 버튼 클릭 이벤트 리스너
    $('#applyPointBtn').on('click', function() {
      let inputPoints = parseInt($('#pointInput').val(), 10) || 0;

      // 총 결제 금액을 0원 미만으로 만들지 않도록 포인트 사용 제한
      const maxUsablePoints = initialOriginalAmount - currentCouponDiscount;
      if (inputPoints > maxUsablePoints) {
        inputPoints = maxUsablePoints;
        displayPointWarning("최대 " + maxUsablePoints.toLocaleString() + "원까지 사용할 수 있습니다. (총 결제 금액이 0원 미만이 될 수 없습니다.)");
        $('#pointInput').val(inputPoints);
      }

      if (inputPoints > availablePoints) {
        displayPointWarning("보유 포인트(" + availablePoints.toLocaleString() + "원)를 초과하여 사용할 수 없습니다.");
        $('#pointInput').val(availablePoints); // 보유 포인트로 자동 설정
        inputPoints = availablePoints;
      }

      currentPointDiscount = inputPoints;
      updatePaymentSummary();
    });

    // 초기 로드 시 보유 포인트 표시 및 금액 업데이트
    $('#availablePoints').text(availablePoints.toLocaleString());
    updatePaymentSummary(); // 초기 금액 설정 및 표시
  });
>>>>>>> Stashed changes
</script>
</body>
</html>
