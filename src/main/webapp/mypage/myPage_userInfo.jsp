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
  <%-- jQuery 라이브러리 추가 --%>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <%-- jQuery UI 라이브러리 추가 --%>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

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

      <c:otherwise>
        <strong><span>${sessionScope.mvo.id}</span></strong>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="form-group">
    <span class="form-label">이름</span>
    <div class="form-value">
      <%-- kvo 유저의 경우에도 mvo 데이터를 사용하도록 수정 --%>
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

      <c:otherwise>
        <div class="form-value">
          <input type="password" id="pw_password" VALUE="${sessionScope.mvo.pw}" disabled/>
          <button class="mybtn mybtn-sm" id="changePwBtn">비밀번호 변경</button>

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

<script>
  $(document).ready(function() {
    // 1. 전화번호 입력 필드 관련 변수
    const $mainPhoneInput = $('#u_phone');
    const $changePhoneBtn = $('#changePhoneBtn');
    const $phoneChangeForm = $('#phone-change-form');
    const $newPhoneInput = $('#new_u_phone');
    const $submitNewPhoneBtn = $('#submitNewPhoneBtn'); // "확인" 버튼

    // 생년월일 필드 변수
    const $birthdateInput = $('#start_reg_date');

    // 비밀번호 변경 폼 변수 (새 비밀번호 입력 필드와 버튼)
    const $pwChangeForm = $('#pw-change-form');
    const $currentPasswordInput = $('#current_password_input'); // 현재 비밀번호 필드 추가
    const $newPasswordInput = $('#new_password');
    const $newPasswordChkInput = $('#new_password_chk'); // 새 비밀번호 확인 필드 추가
    const $submitNewPasswordBtn = $('#submitNewPasswordBtn'); // "변경" 버튼

    // 현재 세션에 저장된 전화번호 (최초 로드 시점의 값)
    // JSP에서 초기 disabled 속성을 설정했기 때문에, 이 값은 최초 상태를 확인하는 용도로만 사용됩니다.
    let initialPhoneValue = $mainPhoneInput.val().trim(); // let으로 변경하여 필요시 갱신 가능

    // 2. jQuery UI Datepicker 초기화 및 비활성화 로직
    $birthdateInput.datepicker({
      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
      monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
      showMonthAfterYear: true,
      yearSuffix: "년",
      dateFormat: "yy-mm-dd",
      changeMonth: true,
      changeYear: true,
      yearRange: 'c-100:c+0'
    });

    // 생년월일 필드가 초기 로드 시 disabled 상태이면 datepicker도 비활성화
    if ($birthdateInput.prop('disabled')) {
      $birthdateInput.datepicker("option", "disabled", true);
    }

    // 3. 비밀번호 변경 폼 토글
    $('#changePwBtn').on('click', function() {
      // is(':visible') 대신 jQuery의 콜백 함수를 사용하여 애니메이션 완료 후 포커스
      if ($pwChangeForm.is(':visible')) {
        $pwChangeForm.slideUp(200, function() { // 속도를 200ms로 조절
          // 폼이 사라진 후에는 아무것도 하지 않음
        });
      } else {
        $pwChangeForm.slideDown(200, function() { // 속도를 200ms로 조절
          $currentPasswordInput.focus(); // 폼이 나타난 후 포커스
        });
      }
    });

    $(document).ready(function() {
      const $changePwBtn = $('#changePwBtn');
      const $pwChangeForm = $('#pw-change-form');
      const $currentPasswordInput = $('#current_password_input');
      const $newPasswordInput = $('#new_password');
      const $newPasswordChkInput = $('#new_password_chk');
      const $submitNewPasswordBtn = $('#submitNewPasswordBtn');

      // 기존 바인딩 제거(중복 바인딩 방지)
      $changePwBtn.off('click');
      $newPasswordInput.off('keyup');
      $newPasswordChkInput.off('keyup');
      $submitNewPasswordBtn.off('click');

      // 입력 바로 아래에 span.error-msg가 있으면 사용, 없으면 생성/삽입
      function getOrCreateMsgSpan($input) {
        let $msg = $input.nextAll('span.error-msg').first();
        if ($msg && $msg.length) return $msg;

        $msg = $input.closest('.form-value').find('span.error-msg').first();
        if ($msg && $msg.length) {
          // input 바로 아래로 이동시키기
          $msg.insertAfter($input);
          return $msg;
        }

        // 없으면 생성
        const id = 'err-' + Math.random().toString(36).substr(2, 9);
        $msg = $('<span class="error-msg" role="alert" aria-live="polite"></span>');
        $msg.attr('id', id).css({ 'display': 'block', 'margin-top': '6px' });
        $msg.insertAfter($input);
        // input에 aria-describedby 연결
        $input.attr('aria-describedby', id);
        return $msg;
      }

      function setMsg($input, text, color) {
        const $span = getOrCreateMsgSpan($input);
        $span.text(text || '');
        if (text) $span.css('color', color || 'red');
        else $span.css('color', '').text('');
      }

      // 토글 버튼: 비밀번호 변경 폼 열기/닫기
      $changePwBtn.on('click', function() {
        if ($pwChangeForm.is(':visible')) {
          $pwChangeForm.slideUp(200);
        } else {
          $pwChangeForm.slideDown(200, function() {
            $currentPasswordInput.focus();
          });
        }
      });

      // 변수 선언 (스코프는 문서 준비 내부)
      let pwCheckTimer = null;
      let pwCheckXhr = null;
      const PW_DEBOUNCE_MS = 400;   // 디바운스 시간(밀리초)
      const PW_MIN_LEN = 2;         // 최소 체크 길이(필요에 따라 조정)

// input 이벤트 사용 (keyup 대신 input 권장)
      $('#current_password_input').on('input', function() {
        const $this = $(this);
        const u_pw = $this.val().trim();
        const $pwConfirmCheckMsg = $("#pw_confirm_check_msg");

        // 빈값이면 메시지 초기화 후 타이머/요청 취소
        if (u_pw.length === 0) {
          clearTimeout(pwCheckTimer);
          if (pwCheckXhr) { pwCheckXhr.abort(); pwCheckXhr = null; }
          $pwConfirmCheckMsg.text('').css('color', '');
          return;
        }

        // 너무 짧으면(예: 2자 미만) 바로 체크하지 않음
        if (u_pw.length < PW_MIN_LEN) {
          $pwConfirmCheckMsg.text('').css('color', '');
          return;
        }

        // 기존 타이머 초기화 후 새 타이머 설정(디바운스)
        clearTimeout(pwCheckTimer);
        pwCheckTimer = setTimeout(function() {
          // 이전에 실행 중인 AJAX가 있으면 취소
          if (pwCheckXhr) {
            try { pwCheckXhr.abort(); } catch (e) { /* ignore */ }
            pwCheckXhr = null;
          }

          // (선택) 로딩 표시
          // $pwConfirmCheckMsg.text('확인 중...').css('color', '#666');

          // 새로운 AJAX 요청 저장
          pwCheckXhr = $.ajax({
            url: "/Controller?type=PWcheck",
            type: "post",
            data: { u_pw: u_pw },
            dataType: 'json',
            timeout: 8000
          }).done(function(response) {
            if (response && response.match) {
              $pwConfirmCheckMsg.text("비밀번호가 일치합니다.").css("color", "green");
            } else {
              $pwConfirmCheckMsg.text("현재 비밀번호가 틀립니다.").css("color", "red");
            }
          }).fail(function(jqXHR, status, error) {
            // abort로 중단된 경우는 에러 메시지 표시는 하지 않음
            if (status === 'abort') return;
            console.error("AJAX Error (PWcheck):", status, error);
            $pwConfirmCheckMsg.text("비밀번호 확인 중 오류가 발생했습니다.").css("color", "red");
          }).always(function() {
            pwCheckXhr = null;
          });
        }, PW_DEBOUNCE_MS);
      });



      // 비밀번호 유효성: 영문자, 숫자, 특수문자 포함 8~16자
      const pwCheckRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;

      // 새 비밀번호 실시간 검사
      $newPasswordInput.on('keyup', function() {
        const val = $(this).val();
        $(this).removeClass('error');

        if (!val) {
          setMsg($(this), '', '');
          return;
        }

        if (!pwCheckRegex.test(val)) {
          $(this).addClass('error');
          setMsg($(this), '비밀번호는 영문, 숫자, 특수문자 조합 8~16자여야 합니다.', 'red');
        } else {
          setMsg($(this), '유효한 비밀번호입니다.', 'green');
        }

        checkNewPasswordMatch();
      });

      // 새 비밀번호 확인 실시간 검사
      $newPasswordChkInput.on('keyup', function() {
        checkNewPasswordMatch();
      });


      // 일치 검사 함수 (확인란 바로 아래에 메시지 표시)
      function checkNewPasswordMatch() {
        const newPw = $newPasswordInput.val();
        const newPwChk = $newPasswordChkInput.val();

        if (!newPwChk) {
          setMsg($newPasswordChkInput, '', '');
          return;
        }

        if (newPw !== newPwChk) {
          $newPasswordChkInput.addClass('error');
          setMsg($newPasswordChkInput, '비밀번호가 일치하지 않습니다.', 'red');
        } else {
          if (pwCheckRegex.test(newPw)) {
            setMsg($newPasswordChkInput, '비밀번호가 일치합니다.', 'green');
            $newPasswordChkInput.removeClass('error');
          } else {
            setMsg($newPasswordChkInput, '새 비밀번호 형식이 유효하지 않아 일치 여부를 확인할 수 없습니다.', 'red');
            $newPasswordChkInput.addClass('error');
          }
        }
      }

      // 변경 버튼 클릭 (클라이언트 검증 후 AJAX 전송)
      $submitNewPasswordBtn.on('click', function(e) {
        e.preventDefault();

        const currentPassword = $currentPasswordInput.val().trim();
        const newPassword = $newPasswordInput.val().trim();
        const newPasswordChk = $newPasswordChkInput.val().trim();

        // 클라이언트 검증 및 에러 메시지 표시
        if (currentPassword === '') {
          setMsg($currentPasswordInput, '현재 비밀번호를 입력해주세요.', 'red');
          $currentPasswordInput.focus();
          return;
        } else {
          setMsg($currentPasswordInput, '', '');
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
        function getOrCreateMsgSpan($input) {
          // 먼저 input 바로 다음 형제 요소 중에 .error-msg가 있는지 확인
          let $msg = $input.next('.error-msg');
          if ($msg.length) return $msg;

          // 없으면 input 바로 뒤에 block span 생성
          const id = 'err-' + Math.random().toString(36).substr(2, 9);
          $msg = $('<span class="error-msg" role="alert" aria-live="polite"></span>')
                  .attr('id', id)
                  .css({ display: 'block', 'margin-top': '6px' });
          $input.after($msg); // 입력 바로 뒤에 삽입 -> 항상 아래에 위치
          $input.attr('aria-describedby', id);
          return $msg;
        }


        // AJAX 호출
        $.ajax({

          url: '/Controller?type=userinfo',
          type: 'POST',
          data: { action: 'stagePassword', password: newPassword },
          dataType: 'json'
        }).done(function(res) {

          if (res.success) {
            alert('비밀번호가 반영되었습니다. "정보수정" 버튼을 눌러 저장하세요.');

            // flag를 세워 나중에 정보수정 시 커밋하도록 함
            window.__stagedPwFlag = true;
          } else {
            alert(res.message || '임시 저장 실패');
          }
        }).fail(function() {
          alert('서버 오류: 세션 저장 실패');
        });
      });



    // 4. 휴대폰 번호 변경 폼 토글
    $changePhoneBtn.on('click', function() {
      $phoneChangeForm.slideToggle(200, function() { // 속도를 200ms로 조절
        if ($phoneChangeForm.is(':visible')) {
          $newPhoneInput.focus(); // 폼이 나타난 후 포커스
        }
      });
    });

    // 5. '변경할 휴대폰 번호' 폼에서 '확인' 버튼 클릭 시 (필드에만 반영, DB 커밋 안 함)
    $submitNewPhoneBtn.on('click', function() {
      const newPhoneValue = $newPhoneInput.val().trim();

      if (newPhoneValue === '') {
        alert('변경할 휴대폰 번호를 입력해주세요.');
        return;
      }

      // 현재 메인 필드 값과 새로운 값이 다를 때만 업데이트
      if (newPhoneValue !== $mainPhoneInput.val().trim()) {
        $mainPhoneInput.val(newPhoneValue); // 메인 입력 필드 값 갱신
      }

      $newPhoneInput.val(''); // 변경 폼 입력 필드 초기화
      $phoneChangeForm.slideUp(200); // 변경 폼 숨기기

      alert('휴대폰 번호가 반영되었습니다. "정보수정" 버튼을 눌러 저장하세요.');
    });

    // 6. "정보수정" 버튼 클릭 시 (생년월일 및 휴대폰 번호 최종 DB 업데이트)
      $('#my_btn .mybtn-change').off('click').on('click', function() {
      let updatePromises = [];

      // 생년월일 업데이트 로직
      const currentBirthValue = $birthdateInput.val().trim();
      const sessionBirthValue = '${sessionScope.mvo.birth}'.trim();

      if (!$birthdateInput.prop('disabled') && currentBirthValue !== sessionBirthValue) {
        let birthPromise = $.ajax({
          url: '/Controller?type=userinfo',
          type: 'POST',
          data: {
            action: 'updateBirthdate',
            birth: currentBirthValue
          },
          dataType: 'json'
        }).done(function(response) {
          if (response.success) {
            $birthdateInput.prop('disabled', true);
            $birthdateInput.datepicker("option", "disabled", true);
          }
        }).fail(function(xhr, status, error) {
          console.error("AJAX Error (Birthdate):", status, error);
          alert('생년월일 업데이트 중 오류가 발생했습니다.');
        });
        updatePromises.push(birthPromise);
      }

      // 휴대폰 번호 업데이트 로직
      const currentMainPhoneValue = $mainPhoneInput.val().trim();

      if ((!$mainPhoneInput.prop('disabled') && currentMainPhoneValue !== '') ||
              ($mainPhoneInput.prop('disabled') && currentMainPhoneValue !== initialPhoneValue)) {

        if (currentMainPhoneValue !== initialPhoneValue) {
          let phonePromise = $.ajax({
            url: '/Controller?type=userinfo',
            type: 'POST',
            data: {
              action: 'updatePhone',
              phone: currentMainPhoneValue
            },
            dataType: 'json'
          }).done(function(response) {
            if (response.success) {
              $mainPhoneInput.prop('disabled', true);
              $changePhoneBtn.show();
              initialPhoneValue = currentMainPhoneValue;
            }
          }).fail(function(xhr, status, error) {
            console.error("AJAX Error (Phone Update):", status, error);
            alert('휴대폰 번호 업데이트 중 오류가 발생했습니다.');
          });
          updatePromises.push(phonePromise);
        }
      }

        if (window.__stagedPwFlag) {

          const commitPwPromise = $.ajax({

            url: '/Controller?type=userinfo',
            type: 'POST',
            data: { action: 'commitStagedPassword' },
            dataType: 'json'

          }).done(function(resp) {
            if (!resp.success) alert('비밀번호 DB 반영 실패: ' + resp.message);
            else {
              // 반영 성공이면 staged flag 제거
              window.__stagedPwFlag = false;
            }

          }).fail(function() {
            alert('비밀번호 DB 반영 중 서버 오류');
          });

          updatePromises.push(commitPwPromise);
        }

        if (updatePromises.length === 0) {
          alert('수정할 정보가 없습니다.');
          return;
        }

        $.when.apply($, updatePromises).done(function() {
          alert('회원정보 수정 완료');
          location.reload(); // 필요 시 세션의 변경값을 반영하기 위해 새로고침
        });
      });
    });

    $('#withdrawBtn').off('click').on('click', function(e){
      e.preventDefault();
      if (!confirm('정말로 회원 탈퇴하시겠습니까? 탈퇴 시 복구가 불가능합니다.')) return;
      // 부모 페이지(마이페이지)의 mainContent에 회원탈퇴 안내 페이지 로드
      if (window.parent && window.parent.$ && window.parent.$('#mainContent').length) {
        window.parent.$('#mainContent').load('${cp}/mypage/memberDeleteNotice.jsp');
      } else {
        // fallback: 현재 창에서 직접 로드
        $('#mainContent').load('${cp}/mypage/memberDeleteNotice.jsp');
      }
    });


  });
</script>

</body>
</html>
