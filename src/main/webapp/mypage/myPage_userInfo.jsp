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
          <input name="u_phone" value="${sessionScope.kvo.phone}"/> <%-- 카카오 유저일 경우 kvo.phone으로 변경 --%>
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

  <%--  생년월일 UI Datepicker 방식--%>
  <div class="form-group">
    <span class="form-label">생년월일</span>
    <div class="form-value">
      <c:choose>
        <c:when test="${not empty sessionScope.kvo}">
          <input type="text" id="start_reg_date" value="${sessionScope.mvo.birth}"/> <%-- 카카오 유저일 경우 kvo.birth로 변경 --%>
        </c:when>

        <c:otherwise>
          <input type="text" id="start_reg_date" value="${sessionScope.mvo.birth}"/>
        </c:otherwise>
      </c:choose>
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

  if ($.datepicker) {

    if (typeof $.datepicker._handleMouseover !== 'undefined') {
      var originalHandleMouseover = $.datepicker._handleMouseover;
      $.datepicker._handleMouseover = function(event) {
        if (this.datepicker_instActive === undefined || this.datepicker_instActive === null) {

          return;
        }
        // 원본 함수 호출
        originalHandleMouseover.apply(this, arguments);
      };
    }
  }

  // 전화번호 변경 폼 토글 기능을 위한 스크립트
  $('#changePhoneBtn').on('click', function() {
    $('#phone-change-form').slideToggle();
  });

  // 비밀번호 변경 폼 토글 기능을 위한 스크립트
  $('#changePwBtn').on('click', function() {
    $('#pw-change-form').slideToggle();
  });


  $(document).ready(function() {
    if ($.datepicker) {
      $("#start_reg_date").datepicker({
        dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
        monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
        showMonthAfterYear: true,
        yearSuffix: "년",
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        changeYear: true,
        yearRange: 'c-100:c+0'
      });
    }
  });


  // "정보수정" 버튼 클릭 시 생년월일 업데이트 AJAX 요청
  $('#my_btn .mybtn-change').on('click', function() {
    const birthdatePicker = $("#start_reg_date");
    const birthdateValue = birthdatePicker.val();
    let isBirthdateUpdateHandled = false; // 생년월일 업데이트가 처리되었는지 여부 플래그

    // 생년월일 입력 필드가 활성화되어 있고, 값이 있는 경우에만 AJAX 요청 전송
    if (!birthdatePicker.prop('disabled') && birthdateValue) {
      isBirthdateUpdateHandled = true;

      $.ajax({
        url: '/Controller?type=userinfo',
        type: 'POST',
        data: {
          action: 'updateBirthdate',
          birth: birthdateValue // 파라미터 이름 일치
        },
        dataType: 'json',
        success: function(response) {
          if (response.success) {
            alert(response.message);
            birthdatePicker.prop('disabled', true);
            // 성공 시 세션 정보를 갱신하기 위해 페이지 새로고침을 고려할 수 있습니다.
            // location.reload();
          } else {
            alert(response.message);
          }
        },
        error: function(xhr, status, error) {
          console.error("AJAX Error:", status, error);
          alert('생년월일 업데이트 중 오류가 발생했습니다.');
        }
      });
    } else if (!birthdatePicker.prop('disabled') && !birthdateValue) {
      alert('생년월일을 입력해주세요.');
      isBirthdateUpdateHandled = true; // 생년월일 관련 알림이 발생했으므로 처리된 것으로 간주
    }

    // 생년월일 업데이트 관련 로직이 처리되지 않았을 때만 "다른 정보" 메시지 출력
    if (!isBirthdateUpdateHandled) {
      alert('다른 정보가 업데이트되었습니다.');
    }
    // 이 부분에서 다른 정보 업데이트를 위한 AJAX 요청을 추가할 수 있습니다.
    // 예를 들어, 비밀번호나 휴대폰 번호 변경 로직 등
  });

  // 회원 탈퇴 버튼 클릭 시 경고 메시지
  $('#my_btn .mybtn-exit').on('click', function() {
    if (confirm('정말로 회원 탈퇴하시겠습니까? 탈퇴하시면 모든 정보가 삭제되며 되돌릴 수 없습니다.')) {
      // 여기에 회원 탈퇴 처리 로직 (예: 서버 요청)을 추가
      alert('회원 탈퇴가 완료되었습니다.');
      // location.href = '${cp}/Controller?type=logout'; // 로그아웃 또는 메인 페이지로 이동
    }
  });

</script>
</body>
</html>
