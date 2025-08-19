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
  <thead><tr><th>구분</th><th>쿠폰명</th><th>유효기간</th><th>사용상태</th></tr></thead>
  <tbody>
  <c:forEach var="coupon" items="${couponList}">
    <tr>
      <td>${coupon.couponCategory}</td>
      <td class="item-title">${coupon.couponName}</td>
      <td>~ <fmt:formatDate value="${coupon.couponExpDate}" pattern="yyyy-MM-dd"/></td>
      <c:choose>
        <c:when test="${coupon.couponStatus == 0 and coupon.couponExpDate > now}">
          <td class="status-available">사용가능</td>
        </c:when>
        <c:when test="${coupon.couponStatus == 1}">
          <td class="status-used">사용완료</td>
        </c:when>
        <c:otherwise>
          <td class="status-expired">기간만료</td>
        </c:otherwise>
      </c:choose>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>
