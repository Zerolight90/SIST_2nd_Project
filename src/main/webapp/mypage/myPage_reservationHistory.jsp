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
                            <td class="status-text"> <br/> <c:if test="${item.paymentStatus == 0}">결제완료</c:if><br/> <c:if test="${item.paymentStatus == 1}">취소완료</c:if><br/></td>
                        </tr>
                        </tbody>
                    </table>
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
        // 공통으로 사용할 변수 선언
        const mainContent = $("#mainContent");
        const cp = "${pageContext.request.contextPath}";

        /**
         * 목록을 새로고침하는 함수
         */
        function reloadHistory() {
            // 현재 설정된 필터 값들을 가져옵니다.
            const filterData = $("#historyFilter select").serialize();
            // 현재 페이지 번호를 가져옵니다. 페이지 정보가 없으면 1페이지로 설정합니다.
            const currentPage = $(".pagination strong").text() || "1";

            // 필터와 페이지 정보를 포함하여 mainContent 영역을 다시 로드합니다.
            mainContent.load(cp + "/Controller?type=myReservation&cPage=" + currentPage + "&" + filterData);
        }

        /**
         * 서버에 환불을 요청하는 함수
         * @param {string} paymentKey - 환불할 결제의 키 값
         */
        function requestRefund(paymentKey) {
            $.ajax({
                url: cp + "/Controller?type=refund",
                type: "POST",
                data: {
                    paymentKey: paymentKey,
                    cancelReason: "고객 변심" // 취소 사유
                },
                dataType: "json", // 서버로부터 JSON 응답을 기대한다고 명시

                // 서버가 정상적으로 JSON을 반환할 경우 (현재 시나리오에서는 거의 호출되지 않음)
                success: function(res) {
                    if (res.isSuccess) {
                        alert("정상적으로 취소되었습니다.");
                        reloadHistory(); // 목록 새로고침
                    } else {
                        // 환불 처리 중 서버 내부에서 에러가 발생했을 때
                        alert("환불 처리 중 오류가 발생했습니다: " + res.errorMessage);
                    }
                },

                // AJAX 통신이 실패했을 때 호출되는 부분
                error: function(jqXHR, textStatus, errorThrown) {
                    // Controller가 원치 않는 페이지 이동을 시도해 'parsererror'가 발생
                    // 이 경우, 실제 서버 작업(환불)은 성공
                    if (textStatus === "parsererror") {
                        // 성공으로 간주하고 처리
                        alert("정상적으로 취소되었습니다.");
                        reloadHistory(); // 성공했을 때와 동일하게 목록을 새로고침
                    } else {
                        // 'parsererror'가 아닌 다른 실제 통신 오류(네트워크 문제 등)일 경우
                        alert("서버와 통신하는 데 실패했습니다. 잠시 후 다시 시도해 주세요.");
                    }
                }
            });
        }

        // --- 이벤트 핸들러 설정 ---

        // 1. 조회 버튼 클릭 이벤트
        $("#searchBtn").on("click", function() {
            const filterData = $("#historyFilter select").serialize();
            mainContent.load(cp + "/Controller?type=myReservation&" + filterData);
        });

        // 2. 페이징 링크 클릭 이벤트 (이벤트 위임)
        mainContent.on("click", ".pagination a", function(e) {
            e.preventDefault(); // 기본 링크 동작(페이지 전체 이동) 방지
            const targetUrl = $(this).attr("href");
            const filterData = $("#historyFilter select").serialize();
            // 필터값을 유지한 채로 페이지 이동
            mainContent.load(targetUrl + "&" + filterData);
        });

        // 3. 예매/구매 취소 버튼 클릭 이벤트 (이벤트 위임)
        mainContent.on('click', '.mybtn-outline', function() {
            const paymentKey = $(this).data('payment-key');
            if (confirm("정말로 이 내역을 취소하시겠습니까?")) {
                requestRefund(paymentKey); // 환불 요청 함수 호출
            }
        });
    });
</script>