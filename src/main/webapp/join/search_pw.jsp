<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="<c:url value="/css/reset.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/join.css"/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link rel="icon" href="/images/favicon.png">
</head>

<body>

<div class="member">

    <form id="SearchForm" action="/Controller?type=searchIdPw" method="post">

        <div class="field">
            <b>아이디<small>(*필수사항)</small></b>
            <input type="text" id="u_id" name="u_id" value="${param.u_id}">
        </div>

        <div class="field">
            <b>이름<small>(*필수사항) <span id="name_check_msg" class="error-msg"></span></small></b>
            <span class="placehold-text"> <input type="text" id="u_name" name="u_name" value="${param.u_name}"></span>
        </div>

        <div class="field birth">
            <b>생년월일<small>(*필수사항)</small></b>
            <div>
                <input class="year" type="number" name="u_year" placeholder="년(4자)">
                <select class="month" name="u_month">
                    <option value="">월</option>
                    <option value="01">1월</option>
                    <option value="02">2월</option>
                    <option value="03">3월</option>
                    <option value="04">4월</option>
                    <option value="05">5월</option>
                    <option value="06">6월</option>
                    <option value="07">7월</option>
                    <option value="08">8월</option>
                    <option value="09">9월</option>
                    <option value="10">10월</option>
                    <option value="11">11월</option>
                    <option value="12">12월</option>
                </select>
                <input class="day" type="number"  name="u_day" placeholder="일">
            </div>
        </div>

        <div class="field auth-field">
            <b>본인 확인 이메일*<small>(*필수사항)</small></b>
            <input type="email" id="email" name="u_email" placeholder="필수입력" value="${param.u_email}">
            <input class="c_btn" type="button" value="인증번호 받기" style="cursor: pointer">

            <input class="c_num" id="email_auth_key" name="email_auth_key" type="text"
                   placeholder="인증번호를 입력하세요" value="${param.email_auth_key}" style="display:none">

            <span id="email_auth_msg" class="error-msg" style="color: red;"></span>

            <!-- 이메일 인증 완료 플래그 -->
            <input type="hidden" id="email_auth_verified" name="email_auth_verified" value="false">
        </div>

        <div class="field tel-number">
            <select name="u_phone_country">
                <option value="+82">대한민국 +82</option>
            </select>
            <input type="tel" name="u_phone" placeholder="전화번호 입력" value="${param.u_phone}"/>
        </div>

        <!-- 버튼 타입을 submit -> button 으로 변경 -->
        <input id="searchID_btn" type="button" value="새 비빌번호 생성" style="cursor: pointer"/>
    </form>

    <div id="pw_modal" aria-hidden="true" role="dialog" style="display:none;">

        <form id="C_pw" action="/Controller?type=searchPW" method="post">

            <div class="field">
                <span class="form-label">새 비밀번호</span>
                <div class="form-value">
                    <input type="password" id="new_password" name="new_password" placeholder="새 비밀번호"/>
                    <span id="new_pw_msg" class="error-msg" aria-live="polite"></span>
                </div>
            </div>

            <div class="field">
                <span class="form-label">새 비밀번호 확인</span>
                <div class="form-value">
                    <input type="password" id="new_password_chk" name="new_password_chk" placeholder="새 비밀번호 확인"/>
                    <span id="new_pw_chk_msg" class="error-msg" aria-live="polite"></span>
                </div>
                <input id="searchPW_btn" type="button" value="패스워드 변경" style="cursor: pointer"/>
            </div>

        </form>

    </div>

</div>

<script>
    $(function(){

        // 모달 및 오버레이 스타일 및 기능
        var $modal = $('#pw_modal');
        var $overlay = $('#modal_overlay');
        if(!$overlay.length){
            $overlay = $('<div id="modal_overlay"></div>').css({
                position: 'fixed', top:0, left:0, right:0, bottom:0,
                backgroundColor: 'rgba(0,0,0,0.5)', zIndex: 10000, display: 'none'
            }).appendTo('body');
        }

        $modal.css({
            position: 'fixed', top: '50%', left: '50%',
            transform: 'translate(-50%, -50%)',
            backgroundColor: '#fff', padding: '20px',
            borderRadius: '6px', boxShadow: '0 6px 24px rgba(0,0,0,0.3)',
            width: '90%', maxWidth: '480px', zIndex: 10001, display: 'none'
        });

        if($modal.find('.modal-close-btn').length === 0){
            $('<button type="button" class="modal-close-btn" aria-label="닫기">취소</button>')
                .css({position:'absolute', top:'8px', right:'8px', background:'transparent', border:'none', fontSize:'16px', cursor:'pointer'})
                .prependTo($modal);
        }

        function openModal(){
            $overlay.fadeIn(150);
            $modal.fadeIn(150);
            $('body').css('overflow','hidden');
            $modal.attr('aria-hidden','false');
            setTimeout(function(){
                $('#new_password').focus();
            }, 200);
        }

        function closeModal(){
            $modal.fadeOut(120);
            $overlay.fadeOut(120);
            $('body').css('overflow','');
            $modal.attr('aria-hidden','true');
        }

        $overlay.on('click', closeModal);
        $modal.on('click', '.modal-close-btn', closeModal);
        $(document).on('keydown', function(e){
            if(e.key === 'Escape' && $modal.is(':visible')) closeModal();
        });

        // 이메일 인증 관련
        $(".c_btn").click(function() {
            let email = $("#email").val().trim();
            $("#email_auth_msg").text("").css("color", "red");

            if(email === "") {
                alert("이메일을 입력해 주세요.");
                $("#email").focus();
                return;
            }

            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                $("#email_auth_msg").text("유효한 이메일 주소를 입력해주세요.").css("color", "red");
                $("#email").addClass("error");
                return;
            } else {
                $("#email").removeClass("error");
            }

            alert("인증번호가 발송되었습니다.");

            $.ajax({
                url:  "/Controller?type=emailAuth",
                type: "POST",
                data: { email: email },
                dataType: "json"
            }).done(function(response) {
                if(response.success) {
                    $("#email_auth_msg").text("인증번호가 발송되었습니다. 메일을 확인하세요.").css("color", "green");
                    $("#email_auth_key").show();
                    $("#email_auth_msg").show();
                    $("#email_auth_key").focus();
                } else {
                    $("#email_auth_msg").text(response.message).css("color", "red");
                    $("#email_auth_key").show();
                    $("#email_auth_msg").show();
                }
            }).fail(function() {
                $("#email_auth_msg").text("인증번호 전송 중 오류가 발생했습니다.").css("color", "red");
                $("#email_auth_key").show();
                $("#email_auth_msg").show();
            });
        });

        $("#email_auth_key").on("keyup blur", function () {
            let authCode = $(this).val().trim();
            if (authCode.length === 0) {
                $("#email_auth_msg").text("");
                $("#email_auth_key").removeClass("error success");
                $("#email_auth_verified").val("false");
                return;
            }

            $.ajax({
                url:"/Controller?type=emailAuthVerify",
                type: "POST",
                data: { authCode: authCode},
                dataType: "json"
            }).done(function (response) {
                if (response.match) {
                    $("#email_auth_msg").text("인증번호가 일치합니다.").css("color", "green");
                    $("#email_auth_key").removeClass("error").addClass("success");
                    $("#email_auth_verified").val("true");
                } else {
                    $("#email_auth_msg").text(response.message).css("color", "red");
                    $("#email_auth_key").removeClass("success").addClass("error");
                    $("#email_auth_verified").val("false");
                }
            });
        });

        // 필수 입력값 검증 함수
        function validateBasicInfoFields() {
            if(!$("#u_id").val().trim()) { alert("아이디를 입력해주세요."); $("#u_id").focus(); return false; }
            if(!$("#u_name").val().trim()) { alert("이름을 입력해주세요."); $("#u_name").focus(); return false; }
            if(!$(".year").val().trim() || !$(".month").val() || !$(".day").val().trim()) {
                alert("생년월일을 모두 입력해주세요.");
                if(!$(".year").val().trim()) $(".year").focus();
                else if(!$(".month").val()) $(".month").focus();
                else $(".day").focus();
                return false;
            }
            let email = $("#email").val().trim();
            if(!email) { alert("이메일을 입력해주세요."); $("#email").focus(); return false; }
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if(!emailRegex.test(email)) { alert("유효한 이메일을 입력해주세요."); $("#email").focus(); return false; }
            if(!$("input[name='u_phone']").val().trim()) { alert("전화번호를 입력해주세요."); $("input[name='u_phone']").focus(); return false; }
            return true;
        }

        // 이메일 인증 완료 여부 확인
        function isEmailAuthCompleted() {
            return $("#email_auth_verified").val() === "true";
        }

        // 비밀번호 유효성 정규식
        const pwCheckRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;

        // 메시지 출력 함수
        function setMsg($input, text, color) {
            let $msg = $input.next('.error-msg');
            if(!$msg.length) {
                $msg = $('<span class="error-msg" role="alert" aria-live="polite"></span>').css({'display':'block', 'margin-top':'6px'});
                $input.after($msg);
            }
            $msg.text(text || '');
            $msg.css('color', color || '');
        }

        // 새 비밀번호 실시간 검사
        $('#new_password').on('keyup', function(){
            let val = $(this).val();
            $(this).removeClass('error');
            if(!val) {
                setMsg($(this), '', '');
                return;
            }
            if(!pwCheckRegex.test(val)) {
                $(this).addClass('error');
                setMsg($(this), '비밀번호는 영문, 숫자, 특수문자 조합 8~16자여야 합니다.', 'red');
            } else {
                setMsg($(this), '유효한 비밀번호입니다.', 'green');
            }
            checkNewPasswordMatch();
        });

        // 새 비밀번호 확인 실시간 검사
        $('#new_password_chk').on('keyup', function(){
            checkNewPasswordMatch();
        });

        function checkNewPasswordMatch() {
            let newPw = $('#new_password').val();
            let newPwChk = $('#new_password_chk').val();
            if(!newPwChk) {
                setMsg($('#new_password_chk'), '', '');
                $('#new_password_chk').removeClass('error');
                return;
            }
            if(newPw !== newPwChk) {
                $('#new_password_chk').addClass('error');
                setMsg($('#new_password_chk'), '비밀번호가 일치하지 않습니다.', 'red');
            } else {
                if(pwCheckRegex.test(newPw)) {
                    setMsg($('#new_password_chk'), '비밀번호가 일치합니다.', 'green');
                    $('#new_password_chk').removeClass('error');
                } else {
                    $('#new_password_chk').addClass('error');
                    setMsg($('#new_password_chk'), '새 비밀번호 형식이 유효하지 않아 일치 여부를 확인할 수 없습니다.', 'red');
                }
            }
        }

        // "새 비밀번호 생성" 버튼 클릭 시 필수 입력 및 이메일 인증 확인 후 모달 오픈
        $('#searchID_btn').on('click', function(e){
            e.preventDefault();
            if(!validateBasicInfoFields()) return;
            if(!isEmailAuthCompleted()) {
                alert("이메일 인증을 완료해주세요.");
                $("#email").focus();
                return;
            }
            openModal();
        });

        // "패스워드 변경" 버튼 클릭 시 유효성 검사 후 AJAX 전송
        $('#searchPW_btn').on('click', function(e){
            e.preventDefault();
            let newPassword = $('#new_password').val().trim();
            let newPasswordChk = $('#new_password_chk').val().trim();

            if(newPassword === '') {
                setMsg($('#new_password'), '새 비밀번호를 입력해주세요.', 'red');
                $('#new_password').focus();
                return;
            }
            if(!pwCheckRegex.test(newPassword)) {
                setMsg($('#new_password'), '새 비밀번호는 영문, 숫자, 특수문자 조합 8~16자여야 합니다.', 'red');
                $('#new_password').focus();
                return;
            }
            if(newPassword !== newPasswordChk) {
                setMsg($('#new_password_chk'), '새 비밀번호와 비밀번호 확인이 일치하지 않습니다.', 'red');
                $('#new_password_chk').focus();
                return;
            }

            $.ajax({
                url: '/Controller?type=pwchange',
                type: 'POST',
                data: {
                    u_id: $('#u_id').val(),
                    newPassword: $('#new_password').val()},
                dataType: 'json'
            }).done(function(res){
                if(res.success) {
                    alert('비밀번호가 반영되었습니다');
                    closeModal();
                    window.location.href = "/Controller?type=login";  // 로그인 페이지로 이동
                } else {
                    alert(res.message || '저장 실패');
                }
            });
        });

    });
</script>

</body>
</html>
