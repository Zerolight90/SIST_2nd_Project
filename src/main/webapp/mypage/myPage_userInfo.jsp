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
<%--  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">--%>


</head>
<body>
<h2 class="content-title">개인정보 수정</h2>
<p>회원님의 정보를 정확히 입력해주세요.</p>
<h3 class="content-subtitle" style="margin-top: 30px; font-size: 18px;">기본 정보</h3>

<div class="form-layout">

  <div class="form-group">
    <span class="form-label">아이디</span>
    <c:choose>
      <c:when test="${not empty sessionScope.kvo}">
        <strong><span>카카오 가입 유저</span></strong>
      </c:when>

      <c:when test="${not empty sessionScope.nvo}">
        <strong><span>네이버 가입 유저</span></strong>
      </c:when>

      <c:when test="${not empty sessionScope.mvo}">
        <strong><span>${sessionScope.mvo.id}</span></strong>
      </c:when>

      <c:otherwise>
        <strong><span>비회원</span></strong>
      </c:otherwise>
    </c:choose>
  </div>


  <div class="form-group">
    <span class="form-label">이름</span>
    <div class="form-value">
      <%-- kvo,nvo 유저의 경우에도 mvo 데이터를 사용하도록 수정 --%>
      <strong><span>${sessionScope.mvo.name}</span></strong>
    </div>
  </div>


  <div class="form-group">
    <span class="form-label">비밀번호</span>
    <c:choose>
      <c:when test="${not empty sessionScope.kvo}">
        <div class="form-value">
          <input type="password" id="pw_password" disabled/>
        </div>
      </c:when>

      <c:when test="${not empty sessionScope.nvo}">
        <div class="form-value">
          <input type="password" id="pw_password" disabled/>
        </div>
      </c:when>

      <c:when test="${not empty sessionScope.mvo}">
        <div class="form-value">
          <input type="password" id="pw_password" VALUE="${sessionScope.mvo.pw}" disabled/>
          <button class="mybtn mybtn-sm" id="changePwBtn">비밀번호 변경</button>
        </div>
      </c:when>

      <c:otherwise>
        <div class="form-value">
          <input type="password" id="pw_password" />
        </div>
      </c:otherwise>
    </c:choose>
  </div>


  <div id="pw-change-form" style="display: none;">
    <div class="form-group">
      <span class="form-label">현재 비밀번호</span>
      <div class="form-value">
        <input type="password" id="current_password_input" name="u_pw" placeholder="현재 비밀번호를 입력하세요." />
        <span id="pw_confirm_check_msg" class="error-msg"></span>
      </div>
    </div>

    <div class="form-group">
      <span class="form-label">새 비밀번호</span>
      <span id="new_pw_confirm_check_msg" class="error-msg"></span>
      <div class="form-value"> <input type="password" id="new_password" placeholder="새 비밀번호"/> </div>
    </div>

    <div class="form-group">
      <span class="form-label">새 비밀번호 확인</span>
      <div class="form-value">
        <input type="password" id="new_password_chk" placeholder="새 비밀번호 확인"/>
        <span id="new_pw_confirm_check_msg" class="error-msg"></span>
      </div>
      <button class="mybtn mybtn-sm mybtn-primary" id="submitNewPasswordBtn">변경</button>
    </div>
  </div>

  <div class="form-group">
    <span class="form-label">휴대폰</span>
    <div class="form-value">
      <%-- 카카오 유저든 아니든 mvo.phone 사용 --%>
      <input type="tel" id="u_phone" name="u_phone" value="${sessionScope.mvo.phone}"
             <c:if test="${not empty sessionScope.mvo.phone}">disabled</c:if>
      />
      <button class="mybtn mybtn-sm" id="changePhoneBtn"
              <c:if test="${empty sessionScope.mvo.phone}">style="display: none;"</c:if>>
        휴대폰번호 변경</button>
    </div>
  </div>

  <div class="form-group" id="phone-change-form" style="display: none;">
    <span class="form-label">변경할 휴대폰 번호</span>
    <div class="form-value">
      <input type="tel" id="new_u_phone" placeholder="'-' 없이 입력">
      <button class="mybtn mybtn-sm mybtn-primary" id="submitNewPhoneBtn">확인</button> <%-- 버튼 텍스트를 "확인"으로 변경 --%>
    </div>
  </div>

  <%-- 생년월일 UI Datepicker 방식--%>
  <div class="form-group">
    <span class="form-label">생년월일</span>
    <div class="form-value">

      <input type="text" id="start_reg_date" value="${sessionScope.mvo.birth}"
             <c:if test="${not empty sessionScope.mvo.birth}">disabled</c:if>
      />

    </div>
  </div>

  <div class="form-group">
    <span class="form-label">이메일</span>
    <div class="form-value">
      <%-- kvo 유저의 경우에도 mvo 데이터를 사용하도록 수정 --%>
      <span>${sessionScope.mvo.email}</span>
    </div>
  </div>

  <div id="my_btn" class="form-group">
    <button class="mybtn mybtn-change">정보수정</button>
    <form id="withdrawForm" action="${pageContext.request.contextPath}/Controller?type=userout" method="post" style="display:none;">
    </form>
    <button class="mybtn mybtn-exit" id="withdrawBtn">회원탈퇴</button>
  </div>

</div>


<%-- jQuery 라이브러리 추가 --%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%-- jQuery UI 라이브러리 추가 --%>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<script>
  $(function() { // $(document).ready()의 축약형. 파일 전체에서 단 한 번만 사용한다.

    // ===================================================================
    // 1. 변수 선언 및 초기화 (Variable Declarations & Initialization)
    // ===================================================================

    // --- 전화번호 관련
    const $mainPhoneInput = $('#u_phone');
    const $changePhoneBtn = $('#changePhoneBtn');
    const $phoneChangeForm = $('#phone-change-form');
    const $newPhoneInput = $('#new_u_phone');
    const $submitNewPhoneBtn = $('#submitNewPhoneBtn');
    let initialPhoneValue = $mainPhoneInput.val().trim(); // 최초 전화번호 값 저장

    // --- 생년월일 관련
    const $birthdateInput = $('#start_reg_date');

    // --- 비밀번호 관련
    const $pwChangeForm = $('#pw-change-form');
    const $changePwBtn = $('#changePwBtn');
    const $currentPasswordInput = $('#current_password_input');
    const $newPasswordInput = $('#new_password');
    const $newPasswordChkInput = $('#new_password_chk');
    const $submitNewPasswordBtn = $('#submitNewPasswordBtn');

    // --- 기타 UI
    const $infoChangeBtn = $('#my_btn .mybtn-change');
    const $withdrawBtn = $('#withdrawBtn');

    // --- 상태 관리 변수
    let pwCheckTimer = null;
    let pwCheckXhr = null;

    // ===================================================================
    // 2. 초기 설정 (Initial Setup)
    // ===================================================================

    // --- jQuery UI Datepicker 초기화
    $birthdateInput.datepicker({
      dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
      monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
      showMonthAfterYear: true,
      yearSuffix: "년",
      dateFormat: "yy-mm-dd",
      changeMonth: true,
      changeYear: true,
      yearRange: 'c-100:c+0'
    });

    // --- 생년월일 필드가 비활성화 상태이면 datepicker도 비활성화
    if ($birthdateInput.prop('disabled')) {
      $birthdateInput.datepicker("option", "disabled", true);
    }

    // ===================================================================
    // 3. 헬퍼 함수 (Helper Functions)
    // ===================================================================

    /** 입력 필드 주변에 메시지(성공/에러)를 표시하는 함수 */
    function setMsg($input, text, color) {
      let $msgSpan = $input.closest('.form-value').find('span.error-msg').first();
      if ($msgSpan.length === 0) {
        $msgSpan = $input.next('span.error-msg');
      }
      if ($msgSpan.length === 0) {
        $msgSpan = $('<span class="error-msg" role="alert" aria-live="polite" style="display: block; margin-top: 6px;"></span>');
        $input.after($msgSpan);
      }
      $msgSpan.text(text || '').css('color', color || 'red');
    }

    /** 새 비밀번호와 비밀번호 확인 필드의 일치 여부를 검사하는 함수 */
    function checkNewPasswordMatch() {
      const pwCheckRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
      let newPw = $newPasswordInput.val();
      let newPwChk = $newPasswordChkInput.val();

      if (!newPwChk) {
        setMsg($newPasswordChkInput, '', '');
        return;
      }

      if (newPw !== newPwChk) {
        setMsg($newPasswordChkInput, '비밀번호가 일치하지 않습니다.', 'red');
      } else {
        if (pwCheckRegex.test(newPw)) {
          setMsg($newPasswordChkInput, '비밀번호가 일치합니다.', 'green');
        } else {
          setMsg($newPasswordChkInput, '', '');
        }
      }
    }

    // ===================================================================
    // 4. 이벤트 핸들러 바인딩 (Event Handler Binding)
    // ===================================================================

    // --- '비밀번호 변경' 폼 열기/닫기
    $changePwBtn.on('click', function() {
      $pwChangeForm.slideToggle(200, function() {
        if ($(this).is(':visible')) {
          $currentPasswordInput.focus();
        }
      });
    });

    // --- '현재 비밀번호' 실시간 확인 (디바운싱 적용)
    $currentPasswordInput.on('input', function() {
      let u_pw = $(this).val().trim();
      let $pwConfirmCheckMsg = $("#pw_confirm_check_msg");

      clearTimeout(pwCheckTimer);
      if (pwCheckXhr) pwCheckXhr.abort();

      if (u_pw.length < 2) {
        $pwConfirmCheckMsg.text('');
        return;
      }

      pwCheckTimer = setTimeout(function() {
        pwCheckXhr = $.ajax({
          url: "/Controller?type=PWcheck",
          type: "post",
          data: { u_pw: u_pw },
          dataType: 'json'
        }).done(function(response) {
          if (response && response.match) {
            $pwConfirmCheckMsg.text("비밀번호가 일치합니다.").css("color", "green");
          } else {
            $pwConfirmCheckMsg.text("현재 비밀번호가 틀립니다.").css("color", "red");
          }
        }).fail(function(jqXHR, status) {
          if (status !== 'abort') {
            $pwConfirmCheckMsg.text("비밀번호 확인 중 오류 발생.").css("color", "red");
          }
        }).always(function() {
          pwCheckXhr = null;
        });
      }, 400);
    });

    // --- '새 비밀번호' 유효성 검사 (실시간)
    $newPasswordInput.on('keyup', function() {
      const pwCheckRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
      let val = $(this).val();
      if (!val) {
        setMsg($(this), '', '');
      } else if (!pwCheckRegex.test(val)) {
        setMsg($(this), '비밀번호는 영문, 숫자, 특수문자 조합 8~16자여야 합니다.', 'red');
      } else {
        setMsg($(this), '유효한 비밀번호입니다.', 'green');
      }
      checkNewPasswordMatch();
    });

    // --- '새 비밀번호 확인' 일치 검사 (실시간)
    $newPasswordChkInput.on('keyup', checkNewPasswordMatch);

    // --- 새 비밀번호 '변경' 버튼 클릭
    $submitNewPasswordBtn.on('click', function(e) {
      e.preventDefault();
      const pwCheckRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
      let currentPassword = $currentPasswordInput.val().trim();
      let newPassword = $newPasswordInput.val().trim();
      let newPasswordChk = $newPasswordChkInput.val().trim();

      if (currentPassword === '') {
        setMsg($currentPasswordInput, '현재 비밀번호를 입력해주세요.', 'red');
        $currentPasswordInput.focus();
        return;
      }
      if (newPassword === '') {
        setMsg($newPasswordInput, '새 비밀번호를 입력해주세요.', 'red');
        $newPasswordInput.focus();
        return;
      }
      if (!pwCheckRegex.test(newPassword)) {
        setMsg($newPasswordInput, '새 비밀번호는 영문, 숫자, 특수문자 조합 8~16자여야 합니다.', 'red');
        $newPasswordInput.focus();
        return;
      }
      if (newPassword !== newPasswordChk) {
        setMsg($newPasswordChkInput, '새 비밀번호와 비밀번호 확인이 일치하지 않습니다.', 'red');
        $newPasswordChkInput.focus();
        return;
      }

      $.ajax({
        url: '/Controller?type=userinfo',
        type: 'POST',
        data: { action: 'stagePassword', password: newPassword },
        dataType: 'json'
      }).done(function(res) {
        if (res.success) {
          alert('비밀번호가 반영되었습니다. "정보수정" 버튼을 눌러 저장하세요.');
          window.__stagedPwFlag = true; // 최종 저장을 위한 플래그 설정
        } else {
          alert(res.message || '임시 저장 실패');
        }
      }).fail(function() {
        alert('서버 오류: 세션 저장 실패');
      });
    });

    // --- '휴대폰번호 변경' 폼 열기/닫기
    $changePhoneBtn.on('click', function() {
      $phoneChangeForm.slideToggle(200, function() {
        if ($(this).is(':visible')) {
          $newPhoneInput.focus();
        }
      });
    });

    // --- 새 휴대폰 번호 '확인' 버튼 클릭
    $submitNewPhoneBtn.on('click', function() {
      let newPhoneValue = $newPhoneInput.val().trim();
      if (newPhoneValue === '') {
        alert('변경할 휴대폰 번호를 입력해주세요.');
        return;
      }
      $mainPhoneInput.val(newPhoneValue);
      $newPhoneInput.val('');
      $phoneChangeForm.slideUp(200);
      alert('휴대폰 번호가 반영되었습니다. "정보수정" 버튼을 눌러 저장하세요.');
    });

    // --- 최종 '정보수정' 버튼 클릭
    $infoChangeBtn.on('click', function() {
      let updatePromises = [];
      let sessionBirthValue = '${sessionScope.mvo.birth}'.trim();
      let currentBirthValue = $birthdateInput.val().trim();
      let currentMainPhoneValue = $mainPhoneInput.val().trim();

      // 1. 생년월일 업데이트 로직
      if (!$birthdateInput.prop('disabled') && currentBirthValue !== sessionBirthValue) {
        let birthPromise = $.ajax({
          url: '/Controller?type=userinfo',
          type: 'POST',
          data: { action: 'updateBirthdate', birth: currentBirthValue },
          dataType: 'json'
        });
        updatePromises.push(birthPromise);
      }

      // 2. 휴대폰 번호 업데이트 로직
      if ((!$mainPhoneInput.prop('disabled') && currentMainPhoneValue !== '') || ($mainPhoneInput.prop('disabled') && currentMainPhoneValue !== initialPhoneValue)) {
        if (currentMainPhoneValue !== initialPhoneValue) {
          let phonePromise = $.ajax({
            url: '/Controller?type=userinfo',
            type: 'POST',
            data: { action: 'updatePhone', phone: currentMainPhoneValue },
            dataType: 'json'
          });
          updatePromises.push(phonePromise);
        }
      }

      // 3. 비밀번호 최종 커밋 로직
      if (window.__stagedPwFlag) {
        let commitPwPromise = $.ajax({
          url: '/Controller?type=userinfo',
          type: 'POST',
          data: { action: 'commitStagedPassword' },
          dataType: 'json'
        });
        updatePromises.push(commitPwPromise);
      }

      if (updatePromises.length === 0) {
        alert('수정할 정보가 없습니다.');
        return;
      }

      // 모든 AJAX 요청이 완료된 후 실행
      $.when.apply($, updatePromises).done(function() {
        alert('회원정보가 성공적으로 수정되었습니다.');
        location.reload();
      }).fail(function() {
        alert('정보 수정 중 일부 또는 전체 항목에 오류가 발생했습니다.');
      });
    });

    // --- '회원탈퇴' 버튼 클릭
    $withdrawBtn.on('click', function(e) {
      e.preventDefault();
      if (confirm('정말로 회원 탈퇴하시겠습니까? 탈퇴 시 복구가 불가능합니다.')) {
        if (window.parent && window.parent.$ && window.parent.$('#mainContent').length) {
          window.parent.$('#mainContent').load('${cp}/mypage/memberDelete.jsp');
        } else {
          $('#mainContent').load('${cp}/mypage/memberDelete.jsp');
        }
      }
    });

  });
</script>

</body>
</html>
