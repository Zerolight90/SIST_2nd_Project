<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>멤버십 포인트</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>
<h2 class="content-title">포인트 이용내역</h2>
<div class="point-summary-box">
  <div class="available-points">
    <h3>사용가능 포인트</h3>
    <%-- [최종] request에 담긴 memberInfo 사용 --%>
    <span class="points"><fmt:formatNumber value="${memberInfo.totalPoints}" pattern="#,##0" /> P</span>
  </div>
  <div class="point-details">
    <table>
      <tr><td class="total">총 보유</td>
        <%-- [최종] request에 담긴 memberInfo 사용 --%>
        <td class="value total"><fmt:formatNumber value="${memberInfo.totalPoints}" pattern="#,##0" /> P</td></tr>
    </table>
  </div>
</div>
<table class="data-table">
  <thead><tr><th>일자</th><th>구분</th><th>내용</th><th>포인트</th></tr></thead>
  <tbody>
  <c:if test="${empty pointHistory}">
    <tr><td colspan="4" class="no-content">포인트 이용 내역이 없습니다.</td></tr>
  </c:if>
  <c:forEach var="p" items="${pointHistory}">
    <tr>
      <td><fmt:formatDate value="${p.transactionDate}" pattern="yyyy-MM-dd"/></td>
      <td>${p.amount > 0 ? '추가' : '사용'}</td>
      <td>${p.description}</td>
      <td style="${p.amount < 0 ? 'color: #c0392b;' : ''}">
        <c:if test="${p.amount > 0}">+</c:if>
        <fmt:formatNumber value="${p.amount}" pattern="#,##0" />P
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>