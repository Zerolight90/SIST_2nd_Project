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

<%-- 예매/구매 내역 표시 영역 --%>
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

                            <%-- 영화 예매 / 스토어 구매 분기 처리 --%>
                        <c:choose>
                            <c:when test="${item.paymentType == 0}"> <%-- 영화 예매 --%>
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
                                            <%-- 상영 시작 30분 전까지 취소 가능 --%>
                                            <jsp:useBean id="cancellationDate" class="java.util.Date" />
                                            <c:set target="${cancellationDate}" property="time" value="${item.screenDate.time - (30 * 60 * 1000)}" />
                                            <fmt:formatDate value="${cancellationDate}" pattern="yyyy.MM.dd(E) HH:mm 까지"/>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise> <%-- 스토어 구매 --%>
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

                        <%-- 버튼 영역 --%>
                    <div class="action-area">
                        <c:if test="${item.paymentStatus == 0}">
                            <%-- 현재 시간을 long 타입(밀리초)으로 가져오기 --%>
                            <c:set var="nowMillis" value="<%= new java.util.Date().getTime() %>" />
                            <%-- 취소 마감 시간을 long 타입으로 계산 --%>
                            <c:set var="cancellationDeadlineMillis" value="${item.screenDate.time - (30 * 60 * 1000)}" />

                            <c:choose>
                                <%-- 영화 예매이고, 취소 가능 시간이 지났을 경우 --%>
                                <c:when test="${item.paymentType == 0 && nowMillis > cancellationDeadlineMillis}">
                                    <span class="status-label">취소 기간 만료</span>
                                </c:when>
                                <%-- 그 외 모든 경우 (스토어 상품, 취소 가능한 영화 예매) --%>
                                <c:otherwise>
                                    <button class="mybtn mybtn-outline"
                                            data-payment-key="${item.paymentKey}"
                                            data-order-id="${item.orderId}">
                                        <c:if test="${item.paymentType == 0}">예매취소</c:if>
                                        <c:if test="${item.paymentType == 1}">구매취소</c:if>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${item.paymentStatus == 1}">
                            <span class="status-label">취소된 내역</span>
                        </c:if>
                    </div>
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

        function reloadHistory() {
            const filterData = $("#historyFilter select").serialize();
            const currentPage = $(".pagination strong").text() || "1";
            mainContent.load(cp + "/Controller?type=myReservation&cPage=" + currentPage + "&" + filterData);
        }

        function requestRefund(paymentKey, orderId) {
            // 비회원인지 여부를 세션 정보로 판단
            const isNonMember = ("${not empty sessionScope.nmenvo}" === "true");

            let refundData = {
                paymentKey: paymentKey,
                cancelReason: "고객 변심",
                isNonMember: isNonMember
            };

            // 비회원일 경우, 환불에 필요한 추가 인증 정보를 객체에 담음
            if (isNonMember) {
                refundData.name = "${sessionScope.nmenvo.name}";
                refundData.phone = "${sessionScope.nmenvo.phone}";
                refundData.password = "${sessionScope.nmenvo.password}";
                refundData.orderId = orderId;
            }

            $.ajax({
                url: cp + "/Controller?type=refund",
                type: "POST",
                data: refundData,
                dataType: "json",

                success: function(res) {
                    if (res.isSuccess) {
                        alert("정상적으로 취소되었습니다.");
                        reloadHistory();
                    } else {
                        alert("환불 처리 중 오류가 발생했습니다: " + res.errorMessage);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // RefundAction이 redirect를 시도하여 발생하는 parsererror는 성공으로 간주
                    if (textStatus === "parsererror") {
                        alert("정상적으로 취소되었습니다.");

                        // 비회원은 마이페이지 메인으로, 회원은 현재 목록을 새로고침
                        if (isNonMember) {
                            location.href = cp + "/Controller?type=myPage";
                        } else {
                            reloadHistory();
                        }
                    } else {
                        alert("서버와 통신하는 데 실패했습니다. 잠시 후 다시 시도해 주세요.");
                    }
                }
            });
        }

        // --- 이벤트 핸들러 ---
        $("#searchBtn").on("click", function() {
            const filterData = $("#historyFilter select").serialize();
            mainContent.load(cp + "/Controller?type=myReservation&" + filterData);
        });

        mainContent.on("click", ".pagination a", function(e) {
            e.preventDefault();
            const targetUrl = $(this).attr("href");
            const filterData = $("#historyFilter select").serialize();
            mainContent.load(targetUrl + "&" + filterData);
        });

        mainContent.on('click', '.mybtn-outline', function() {
            const paymentKey = $(this).data('payment-key');
            const orderId = $(this).data('order-id'); // orderId 추가
            if (confirm("정말로 이 내역을 취소하시겠습니까?")) {
                requestRefund(paymentKey, orderId); // orderId 인자 전달
            }
        });
    });
</script>