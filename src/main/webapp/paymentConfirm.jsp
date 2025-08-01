<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title>결제 결과</title>
  <c:set var="basePath" value="${pageContext.request.contextPath}"/>
  <link rel="stylesheet" href="${basePath}/css/reset.css">
  <link rel="stylesheet" href="${basePath}/css/sub/sub_page_style.css">
  <link rel="stylesheet" href="${basePath}/css/paymentconfirm.css">
  <link rel="icon" href="${basePath}/images/favicon.png">
</head>
<body>
<header>
  <jsp:include page="jsp/sub_menu.jsp"/>
</header>
<article>
  <div class="confirmation_container">
    <c:choose>
      <%-- ==================== 결제 성공 ==================== --%>
      <c:when test="${isSuccess}">
        <c:choose>
          <%-- 🔴 영화 예매 성공 화면 (수정된 부분) 🔴 --%>
          <c:when test="${paymentType == 'paymentMovie'}">
            <h1>예매 완료</h1>
            <div class="confirmation_box">
              <div class="ticket_area">
                <div class="ticket_info">
                  <div class="ticket_label">
                    <p>티켓 예매번호</p>
                    <p class="ticket_number">${resObj.orderId}</p>
                  </div>
                  <img src="${basePath}/images/umbokdong.png" alt="영화 포스터" class="poster">
                    <%-- orderName에서 '_' 이전의 영화 제목만 추출 --%>
                  <p class="poster_title">${fn:split(resObj.orderName, '_')[0]}</p>
                </div>
              </div>
              <div class="booking_details">
                <h2>예매가 완료되었습니다!</h2>
                  <%-- 요청하신 테이블 구조와 임시값으로 변경 --%>
                <table class="details_table">
                  <tr><td class="label">예매영화</td><td class="value">${fn:split(resObj.orderName, '_')[0]}</td></tr>
                  <tr><td class="label">관람극장/상영관</td><td class="value">강남 / 프리미엄 IMAX 5관</td></tr>
                  <tr><td class="label">관람일시</td><td class="value">2025-08-12 09:00:00</td></tr>
                  <tr><td class="label">좌석번호</td><td class="value">A2 (성인), A3 (성인)</td></tr>
                  <tr><td class="label">결제정보</td><td class="value">30,000 원</td></tr>
                  <tr><td class="label">할인금액</td><td class="value">- 3,000 원</td></tr>
                  <tr><td class="label">결제금액</td><td class="value">${resObj.totalAmount} 원</td></tr>
                </table>
              </div>
            </div>
            <div class="button_container">
              <button class="btn_history" onclick="location.href='#'">예매내역 확인</button>
            </div>
          </c:when>
          <%-- 스토어 구매 성공 화면 --%>
          <c:otherwise>
            <h1>구매 완료</h1>
            <div class="store-card">
              <img src="${basePath}/images/sistboxcombo.png" alt="상품 이미지" class="poster">
              <div class="store-details">
                <p class="title">${fn:split(resObj.orderName, '_')[0]}</p>
                <p>결제금액 <span class="price">${resObj.totalAmount}원</span></p>
              </div>
            </div>
            <div class="button_container">
              <button class="btn_common btn_history" onclick="location.href='#'">나의 구매내역</button>
              <button class="btn_common btn_primary" onclick="location.href='#'">마이페이지</button>
            </div>
          </c:otherwise>
        </c:choose>
      </c:when>
      <%-- ==================== 결제 실패 ==================== --%>
      <c:otherwise>
        <div style="text-align:center; padding: 50px;">
          <h2>결제 처리 중 오류가 발생했습니다.</h2>
          <p>에러 메시지: ${errorMessage}</p>
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