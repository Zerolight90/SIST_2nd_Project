<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<h2 class="content-title">예매/구매 내역</h2>

<div class="filter-area" id="historyFilter">
    <%-- 1. 거래 상태 필터 --%>
    <select name="statusFilter">
        <option value="">전체내역</option>
        <option value="0" ${param.statusFilter == '0' ? 'selected' : ''}>결제완료</option>
        <option value="1" ${param.statusFilter == '1' ? 'selected' : ''}>취소완료</option>
    </select>

    <%-- 2. 상품 종류 필터 (paymentType) --%>
    <select name="typeFilter">
        <option value="">전체종류</option>
        <option value="0" ${param.typeFilter == '0' ? 'selected' : ''}>영화 예매</option>
        <option value="1" ${param.typeFilter == '1' ? 'selected' : ''}>스토어 상품</option>
    </select>

    <%-- 3. 거래 연도 필터 --%>
    <select name="yearFilter">
        <option value="">전체연도</option>
        <c:forEach var="i" begin="0" end="4">
            <c:set var="year" value="${2025 - i}" />
            <option value="${year}" ${param.yearFilter == year ? 'selected' : ''}>${year}년</option>
        </c:forEach>
    </select>

    <button type="button" class="mybtn mybtn-primary" id="searchBtn">조회</button>
</div>

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
                            <%-- 공통 정보: 주문번호, 결제일 --%>
                        <tr>
                            <td class="label">주문번호</td>
                            <td>${item.orderId}</td>
                        </tr>
                        <tr>
                            <td class="label">결제일</td>
                            <td><fmt:formatDate value="${item.paymentDate}" pattern="yyyy.MM.dd"/></td>
                        </tr>

                            <%-- ## 수정된 부분: paymentType에 따라 다른 정보를 보여주도록 분기 처리 ## --%>
                        <c:choose>
                            <%-- Case 1: 영화 예매 내역일 경우 (paymentType == 0) --%>
                            <c:when test="${item.paymentType == 0}">
                                <tr>
                                    <td class="label">장소</td>
                                    <td>${item.theaterInfo}</td>
                                </tr>
                                <tr>
                                    <td class="label">관람일시</td>
                                    <td><c:if test="${not empty item.screenDate}"><fmt:formatDate value="${item.screenDate}" pattern="yyyy.MM.dd(E) HH:mm"/></c:if></td>
                                </tr>
                                <tr>
                                    <td class="label">취소가능일시</td>
                                    <td>
                                        <c:if test="${not empty item.screenDate}">
                                            <%-- 1. 계산된 최종 시간을 'cancellationTimeMillis' 변수에 숫자로 저장 --%>
                                            <c:set var="cancellationTimeMillis" value="${item.screenDate.time - (30 * 60 * 1000)}" />

                                            <%-- 2. 새로운 Date 객체를 생성 --%>
                                            <jsp:useBean id="cancellationDate" class="java.util.Date" />

                                            <%-- 3. Date 객체에 계산된 시간(숫자)을 설정 --%>
                                            <c:set target="${cancellationDate}" property="time" value="${cancellationTimeMillis}" />

                                            <%-- 4. 완성된 Date 객체로 형식을 변환 --%>
                                            <fmt:formatDate value="${cancellationDate}" pattern="yyyy.MM.dd(E) HH:mm 까지"/>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:when>

                            <%-- Case 2: 상품 구매 내역일 경우 (paymentType == 1) --%>
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

                            <%-- 공통 정보: 상태 --%>
                        <tr>
                            <td class="label">상태</td>
                            <td>
                                <c:if test="${item.paymentStatus == 0}">결제완료</c:if>
                                <c:if test="${item.paymentStatus == 1}">취소완료</c:if>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <p style="color: red; font-size: 12px;">[디버그] paymentType: ${item.paymentType}</p>
                    <div class="action-area">
                        <c:if test="${item.paymentStatus == 0}">
                            <button class="mybtn mybtn-outline" data-payment-key="${item.paymentKey}">
                                <c:if test="${item.paymentType == 0}">예매취소</c:if>
                                <c:if test="${item.paymentType == 1}">구매취소</c:if>
                            </button>
                        </c:if>
                        <c:if test="${item.paymentStatus == 1}">
                            <span class="status-label">취소된 내역</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${not empty pvo && pvo.totalPage > 0}">
        <div class="pagination">
            <c:if test="${pvo.startPage > 1}"><a href="Controller?type=myReservation&cPage=${pvo.startPage - 1}">&lt;</a></c:if>
            <c:forEach begin="${pvo.startPage}" end="${pvo.endPage}" var="p">
                <c:choose>
                    <c:when test="${p == pvo.nowPage}"><strong>${p}</strong></c:when>
                    <c:otherwise><a href="Controller?type=myReservation&cPage=${p}">${p}</a></c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pvo.endPage < pvo.totalPage}"><a href="Controller?type=myReservation&cPage=${pvo.endPage + 1}">&gt;</a></c:if>
        </div>
    </c:if>
</div>

<script>
    $(function() {
        const mainContent = $("#mainContent");
        const cp = "${pageContext.request.contextPath}";

        // 조회 버튼 클릭 이벤트
        $("#searchBtn").on("click", function() {
            const filterData = $("#historyFilter select").serialize();
            mainContent.load(cp + "/Controller?type=myReservation&" + filterData);
        });

        // 페이징 링크 클릭 이벤트
        mainContent.on("click", ".pagination a", function(e) {
            e.preventDefault();
            const targetUrl = $(this).attr("href");
            const filterData = $("#historyFilter select").serialize();
            mainContent.load(targetUrl + "&" + filterData);
        });

        // 예매/구매 취소 버튼 클릭 이벤트
        mainContent.on('click', '.mybtn-outline', function() {
            const paymentKey = $(this).data('payment-key');
            const clickedButton = this;
            if (confirm("정말로 이 내역을 취소하시겠습니까?")) {
                requestRefund(paymentKey, clickedButton);
            }
        });

        /**
         * 서버에 환불을 요청하는 함수
         * @param {string} paymentKey - 환불할 결제의 키 값
         * @param {HTMLElement} btn - 클릭된 버튼 요소
         */
        function requestRefund(paymentKey, btn) {
            $.ajax({
                url: cp + "/Controller?type=refund",
                type: "POST",
                data: {
                    paymentKey: paymentKey,
                    cancelReason: "고객 변심"
                },
                // [수정] dataType: "json" 옵션 제거

                success: function(response) {
                    // [수정] 응답을 수동으로 JSON 파싱
                    try {
                        const res = JSON.parse(response); // 문자열을 JSON 객체로 변환
                        if (res.isSuccess) {
                            $(btn).replaceWith('<span class="status-label">취소된 내역</span>');
                        } else {
                        }
                    } catch (e) {
                        // JSON 파싱 실패 시, 받은 응답을 그대로 출력해 디버깅
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // AJAX 통신 자체가 실패했을 때만 실행됨
                }
            });
        }
    });
</script>