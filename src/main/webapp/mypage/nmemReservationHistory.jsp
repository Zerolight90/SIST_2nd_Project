<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<c:if test="${empty history}">
  <p class="no-content" style="text-align: center; margin-top: 20px;">일치하는 예매/구매 내역이 없습니다. 입력 정보를 다시 확인해주세요.</p>
</c:if>

<c:if test="${not empty history}">
  <div class="history-card" style="border: 1px solid #eee; padding: 15px; margin-top: 20px;">
    <div class="details-wrapper">
      <p class="title" style="font-size: 1.2em; font-weight: bold;">${history.itemTitle}</p>
      <table class="details-table" style="width: 100%; margin-top: 15px; border-collapse: collapse;">
        <tbody style="font-size: 0.9em;">
        <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px; width: 120px;" class="label">주문번호</td><td style="padding: 8px;">${history.orderId}</td></tr>
        <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px;" class="label">결제일</td><td style="padding: 8px;"><fmt:formatDate value="${history.paymentDate}" pattern="yyyy.MM.dd"/></td></tr>
        <c:if test="${history.paymentType == 0}">
          <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px;" class="label">장소</td><td style="padding: 8px;">${history.theaterInfo}</td></tr>
          <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px;" class="label">관람일시</td><td style="padding: 8px;"><fmt:formatDate value="${history.screenDate}" pattern="yyyy.MM.dd(E) HH:mm"/></td></tr>
        </c:if>
        <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px;" class="label">상태</td><td style="padding: 8px; font-weight: bold;">
          <c:if test="${history.paymentStatus == 0}">결제완료</c:if>
          <c:if test="${history.paymentStatus == 1}">취소완료</c:if>
        </td></tr>
        </tbody>
      </table>
      <div class="action-area" style="text-align: right; margin-top: 20px;">
        <c:if test="${history.paymentStatus == 0}">
          <button class="mybtn mybtn-outline" data-payment-key="${history.paymentTransactionId}" data-order-id="${history.orderId}">
            <c:if test="${history.paymentType == 0}">예매취소</c:if>
            <c:if test="${history.paymentType == 1}">구매취소</c:if>
          </button>
        </c:if>
        <c:if test="${history.paymentStatus == 1}">
          <span class="status-label">취소된 내역</span>
        </c:if>
      </div>
    </div>
  </div>

  <script>
    // 환불 버튼 클릭 이벤트
    $(".mybtn-outline").on('click', function() {
      const paymentKey = $(this).data('payment-key');
      const orderId = $(this).data('order-id');
      // 부모 창(nmemReservation.jsp)의 입력값을 가져옴
      const name = parent.$("#name").val();
      const phone = parent.$("#phone").val();
      const password = parent.$("#password").val();

      if (confirm("정말로 이 내역을 취소하시겠습니까?")) {
        requestNmemRefund(paymentKey, orderId, name, phone, password);
      }
    });

    /**
     * 서버에 비회원 환불을 요청하는 함수
     */
    function requestNmemRefund(paymentKey, orderId, name, phone, password) {
      $.ajax({
        url: "${cp}/Controller?type=refund",
        type: "POST",
        data: {
          paymentKey: paymentKey,
          cancelReason: "고객 변심",
          isNonMember: "true",
          orderId: orderId,
          name: name,
          phone: phone,
          password: password
        },
        dataType: "json",
        success: function(res) {
          if (res.isSuccess) {
            alert("정상적으로 취소되었습니다.");
            // 부모 창의 조회 버튼을 다시 클릭하여 결과를 새로고침
            parent.$("#searchBtn").click();
          } else {
            alert("환불 처리 중 오류가 발생했습니다: " + res.errorMessage);
          }
        },
        error: function(jqXHR, textStatus) {
          // Controller가 JSON 대신 다른 응답(페이지 이동)을 보내는 경우에 대한 예외 처리
          if (textStatus === "parsererror") {
            alert("정상적으로 취소되었습니다.");
            parent.$("#searchBtn").click();
          } else {
            alert("서버와 통신하는 데 실패했습니다. 잠시 후 다시 시도해 주세요.");
          }
        }
      });
    }
  </script>
</c:if>