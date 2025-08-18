<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제 결과</title>
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
          <%-- ==================== 영화 예매 성공 화면 ==================== --%>
          <c:when test="${paymentType == 'paymentMovie'}">
            <h1>예매 완료</h1>
            <div class="confirmation_box">
              <div class="ticket_area">
                <div class="ticket_info">
                  <div class="ticket_label">
                    <p>티켓 예매번호</p>
                    <p class="ticket_number">${tossResponse.orderId}</p>
                  </div>
                  <img src="${reservationInfo.posterUrl}" alt="포스터 이미지" class="poster">
                  <p class="poster_title">${paidItem.title}</p>
                </div>
              </div>
              <div class="booking_details">
                <h2>예매가 완료되었습니다!</h2>
                <table class="details_table">
                  <tr><td class="label">예매영화</td><td class="value">${paidItem.title}</td></tr>
                  <tr><td class="label">관람극장/상영관</td><td class="value">${paidItem.theaterName} / ${paidItem.screenName}</td></tr>
                  <tr><td class="label">관람일시</td><td class="value">${paidItem.startTime}</td></tr>
                  <tr><td class="label">좌석번호</td><td class="value">${paidItem.seatInfo}</td></tr>
                  <tr class="divider"><td colspan="2"></td></tr>
                  <tr><td class="label">상품금액</td><td class="value"><fmt:formatNumber value="${tossResponse.totalAmount + couponDiscount + pointDiscount}" pattern="#,##0" /> 원</td></tr>
                  <tr><td class="label">쿠폰 할인</td><td class="value">- <fmt:formatNumber value="${couponDiscount}" pattern="#,##0" /> 원</td></tr>
                  <tr><td class="label">포인트 사용</td><td class="value">- <fmt:formatNumber value="${pointDiscount}" pattern="#,##0" /> 원</td></tr>
                  <tr class="final_amount_row"><td class="label">최종결제금액</td><td class="value"><fmt:formatNumber value="${tossResponse.totalAmount}" pattern="#,##0" /> 원</td></tr>
                </table>
              </div>
            </div>
            <div class="button_container">
              <button class="btn_history" onclick="location.href='Controller?type=myPage'">예매내역 확인</button>
            </div>
          </c:when>

          <%-- ==================== 스토어 구매 성공 화면==================== --%>
          <c:when test="${paymentType == 'paymentStore'}">
            <h1>구매 완료</h1>
            <div class="confirmation_box store">
              <div class="store_card">
                <img src="${basePath}/${paidItem.prodImg}" alt="상품 이미지" class="poster">
                <div class="store_details">
                  <p class="title">${paidItem.prodName}</p>
                  <p class="store_black">수량: 1개</p>
                </div>
              </div>
              <div class="booking_details">
                <h2>상품 구매가 완료되었습니다!</h2>
                <table class="details_table">
                  <tr><td class="label">주문번호</td><td class="value">${tossResponse.orderId}</td></tr>
                  <tr class="divider"><td colspan="2"></td></tr>
                  <tr><td class="label">상품금액</td><td class="value"><fmt:formatNumber value="${tossResponse.totalAmount + couponDiscount + pointDiscount}" pattern="#,##0" /> 원</td></tr>
                  <tr><td class="label">쿠폰 할인</td><td class="value">- <fmt:formatNumber value="${couponDiscount}" pattern="#,##0" /> 원</td></tr>
                  <tr><td class="label">포인트 사용</td><td class="value">- <fmt:formatNumber value="${pointDiscount}" pattern="#,##0" /> 원</td></tr>
                  <tr class="final_amount_row"><td class="label">최종결제금액</td><td class="value"><fmt:formatNumber value="${tossResponse.totalAmount}" pattern="#,##0" /> 원</td></tr>
                </table>
              </div>
            </div>
            <div class="button_container">
              <button class="btn_history" onclick="location.href='Controller?type=myReservation'">나의 구매내역</button>
            </div>
          </c:when>
        </c:choose>
      </c:when>

      <%-- ==================== 결제 실패 ==================== --%>
      <c:otherwise>
        <div class="error_box">
          <h2>결제 처리 중 오류가 발생했습니다.</h2>
          <p class="error_message">에러 메시지: ${errorMessage}</p>
          <div class="button_container">
            <button class="btn_primary" onclick="location.href='${basePath}/'">메인으로 돌아가기</button>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</article>
<footer>
  <jsp:include page="common/Footer.jsp"/>
</footer>
</body>
</html>