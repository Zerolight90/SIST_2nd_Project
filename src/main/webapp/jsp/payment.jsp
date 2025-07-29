<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제하기</title>
  <link rel="stylesheet" href="../CSS/reset.css">
  <link rel="stylesheet" href="../CSS/style.css"> <%-- 공통 스타일 --%>
  <link rel="stylesheet" href="../CSS/payment.css"> <%-- 결제 페이지 전용 스타일 --%>
  <link rel="icon" href="./images/favicon.png">
  <%-- Toss Payments SDK 로드 --%>
  <script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
<header>
  <jsp:include page="./menu.jsp"/>
</header>
<article>
  <div class="payment_container">
    <%-- 왼쪽 정보 섹션 --%>
    <div class="payment_info_section">
      <h1>결제하기</h1>

      <div class="info_group">
        <h2>예매정보</h2>
        <div class="booking_card">
          <%-- 나중에 실제 데이터로 변경할 이미지 --%>
          <img src="https://search.pstatic.net/common?type=o&size=178x267&quality=95&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20240718_172%2F1721285223063RTw6L_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2" alt="캡틴 아메리카 포스터" class="poster">
          <div class="booking_card_details">
            <p class="title">캡틴 아메리카: 브레이브 뉴 월드</p>
            <p>2025-02-12 (수) 09:00 - 10:58</p>
            <p>IMAX 관</p>
            <p>성인 2명</p>
          </div>
        </div>
      </div>

      <div class="info_group">
        <h2>할인 적용</h2>
        <div class="input_dropdown">
          <select name="coupon">
            <option value="">쿠폰 선택</option>
            <option value="4000">영화 4000원 할인 쿠폰</option>
            <option value="2000">추가 2000원 할인 쿠폰</option>
            <option value="0">적용 안함</option>
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
    </div>

    <%-- 오른쪽 결제 요약 섹션 --%>
    <div class="payment_summary_section">
      <h2>결제금액</h2>
      <div class="summary_item">
        <span>성인 2명</span>
        <span class="value">30000 원</span>
      </div>
      <div class="summary_item">
        <span>금액</span>
        <span class="value">30000 원</span>
      </div>
      <div class="summary_item">
        <span>할인적용</span>
        <span class="value">- 4000 원</span>
      </div>

      <div class="final_amount_display">
        <span>최종결제금액</span>
        <span class="amount">26,000 원</span>
      </div>

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
  const clientKey = "test_ck_oEjb0gm23PW1eebeLJmo8pGwBJn5"; // 테스트 클라이언트 키
  const tossPayments = TossPayments(clientKey);
  // 나중에 실제 로그인한 사용자 ID 등으로 customerKey를 설정하세요.
  const payment = tossPayments.payment({ customerKey: "temp_customer_123" });

  function requestPayment() {
    // 실제 결제될 금액 (나중에 JS로 계산된 값을 넣으세요)
    const finalAmount = 26000;
    const movieTitle = "캡틴 아메리카: 브레이브 뉴 월드";

    // Toss Payments 결제창 호출
    payment.requestPayment({
      method: "CARD", // 결제수단
      amount: { currency: "KRW", value: finalAmount },
      orderId: "SISTBOX_" + new Date().getTime(), // 주문번호
      orderName: movieTitle + " 예매", // 주문명
      customerName: "김쌍용", // 구매자 이름 (나중에 실제 회원 이름으로 변경)
      successUrl: window.location.origin + "/SIST_2nd_Project/jsp/paymentSuccess.jsp", // 성공 시 이동할 URL
      failUrl: window.location.origin + "/SIST_2nd_Project/jsp/paymentFail.jsp", // 실패 시 이동할 URL
    });
  }
</script>
</body>
</html>