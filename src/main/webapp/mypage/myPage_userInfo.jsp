<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>
  <h2 class="content-title">개인정보 수정</h2>
  <p>회원님의 정보를 정확히 입력해주세요.</p>
  <h3 class="content-subtitle" style="margin-top: 30px; font-size: 18px;">기본 정보</h3>
  <div class="form-layout">
    <div class="form-group">
      <span class="form-label">아이디</span>
      <div class="form-value">
        <span>zuirune</span>
        <button class="btn btn-sm">회원탈퇴</button>
      </div>
    </div>
    <div class="form-group">
      <span class="form-label">이름</span>
      <div class="form-value">김쌍용</div>
    </div>
    <div class="form-group">
      <span class="form-label">휴대폰</span>
      <div class="form-value">
        <span>010-1234-5678</span>
        <button class="btn btn-sm">휴대폰번호 변경</button>
      </div>
    </div>
    <div class="form-group" id="phone-change-form" style="display: none;">
      <span class="form-label">변경할 휴대폰 번호</span>
      <div class="form-value">
        <input type="text" placeholder="'-' 없이 입력">
        <button class="btn btn-sm btn-primary">변경</button>
      </div>
    </div>
    <div class="form-group">
      <span class="form-label">이메일</span>
      <div class="form-value">abc@gmail.com</div>
    </div>
    <div class="form-group">
      <span class="form-label">비밀번호</span>
      <div class="form-value">
        <button class="btn btn-sm">비밀번호 변경</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
