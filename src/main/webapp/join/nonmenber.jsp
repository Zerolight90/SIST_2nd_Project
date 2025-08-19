<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <meta charset="UTF-8" />
    <title>비회원 예매 확인</title>
    <link rel="stylesheet" href="<c:url value="/css/nonmenber.css"/>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="icon" href="../images/favicon.png">
</head>

<body>

<div id="non_field">

    <img class="logo" src="../images/logo.png">

    <form id="nonForm" action="/Controller?type=nonmember" method="post">
        <div class="field">
            <label for="u_name">이름 <small>(*필수사항)</small></label>
            <input id="u_name" name="u_name" type="text" value="${param.u_name}" placeholder="이름을 입력하세요" />
        </div>

        <div class="field">
            <label for="u_birth">생일 <small>(*필수사항)</small></label>
            <input id="u_birth" name="u_birth" type="text" value="${param.u_birth}" placeholder="생년월일 6자리 (YYMMDD)" />
        </div>

        <div class="field">
            <label for="u_phone">전화번호 <small>(*필수사항)</small></label>
            <input id="u_phone" name="u_phone" type="text" value="${param.u_phone}" placeholder="'-' 없이 입력" />
        </div>

        <div class="field">
            <label for="u_email">E-mail <small>(*필수사항)</small></label>
            <input id="u_email" name="u_email" type="email" value="${param.u_email}" placeholder="이메일을 입력하세요" />
        </div>

        <div class="field">
            <label for="u_pw">비밀번호 <small>(*필수사항)</small></label>
            <input id="u_pw" name="u_pw" type="password" value="${param.u_pw}" placeholder="숫자 4자리" />
        </div>

        <button type="submit" class="btn-submit"><span>비회원 예매하기</span></button>
    </form>

</div>

<script>
    $(document).ready(function() {
        $('#nonForm').on('submit', function(e) {
            e.preventDefault(); // 기본 폼 제출 방지

            var formData = $(this).serialize(); // 폼 데이터 직렬화

            $.ajax({
                type: "POST",
                url: $(this).attr('action'), // 폼의 action 속성 사용
                data: formData,
                success: function(response) {
                    // 서버에서 비회원 정보가 성공적으로 세션에 저장되었다고 가정
                    // 부모 창 새로고침 또는 지정된 페이지로 리디렉션 ((16))
                    if (window.opener) { // 부모 창이 존재하는지 확인 ((23))
                        // 부모 창을 /Controller?type=index로 리디렉션
                        window.opener.location.href = '/Controller?type=index';
                    }
                    window.close(); // 현재 팝업 창 닫기 ((21))
                },
                error: function(xhr, status, error) {
                    // 오류 처리
                    alert('비회원 예매 중 오류가 발생했습니다. 다시 시도해주세요.');
                    console.error('AJAX Error:', status, error);
                }
            });
        });
    });
</script>

</body>
</html>
