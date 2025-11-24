<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>SIST BOX - 결제 결과</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <%-- Font Awesome 아이콘 CDN 추가 --%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
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
      <c:when test="${isSuccess}">
        <c:choose>
          <%-- ==================== 영화 예매 성공 화면 ==================== --%>
          <c:when test="${paymentType == 'paymentMovie'}">
            <h1>예매 완료</h1>
            <div class="confirmation_box">
              <div class="ticket_info">
                <div class="ticket_label">
                  <p>TICKET NUMBER</p>
                  <p class="ticket_number">${orderId}</p>
                </div>

                  <%-- [수정] 포스터 이미지 없을 시 플레이스홀더 표시 --%>
                <c:choose>
                  <c:when test="${not empty paidItem.posterUrl}">
                    <img src="${paidItem.posterUrl}" alt="${paidItem.title} 포스터" class="poster">
                  </c:when>
                  <c:otherwise>
                    <div class="poster_placeholder">
                      <i class="fa-solid fa-image"></i>
                      <span>Poster Image Not Found</span>
                    </div>
                  </c:otherwise>
                </c:choose>
                <p class="poster_title">${paidItem.title}</p>
              </div>

              <div class="booking_details">
                <h2><i class="fa-solid fa-circle-check"></i> 예매가 성공적으로 완료되었습니다!</h2>
                <table class="details_table">
                  <tr><td class="label">예매영화</td><td class="value">${paidItem.title}</td></tr>
                  <tr><td class="label">관람극장/상영관</td><td class="value">${paidItem.theaterName} / ${paidItem.screenName}</td></tr>
                  <tr><td class="label">관람일시</td><td class="value">${fn:substring(paidItem.startTime, 0, 16)}</td></tr>
                  <tr><td class="label">좌석번호</td><td class="value">${paidItem.seatInfo}</td></tr>
                  <tr class="divider"><td colspan="2"></td></tr>
                  <tr><td class="label">상품금액</td><td class="value"><fmt:formatNumber value="${finalAmount + couponDiscount + pointDiscount}" pattern="#,##0" /> 원</td></tr>
                  <c:if test="${!isGuest and (couponDiscount > 0 or pointDiscount > 0)}">
                    <c:if test="${couponDiscount > 0}">
                      <tr><td class="label">쿠폰 할인</td><td class="value discount">- <fmt:formatNumber value="${couponDiscount}" pattern="#,##0" /> 원</td></tr>
                    </c:if>
                    <c:if test="${pointDiscount > 0}">
                      <tr><td class="label">포인트 사용</td><td class="value discount">- <fmt:formatNumber value="${pointDiscount}" pattern="#,##0" /> 원</td></tr>
                    </c:if>
                  </c:if>
                  <tr class="final_amount_row">
                    <td class="label">최종결제금액</td>
                    <td class="value"><fmt:formatNumber value="${finalAmount}" pattern="#,##0" /> 원</td>
                  </tr>
                </table>
              </div>
            </div>
            <div class="button_container">
              <a href="Controller?type=myPage&tab=myreservationHistory" class="btn_history">
                <c:choose>
                  <c:when test="${isGuest}">예매내역 확인</c:when>
                  <c:otherwise>나의 예매내역</c:otherwise>
                </c:choose>
              </a>
            </div>
          </c:when>

          <%-- ==================== 스토어 구매 성공 화면 (디자인 일관성 적용) ==================== --%>
          <c:when test="${paymentType == 'paymentStore'}">
            <h1>구매 완료</h1>
            <div class="confirmation_box">
              <div class="ticket_info store_theme">
                <p class="store_title">PURCHASE<br>RECEIPT</p>
                  <%-- [수정] 상품 이미지 없을 시 플레이스홀더 표시 --%>
                <c:choose>
                  <c:when test="${not empty paidItem.prodImg}">
                    <img src="${basePath}/images/store/${paidItem.prodImg}" alt="${paidItem.prodName} 이미지" class="poster">
                  </c:when>
                  <c:otherwise>
                    <div class="poster_placeholder">
                      <i class="fa-solid fa-image"></i>
                      <span>Product Image Not Found</span>
                    </div>
                  </c:otherwise>
                </c:choose>
                <p class="poster_title">${paidItem.prodName}</p>
                <p class="quantity">수량: ${paidItem.quantity}개</p>
              </div>
              <div class="booking_details">
                <h2><i class="fa-solid fa-circle-check"></i> 상품 구매가 성공적으로 완료되었습니다!</h2>
                <table class="details_table">
                  <tr><td class="label">주문번호</td><td class="value">${orderId}</td></tr>
                  <tr class="divider"><td colspan="2"></td></tr>
                  <tr><td class="label">상품금액</td><td class="value"><fmt:formatNumber value="${finalAmount + couponDiscount + pointDiscount}" pattern="#,##0" /> 원</td></tr>
                  <c:if test="${!isGuest and (couponDiscount > 0 or pointDiscount > 0)}">
                    <c:if test="${couponDiscount > 0}">
                      <tr><td class="label">쿠폰 할인</td><td class="value discount">- <fmt:formatNumber value="${couponDiscount}" pattern="#,##0" /> 원</td></tr>
                    </c:if>
                    <c:if test="${pointDiscount > 0}">
                      <tr><td class="label">포인트 사용</td><td class="value discount">- <fmt:formatNumber value="${pointDiscount}" pattern="#,##0" /> 원</td></tr>
                    </c:if>
                  </c:if>
                  <tr class="final_amount_row">
                    <td class="label">최종결제금액</td>
                    <td class="value"><fmt:formatNumber value="${finalAmount}" pattern="#,##0" /> 원</td>
                  </tr>
                </table>
              </div>
            </div>
            <div class="button_container">
              <a href="Controller?type=myPage&tab=myPurchaseHistory" class="btn_history">나의 구매내역</a>
            </div>
          </c:when>
        </c:choose>
      </c:when>

      <%-- ==================== 결제 실패 ==================== --%>
      <c:otherwise>
        <div class="error_box">
          <h2><i class="fa-solid fa-circle-exclamation"></i> 결제 처리 중 오류가 발생했습니다.</h2>
          <p class="error_message">에러 메시지: ${errorMessage}</p>
          <div class="button_container">
            <button class="btn_history" onclick="location.href='${basePath}/'">메인으로 돌아가기</button>
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