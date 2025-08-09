<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
  <%-- jQuery UI CSS 추가 --%>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
</head>
<body>
<h2 class="content-title">개인정보 수정</h2>
<p>회원님의 정보를 정확히 입력해주세요.</p>
<h3 class="content-subtitle" style="margin-top: 30px; font-size: 18px;">기본 정보</h3>

<div class="form-layout">

  <div class="form-group">
    <span class="form-label">아이디</span>
    <div class="form-value">
      <c:choose>
        <c:when test="${not empty sessionScope.kvo}">
          <span>카카오톡 가입유저</span>
        </c:when>
        <c:otherwise>
          <span>${sessionScope.mvo.id}</span>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div class="form-group">
    <span class="form-label">이름</span>
    <c:choose>
      <c:when test="${not empty sessionScope.kvo}">
        <span>${sessionScope.kvo.k_name}</span>
      </c:when>

      <c:otherwise>
        <span>${sessionScope.mvo.name}</span>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="form-group">
    <span class="form-label">비밀번호</span>
    <div class="form-value">
      <span>************</span>
      <button class="mybtn mybtn-sm" id="changePwBtn">비밀번호 변경</button>
    </div>
  </div>

  <div class="form-group" id="pw-change-form" style="display: none;">
    <span class="form-label">변경할 비밀번호</span>
    <div class="form-value">
      <input type="password" placeholder="영문 숫자 특수기호 조합으로 입력">
      <button class="mybtn mybtn-sm mybtn-primary">변경</button>
    </div>
  </div>

  <div class="form-group">
    <span class="form-label">휴대폰</span>
    <div class="form-value">
      <c:choose>
        <c:when test="${not empty sessionScope.kvo}">
          <input name="u_phone" value="${sessionScope.mvo.phone}"/>
        </c:when>

        <c:otherwise>
          <input name="u_phone" value="${sessionScope.mvo.phone}"/>
        </c:otherwise>
      </c:choose>
      <button class="mybtn mybtn-sm" id="changePhoneBtn">휴대폰번호 변경</button>
    </div>
  </div>

  <div class="form-group" id="phone-change-form" style="display: none;">
    <span class="form-label">변경할 휴대폰 번호</span>
    <div class="form-value">
      <input type="text" placeholder="'-' 없이 입력">
      <button class="mybtn mybtn-sm mybtn-primary">변경</button>
    </div>
  </div>

  <%--  생년월일 UI Datepicker 방식               --%>
  <div class="form-group">
    <span class="form-label">생년월일</span>
    <div class="form-value">
      <c:choose>
        <c:when test="${not empty sessionScope.kvo}">
          <input type="text" id="birthdate-picker" value="${sessionScope.mvo.birth}"/></input>
        </c:when>
        <c:otherwise>
          <input type="text" id="birthdate-picker" value="${sessionScope.mvo.birth}"/></input>
        </c:otherwise>
      </c:choose>
      <button class="mybtn mybtn-sm">생년월일 변경</button>
    </div>
  </div>
  <%-- ========================================================== --%>

  <div class="form-group">
    <span class="form-label">이메일</span>
    <c:choose>
      <c:when test="${not empty sessionScope.kvo}">
        <span>${sessionScope.kvo.k_email}</span>
      </c:when>
      <c:otherwise>
        <span>${sessionScope.mvo.email}</span>
      </c:otherwise>
    </c:choose>
  </div>

  <div id="my_btn" class="form-group">
    <button class="mybtn mybtn-change">정보수정</button>
    <button class="mybtn mybtn-exit">회원탈퇴</button>
  </div>

</div>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script>
  // 간단한 토글(보이기/숨기기) 기능을 위한 스크립트
  document.getElementById('changePhoneBtn').addEventListener('click', function() {
    var form = document.getElementById('phone-change-form');
    // jQuery의 slideToggle 효과로 변경
    $('#phone-change-form').toggle();
  });

  document.getElementById('changePwBtn').addEventListener('click', function() {
    var form = document.getElementById('pw-change-form');
    // jQuery의 slideToggle 효과로 변경
    $('#pw-change-form').toggle();
  });

  // jQuery UI Datepicker 활성화 코드
  $(function() {
    $("#birthdate-picker").datepicker({
      dateFormat: 'yy-mm-dd', // 날짜 형식 (DB와 일치)
      changeMonth: true,      // 월을 바꿀 수 있는 드롭다운 표시
      changeYear: true,       // 년을 바꿀 수 있는 드롭다운 표시
      yearRange: 'c-100:c+0', // 현재년도 기준 100년 전부터 현재까지 선택 가능
      dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
      monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    });
  });
</script>
</body>
</html>