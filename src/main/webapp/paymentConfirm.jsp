<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>결제 완료</title>
  <c:set var="basePath" value="${pageContext.request.contextPath}"/>
  <link rel="stylesheet" href="${basePath}/CSS/reset.css">
  <link rel="stylesheet" href="${basePath}/CSS/style.css">
  <link rel="stylesheet" href="${basePath}/CSS/paymentconfirm.css">
  <link rel="icon" href="${basePath}/images/favicon.png">
</head>
<body>
<header>
  <jsp:include page="${basePath}/jsp/menu.jsp"/>
</header>
<article>
  <div class="confirmation_container">
    <c:choose>
      <c:when test="${isSuccess}">
        <c:choose>
          <c:when test="${paymentType == 'pay_movie'}">
            <h1>예매 완료</h1>
            <div class="confirmation_box">
              <div class="ticket_area">
                <div class="ticket_info">
                  <div class="ticket_label">
                    <p>티켓 예매번호</p>
                    <p class="ticket_number">20250211-0035</p>
                  </div>
                  <img src="${basePath}/images/umbokdong.png" alt="영화 포스터" class="poster">
                  <p class="poster_title">${resObj.orderName.replace(' 예매', '')}</p>
                </div>
              </div>
              <div class="booking_details">
                <h2>예매가 완료되었습니다!</h2>
                <table class="details_table">
                  <tr><td class="label">예매영화</td><td class="value">${resObj.orderName.replace(' 예매', '')}</td></tr>
                  <tr><td class="label">관람극장/상영관</td><td class="value">강남 / 프리미엄 IMAX 5관</td></tr>
                  <tr><td class="label">관람일시</td><td class="value">2025-02-12 09:00:00</td></tr>
                  <tr><td class="label">좌석번호</td><td class="value">A2 (성인), A3 (성인)</td></tr>
                  <tr><td class="label">결제정보</td><td class="value">30000 원</td></tr>
                  <tr><td class="label">할인금액</td><td class="value">4000 원</td></tr>
                  <tr><td class="label">결제금액</td><td class="value">${resObj.totalAmount} 원</td></tr>
                </table>
              </div>
            </div>
            <div class="button_container">
              <button class="btn_history">예매내역</button>
            </div>
            <div class="screening_guide">
              <h3>&#9654; 상영안내</h3>
              <p>- 쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</p>
            </div>
          </c:when>
          <c:otherwise>
            <h1>구매 완료 </h1>
            <div class="store-card">
              <img src="${basePath}/images/sistboxcombo.png" alt="상품 이미지" class="poster">
              <div class="store-details">
                <p class="title">${resObj.orderName.replace(' 구매', '')}</p>
                <p>수량 1개 | 결제금액 <span class="price">${resObj.totalAmount}원</span></p>
              </div>
            </div>
            <div class="notice-box">
              <h2>유의사항</h2>
              <ul>
                <li>본 상품의 사용 기한은 구매일로부터 92일까지입니다.</li>
                <li>유효기간 만료 후에는 결제금액의 90%에 대해 환불 요청이 가능하며, 환불 처리에 7일 이상의 시간이 소요될 수 있습니다.</li>
                <li>환불은 현금으로 환불이 포함됩니다.</li>
                <li>본 상품 환불 요청 시 쇼핑 포인트가 포함되어 있다면 환불 요청 확인 후 사용 가능 포인트로 들어갑니다.</li>
              </ul>
            </div>
            <div class="button_container">
              <button class="btn_common btn_history">나의 구매내역</button>
              <button class="btn_common btn_primary">마이페이지</button>
            </div>
          </c:otherwise>
        </c:choose>
      </c:when>
      <c:otherwise>
        <div style="text-align:center; padding: 50px;">
          <h2>결제 처리 중 오류가 발생했습니다.</h2>
          <p>에러 메시지: ${errorMessage}</p> <%-- errorMessage는 PaymentConfirmAction에서 설정 --%>
          <div class="button_container">
            <button class="btn_common btn_history" onclick="location.href='${basePath}/index.jsp'">메인으로 돌아가기</button>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</article>
<footer>
  <jsp:include page="${basePath}/jsp/Footer.jsp"/>
</footer>
</body>
</html>