<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예매/구매내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>
<h2 class="content-title">예매/구매 내역</h2>

<div class="filter-area">
    <select>
        <option>예매내역</option>
    </select>
    <select>
        <option>2025년</option>
        <option>2024년</option>
        <option>2023년</option>
        <option>2022년</option>
        <option>2021년</option>
        <option>2020년</option>
    </select>
    <button class="mybtn mybtn-primary">조회</button>
</div>

<div class="content-section">
    <c:if test="${empty reservationList}">
        <p>예매 내역이 없습니다.</p>
    </c:if>

    <c:forEach var="item" items="${reservationList}">
        <div class="reservation-card">
            <img src="${pageContext.request.contextPath}${item.posterPath}" alt="영화포스터">
            <div class="info">
                <p class="date">결제일시: ${item.paymentDate}</p>
                <p class="title">${item.movieTitle}</p>
                <p class="details">${item.theaterInfo} | ${item.screenDate}</p>
            </div>
            <div class="action">
                <button class="mybtn">취소</button>
            </div>
        </div>
    </c:forEach>
</div>

<c:if test="${not empty pvo}">
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
</body>
</html>
