<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <title>비회원 예매 확인</title>
    <link rel="stylesheet" href="<c:url value="/css/nonmenber.css"/>" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        .error { color: #c00; font-size: 0.95em; margin-top:4px; display:block; }
        .error.active { display:block; }
    </style>
</head>
<body>
<div id="non_field">
    <img class="logo" src="../images/logo.png" alt="logo">

    <form id="nonForm" action="${pageContext.request.contextPath}/Controller?type=nmember_chk" method="post" novalidate>
        <div class="field">
            <label for="u_name">이름 <small>(*필수사항)</small></label>
            <input id="u_name" name="u_name" type="text" value="${param.u_name}" placeholder="이름을 입력하세요" required />
            <span class="error" aria-live="polite"></span>
        </div>

        <div class="field">
            <label for="u_birth">생일 <small>(*필수사항)</small></label>
            <input id="u_birth" name="u_birth" type="text" value="${param.u_birth}" placeholder="생년월일 6자리 (YYMMDD)" required pattern="\d{6}" />
            <span class="error" aria-live="polite"></span>
        </div>

        <div class="field">
            <label for="u_pw">비밀번호 <small>(*필수사항)</small></label>
            <input id="u_pw" name="u_pw" type="password" value="${param.u_pw}" placeholder="숫자 4자리" required pattern="\d{4}" />
            <span class="error" aria-live="polite"></span>
        </div>

        <button type="submit" class="btn-submit"><span>예매확인</span></button>
    </form>
</div>

<script>
    $(function(){
        function clearErrors(){
            $('.error').text('').removeClass('active');
        }

        function showError($input, msg){
            $input.closest('.field').find('.error').text(msg).addClass('active');
        }

        $('#u_name, #u_birth, #u_pw').on('input', function(){
            $(this).closest('.field').find('.error').text('').removeClass('active');
        });

        $('#nonForm').on('submit', function(e){
            e.preventDefault();
            clearErrors();

            var $form = $(this);
            var name = $('#u_name').val().trim();
            var birth = $('#u_birth').val().trim();
            var pw = $('#u_pw').val().trim();

            var firstInvalid = null;

            if(name.length === 0){
                showError($('#u_name'), '이름을 입력해주세요.');
                if(!firstInvalid) firstInvalid = $('#u_name');
            }

            if(birth.length === 0){
                showError($('#u_birth'), '생년월일 6자리를 입력해주세요 (YYMMDD).');
                if(!firstInvalid) firstInvalid = $('#u_birth');
            } else if(!/^\d{6}$/.test(birth)){
                showError($('#u_birth'), '생년월일은 숫자 6자리(YYMMDD)여야 합니다.');
                if(!firstInvalid) firstInvalid = $('#u_birth');
            }

            if(pw.length === 0){
                showError($('#u_pw'), '비밀번호를 입력해주세요 (숫자 4자리).');
                if(!firstInvalid) firstInvalid = $('#u_pw');
            } else if(!/^\d{4}$/.test(pw)){
                showError($('#u_pw'), '비밀번호는 숫자 4자리여야 합니다.');
                if(!firstInvalid) firstInvalid = $('#u_pw');
            }

            if(firstInvalid){
                firstInvalid.focus();
                return;
            }


            $.ajax({
                type: "POST",
                url: $form.attr('action'),
                data: $form.serialize(),
                dataType: "json",
                success: function(response){

                    if(response && response.success){
                        if(window.opener){
                            window.opener.location.href = response.redirect;
                        }
                        window.close();
                    } else if(response && !response.success){

                        if(response.field && response.field === 'global'){
                            alert(response.message);
                        } else if(response.field){

                            showError($('#' + response.field), response.message);
                            $('#' + response.field).focus();
                        } else {
                            alert(response.message || '예매 내역이 없습니다.');
                        }
                    } else {
                        alert('서버 응답을 처리할 수 없습니다. 다시 시도해주세요.');
                    }
                },
                error: function(xhr){

                    try {
                        var json = JSON.parse(xhr.responseText);
                        alert(json.message || '서버 전송 중 오류가 발생했습니다. 다시 시도해주세요.');
                    } catch(e){
                        alert('서버 전송 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                    console.error('AJAX Error:', xhr.status, xhr.responseText);
                }
            });
        });
    });
</script>
</body>
</html>
