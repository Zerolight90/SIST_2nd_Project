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
  <style>
    /* mypage.css에 추가하거나 이곳에 직접 추가하여 스타일을 조정합니다. */
    /* .form-group 내부 .form-value에 버튼이 같이 있을 때 정렬을 위한 스타일 */
    .form-group .form-value input[type="password"] {
      flex-grow: 1; /* 입력 필드가 가능한 공간을 채우도록 */
      margin-right: 10px; /* 버튼과의 간격 */
    }
    .form-group .form-value {
      display: flex; /* 내부 요소들을 가로로 정렬 */
      align-items: center; /* 세로 중앙 정렬 */
    }
  </style>
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
      <div class="form-value"> <input type="password" id="current_password_input" placeholder="현재 비밀번호를 입력하세요."/> </div>
    </div>

    <div class="form-group">
      <span class="form-label">새 비밀번호</span>
      <div class="form-value"> <input type="password" id="new_password" placeholder="새 비밀번호"/> </div>
    </div>

    <div class="form-group">
      <span class="form-label">새 비밀번호 확인</span>
      <div class="form-value">
        <input type="password" id="new_password_chk" placeholder="새 비밀번호 확인"/>
        <button class="mybtn mybtn-sm mybtn-primary" id="submitNewPasswordBtn">변경</button>
      </div>
    </div>
  </div>

  <div class="form-group">
    <span class="form-label">휴대폰</span>
    <div class="form-value">
      <%-- 카카오 유저든 아니든 mvo.phone 사용 --%>
      <input type="tel" id="u_phone" name="u_phone" value="${sessionScope.mvo.phone}"
             <c:if test="${not empty sessionScope.mvo.phone}">disabled</c:if>
      />
      <button class="mybtn mybtn-sm" id="changePhoneBtn" <c:if test="${empty sessionScope.mvo.phone}">style="display: none;"</c:if>>휴대폰번호 변경</button>
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

    // '새 비밀번호' 폼의 '변경' 버튼 클릭 시 (DB에 즉시 커밋)
    $submitNewPasswordBtn.on('click', function() {
      const currentPassword = $currentPasswordInput.val().trim(); // 현재 비밀번호 값
      const newPassword = $newPasswordInput.val().trim(); // 새 비밀번호 값
      const newPasswordChk = $newPasswordChkInput.val().trim(); // 새 비밀번호 확인 값

      if (currentPassword === '') {
        alert('현재 비밀번호를 입력해주세요.');
        $currentPasswordInput.focus();
        return;
      }
      if (newPassword === '') {
        alert('새 비밀번호를 입력해주세요.');
        $newPasswordInput.focus();
        return;
      }
      if (newPassword.length < 6) { // 최소 비밀번호 길이 설정 (예시)
        alert('새 비밀번호는 6자 이상이어야 합니다.');
        $newPasswordInput.focus();
        return;
      }
      if (newPassword !== newPasswordChk) {
        alert('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.');
        $newPasswordChkInput.focus();
        return;
      }

      // 실제 비밀번호 업데이트 로직 (AJAX 호출)
      $.ajax({
        url: '/Controller?type=userinfo', // 적절한 컨트롤러 URL
        type: 'POST',
        data: {
          action: 'updatePassword',
          currentPassword: currentPassword, // 현재 비밀번호 추가
          newPassword: newPassword // 새 비밀번호로 파라미터명 변경
        },
        dataType: 'json',
        success: function(response) {
          if (response.success) {
            alert("비밀번호 변경 완료");
            $currentPasswordInput.val(''); // 입력 필드 초기화
            $newPasswordInput.val('');
            $newPasswordChkInput.val('');
            $pwChangeForm.slideUp(200); // 폼 숨기기
          } else {
            alert(response.message || '비밀번호 업데이트 중 오류가 발생했습니다.'); // 서버에서 보낸 메시지 활용
          }
        },
        error: function(xhr, status, error) {
          console.error("AJAX Error (Password Update):", status, error);
          alert('비밀번호 업데이트 중 오류가 발생했습니다.');
        }
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
    $('#my_btn .mybtn-change').on('click', function() {
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

      if (updatePromises.length === 0) {
        alert('수정할 정보가 없습니다.');
        return;
      }

      $.when.apply($, updatePromises).done(function() {
        alert("회원정보 수정 완료");
      });
    });

    // 7. 회원 탈퇴 버튼 클릭 시 경고 메시지
    $('#withdrawBtn').on('click', function() {
      if (confirm('정말로 회원 탈퇴하시겠습니까? 탈퇴하시면 모든 정보가 삭제되며 되돌릴 수 없습니다.')) {
        $('#withdrawForm').submit();
      }
    });

  });
</script>

</body>
</html>
