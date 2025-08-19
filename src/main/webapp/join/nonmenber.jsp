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


</body>
</html>