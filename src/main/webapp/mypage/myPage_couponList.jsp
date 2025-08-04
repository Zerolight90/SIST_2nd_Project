<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>제휴쿠폰</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>
<h2 class="content-title">제휴쿠폰</h2>
<table class="data-table">
  <thead><tr><th>구분</th><th>쿠폰명</th><th>유효기간</th><th>사용상태</th></tr></thead>
  <tbody>
  <tr><td>할인</td><td class="item-title">신규 가입 웰컴 영화 할인 쿠폰</td><td>~ 2025-12-31</td><td class="status-available">사용가능</td></tr>
  <tr><td>할인</td><td class="item-title">영화 4000원 할인 쿠폰</td><td>~ 2025-01-31</td><td class="status-used">사용완료</td></tr>
  </tbody>
</table>
</body>
</html>
