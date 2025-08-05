<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
  <jsp:include page="common/sub_menu.jsp"/>
</header>
<article>
  <div class="confirmation_container">
    <c:choose>
      <%-- ==================== 결제 성공 ==================== --%>
      <c:when test="${isSuccess}">
        <c:choose>
          <%-- 영화 예매 성공 화면 --%>
          <c:when test="${paymentType == 'paymentMovie'}">
            <h1>예매 완료</h1>
            <div class="confirmation_box">
              <div class="ticket_area">
                <div class="ticket_info">
                  <div class="ticket_label">
                    <p>티켓 예매번호</p>
                    <p class="ticket_number">${tossResponse.orderId}</p>
                  </div>
                  <img src="${basePath}/${paidReservation.posterUrl}" alt="영화 포스터" class="poster">
                  <p class="poster_title">${paidReservation.title}</p>
                </div>
              </div>
              <div class="booking_details">
                <h2>예매가 완료되었습니다!</h2>
                <table class="details_table">
                  <tr><td class="label">예매영화</td><td class="value">${paidReservation.title}</td></tr>
                  <tr><td class="label">관람극장/상영관</td><td class="value">${paidReservation.theaterName} / ${paidReservation.screenName}</td></tr>
                  <tr><td class="label">관람일시</td><td class="value">${paidReservation.startTime}</td></tr>
                  <tr><td class="label">좌석번호</td><td class="value">${paidReservation.seatInfo}</td></tr>
                  <tr><td class="label">상품금액</td><td class="value"><fmt:formatNumber value="${tossResponse.totalAmount + tossResponse.discount.amount}" pattern="#,##0" /> 원</td></tr>
                  <tr><td class="label">할인금액</td><td class="value">- <fmt:formatNumber value="${tossResponse.discount.amount}" pattern="#,##0" /> 원</td></tr>
                  <tr><td class="label">최종결제금액</td><td class="value"><fmt:formatNumber value="${tossResponse.totalAmount}" pattern="#,##0" /> 원</td></tr>
                </table>
              </div>
            </div>
            <div class="button_container">
              <button class="btn_history" onclick="location.href='Controller?type=myPage'">예매내역 확인</button>
            </div>
          </c:when>
          <%-- 스토어 구매 성공 화면 --%>
          <c:otherwise>
            <%-- 스토어 결제 성공 로직 --%>
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
  <jsp:include page="${basePath}/common/Footer.jsp"/>
</footer>
</body>
</html>