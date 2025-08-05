<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <div class="available-points"><h3>사용가능 포인트</h3><span class="points">11,150 P</span></div>
  <div class="point-details">
    <table>
      <tr><td>매표</td><td class="value">17,650</td></tr>
      <tr><td>매점</td><td class="value">2,600</td></tr>
      <tr><td class="total">총 보유</td><td class="value total">20,250 P</td></tr>
    </table>
  </div>
</div>
<table class="data-table">
  <thead><tr><th>일자</th><th>구분</th><th>내용</th><th>포인트</th></tr></thead>
  <tbody>
  <tr><td>2025-02-11</td><td>적립</td><td>PAYMENT</td><td>+ 2,500P</td></tr>
  <tr><td>2025-02-11</td><td>사용</td><td>PAYMENT</td><td style="color: #c0392b;">- 4,000P</td></tr>
  </tbody>
</table>
</body>
</html>
