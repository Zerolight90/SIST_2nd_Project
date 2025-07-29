<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SIST MOVIEPLEX - 나의 결제 내역</title>
  <link rel="stylesheet" href="./CSS/style.css">
  <link rel="stylesheet" href="./CSS/reset.css"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="icon" href="./images/favicon.png">
</head>
<body>
<header>
  <jsp:include page="./menu.jsp"/>
</header>

<article>
  <h1>나의 결제 내역</h1>

  <div class="payment-table-container">
    <c:choose>
      <c:when test="${not empty paymentList}">
        <table class="payment-table">
          <thead>
          <tr>
            <th>결제 ID</th>
            <th>결제 종류</th>
            <th>주문 번호</th>
            <th>총 결제 금액</th>
            <th>할인 금액</th>
            <th>실제 결제 금액</th>
            <th>결제 수단</th>
            <th>결제 상태</th>
            <th>결제일</th>
            <th>액션</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="payment" items="${paymentList}">
            <tr>
              <td>${payment.paymentIdx}</td>
              <td>
                <c:choose>
                  <c:when test="${payment.paymentType == 1}">영화</c:when>
                  <c:when test="${payment.paymentType == 2}">상품</c:when>
                  <c:otherwise>기타</c:otherwise>
                </c:choose>
              </td>
              <td>${payment.orderId}</td>
              <td><fmt:formatNumber value="${payment.paymentTotal}" type="number"/>원</td>
              <td><fmt:formatNumber value="${payment.paymentDiscount}" type="number"/>원</td>
              <td><fmt:formatNumber value="${payment.paymentFinal}" type="number"/>원</td>
              <td>${payment.paymentMethod}</td>
              <td>
                <c:choose>
                  <c:when test="${payment.paymentStatus == 0}"><span class="status-0">완료</span></c:when>
                  <c:when test="${payment.paymentStatus == 1}"><span class="status-1">취소</span></c:when>
                  <c:otherwise>알 수 없음</c:otherwise>
                </c:choose>
              </td>
              <td><fmt:formatDate value="${payment.paymentDate}" pattern="yyyy.MM.dd HH:mm"/></td>
              <td>
                <c:if test="${payment.paymentStatus == 0}"> <%-- 결제 완료 상태일 때만 환불 가능 (0: 완료) --%>
                  <form action="Controller" method="post" onsubmit="return confirmRefund(this);">
                    <input type="hidden" name="type" value="refund">
                    <input type="hidden" name="paymentKey" value="${payment.paymentTransactionId}">
                    <input type="hidden" name="cancelReason" value="사용자 요청"> <%-- 기본 취소 사유 --%>
                    <button type="submit" class="refund-button">환불</button>
                  </form>
                </c:if>
                <c:if test="${payment.paymentStatus == 1}"> <%-- 취소 상태일 때 (1: 취소) --%>
                  <button type="button" class="refund-button" disabled>환불 완료</button>
                </c:if>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:when>
      <c:otherwise>
        <p class="no-payments">조회된 결제 내역이 없습니다.</p>
      </c:otherwise>
    </c:choose>
  </div>
</article>
<footer>
<jsp:include page="./Footer.jsp"/>
</footer>

<script>
  function confirmRefund(form) {
    const paymentKey = form.elements['paymentKey'].value;
    const confirmMessage = `결제 ID "${paymentKey}" 에 대한 환불을 진행하시겠습니까?\n이 작업은 되돌릴 수 없습니다.`;
    return confirm(confirmMessage);
  }
</script>
</body>
</html>