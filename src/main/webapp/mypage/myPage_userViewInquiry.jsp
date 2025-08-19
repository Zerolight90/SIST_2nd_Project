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
<p>고객센터를 통해 남기신 1:1 문의내역을 확인하실 수 있습니다.</p>

<div class="inner-wrap">
    <div class="container">

        <div class="page-content-event">
            <c:if test="${requestScope.vo ne null}">
                <c:set var="vo" value="${requestScope.vo}"/>
            </c:if>
            <!-- 상단 탭 -->
            <div class="page-title">
                <h2 class="tit">${vo.boardTitle}</h2>
                <div class="event-detail-date">
                    <span>답변 상태</span>
                    <c:choose>
                        <c:when test="${vo.boardStatus == 0}">
                            <div class="status-available">미답변</div>
                        </c:when>
                        <c:when test="${vo.boardStatus == 1}">
                            <div class="status-used">답변완료</div>
                        </c:when>
                    </c:choose>
                </div>

                <div>
                    ${vo.boardContent}
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>
