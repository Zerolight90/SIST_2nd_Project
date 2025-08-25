<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cp" value="${pageContext.request.contextPath}" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">

<h2 class="content-title">예매/구매 내역</h2>

<%-- 필터링 영역 --%>
<div class="filter-area" id="historyFilter">
    <select name="statusFilter">
        <option value="">전체내역</option>
        <option value="0" ${param.statusFilter == '0' ? 'selected' : ''}>결제완료</option>
        <option value="1" ${param.statusFilter == '1' ? 'selected' : ''}>취소완료</option>
    </select>
    <select name="typeFilter">
        <option value="">전체종류</option>
        <option value="0" ${param.typeFilter == '0' ? 'selected' : ''}>영화 예매</option>
        <option value="1" ${param.typeFilter == '1' ? 'selected' : ''}>스토어 상품</option>
    </select>
    <select name="yearFilter">
        <option value="">전체연도</option>
        <c:forEach var="i" begin="0" end="4">
            <c:set var="year" value="${2025 - i}" />
            <option value="${year}" ${param.yearFilter == year ? 'selected' : ''}>${year}년</option>
        </c:forEach>
    </select>
    <button type="button" class="mybtn mybtn-primary" id="searchBtn">조회</button>
</div>

<c:set var="nowMillis" value="<%= new java.util.Date().getTime() %>" />

<div id="reservationContent">
    <div class="content-section">
        <c:if test="${empty historyList}">
            <p class="no-content">조회된 예매/구매 내역이 없습니다.</p>
        </c:if>

        <c:forEach var="item" items="${historyList}">
            <div class="history-card">
                <img src="${item.itemPosterUrl}" alt="포스터/상품이미지" class="poster">

                <div class="details-wrapper">
                    <p class="title">${item.itemTitle}</p>
                    <table class="details-table">
                        <tbody>
                        <tr>
                            <td class="label">주문번호</td>
                            <td>${item.orderId}</td>
                        </tr>
                        <tr>
                            <td class="label">결제일</td>
                            <td><fmt:formatDate value="${item.paymentDate}" pattern="yyyy.MM.dd"/></td>
                        </tr>
                        <c:choose>
                            <c:when test="${item.paymentType == 0}">
                                <tr>
                                    <td class="label">장소</td>
                                    <td>${item.theaterInfo}</td>
                                </tr>
                                <tr>
                                    <td class="label">관람일시</td>
                                    <td><fmt:formatDate value="${item.screenDate}" pattern="yyyy.MM.dd(E) HH:mm"/></td>
                                </tr>
                                <tr>
                                    <td class="label">취소가능일시</td>
                                    <td>
                                        <c:if test="${not empty item.screenDate}">
                                            <c:set var="cancellationMillis" value="${item.screenDate.time - (30 * 60 * 1000)}" />
                                            <jsp:useBean id="cancellationDate" class="java.util.Date" />
                                            <jsp:setProperty name="cancellationDate" property="time" value="${cancellationMillis}" />
                                            <fmt:formatDate value="${cancellationDate}" pattern="yyyy.MM.dd(E) HH:mm 까지"/>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td class="label">수량</td>
                                    <td>${item.quantity}개</td>
                                </tr>
                                <tr>
                                    <td class="label">가격</td>
                                    <td><fmt:formatNumber value="${item.prodPrice}" pattern="#,##0" />원</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        <tr>
                            <td class="label">상태</td>
                            <td>
                                <c:if test="${item.paymentStatus == 0}"><span class="status-completed">결제완료</span></c:if>
                                <c:if test="${item.paymentStatus == 1}"><span class="status-cancelled">취소완료</span></c:if>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="action-area">
                    <c:if test="${item.paymentStatus == 0}">
                        <c:choose>
                            <c:when test="${item.paymentType == 0 and not empty item.screenDate}">
                                <c:set var="deadline" value="${item.screenDate.time - (30 * 60 * 1000)}" />
                                <c:set var="isExpired" value="${nowMillis > deadline}" />

                                <button class="mybtn mybtn-outline ${isExpired ? 'mybtn-disabled' : ''}"
                                        data-payment-key="${item.paymentKey}"
                                        data-order-id="${item.orderId}"
                                    ${isExpired ? 'disabled' : ''}>
                                        ${isExpired ? '취소기간만료' : '예매취소'}
                                </button>
                            </c:when>

                            <c:when test="${item.paymentType == 1}">
                                <button class="mybtn mybtn-outline" data-payment-key="${item.paymentKey}" data-order-id="${item.orderId}">
                                    구매취소
                                </button>
                            </c:when>
                        </c:choose>
                    </c:if>
                    <c:if test="${item.paymentStatus == 1}">
                        <button class="mybtn mybtn-outline mybtn-disabled" disabled>취소된 내역</button>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <%-- 페이징 영역 --%>
    <c:if test="${not empty pvo && pvo.totalPage > 0}">
        <div class="pagination">
            <c:if test="${pvo.startPage > 1}"><a href="${cp}/Controller?type=myReservation&cPage=${pvo.startPage - 1}">&lt;</a></c:if>
            <c:forEach begin="${pvo.startPage}" end="${pvo.endPage}" var="p">
                <c:choose>
                    <c:when test="${p == pvo.nowPage}"><strong>${p}</strong></c:when>
                    <c:otherwise><a href="${cp}/Controller?type=myReservation&cPage=${p}">${p}</a></c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pvo.endPage < pvo.totalPage}"><a href="${cp}/Controller?type=myReservation&cPage=${pvo.endPage + 1}">&gt;</a></c:if>
        </div>
    </c:if>
</div>
<script>
    $(function() {
        const mainContent = $("#mainContent");
        const cp = "${cp}";

        function requestRefund(paymentKey, orderId, $button, originalText) {
            const isNonMember = ("${not empty sessionScope.nmemvo}" === "true");
            let refundData = {
                paymentKey: paymentKey,
                cancelReason: "고객 변심",
                isNonMember: isNonMember
            };

            if (isNonMember) {
                refundData.name = "${sessionScope.nmemvo.name}";
                refundData.phone = "${sessionScope.nmemvo.phone}";
                refundData.password = "${sessionScope.nmemvo.password}";
                refundData.orderId = orderId;
            }

            $.ajax({
                url: cp + "/Controller?type=refund",
                type: "POST",
                data: refundData,
                dataType: "json",
                // success 핸들러로 모든 성공 로직을 옮김
                success: function(res) {
                    if (res.isSuccess) {
                        alert("정상적으로 취소되었습니다.");
                        location.reload();
                    } else {
                        // isSuccess가 false인 경우 (서버에서 처리 중 에러 발생)
                        alert("환불 처리 중 오류가 발생했습니다: " + res.errorMessage);
                        $button.prop('disabled', false).text(originalText);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert("정상적으로 취소되었습니다.");
                    location.reload();
                }
            });
        }

        // 조회 버튼 클릭 이벤트
        $("#searchBtn").on("click", function() {
            const filterData = $("#historyFilter select").serialize();
            mainContent.load(cp + "/Controller?type=myReservation&" + filterData);
        });

        // 페이지네이션 링크 클릭 이벤트
        mainContent.on("click", ".pagination a", function(e) {
            e.preventDefault();
            const targetUrl = $(this).attr("href");
            const filterData = $("#historyFilter select").serialize();
            mainContent.load(targetUrl + "&" + filterData);
        });

        // 예매/구매취소 버튼 클릭 이벤트
        mainContent.on('click', '.mybtn-outline:not(.mybtn-disabled)', function(e) {
            e.preventDefault();
            const $clickedButton = $(this);
            const originalText = $clickedButton.text();

            const paymentKey = $clickedButton.data('payment-key');
            const orderId = $clickedButton.data('order-id');

            if (confirm("정말로 이 내역을 취소하시겠습니까?")) {
                $clickedButton.prop('disabled', true).text('취소 중...');
                requestRefund(paymentKey, orderId, $clickedButton, originalText);
            }
        });
    });
</script>