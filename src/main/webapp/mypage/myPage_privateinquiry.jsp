<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>1:1문의내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>
<h2 class="content-title">1:1문의내역</h2>
<table class="data-table">
    <thead>
        <tr>
            <th>구분</th>
            <th>제목</th>
            <th>답변상태</th>
            <th>등록일</th>
        </tr>
    </thead>
    <tbody>
    <c:set var="p" value="${requestScope.page}" scope="page"/>
    <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1">
        <tr>
            <c:set var="num" value="${p.totalCount - ((p.nowPage-1)*p.numPerPage+ vs1.index)}"/>
            <td>${num}</td>
            <td>${vo.mvo.tName}</td>
            <a href="Controller?type=userViewInquiry&boardIdx=${vo.boardIdx}">  <%--&cPage=${nowPage}--%>
                <td>${vo.boardTitle}</td>
            </a>
            <c:choose>
                <c:when test="${vo.boardStatus == 0}">
                    <td class="status-available">미답변</td>
                </c:when>
                <c:when test="${vo.boardStatus == 1}">
                    <td class="status-used">답변완료</td>
                </c:when>
            </c:choose>
            <td>${vo.boardRegDate}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
