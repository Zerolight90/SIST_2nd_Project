<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>이용약관</title>
  <link rel="stylesheet" href="<c:url value='/css/reset.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/join.css'/>">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="icon" href="/images/favicon.png">
</head>
<body>
<div class="member">
  <h2 style="text-align:center; margin:30px 0;">이용약관</h2>

  <!-- 약관 내용 -->
  <textarea class="terms-text" readonly>
제1조 (목적)
본 약관은 회사가 제공하는 서비스의 이용조건 및 절차, 이용자와 회사의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.

제2조 (정의)
1. "회사"라 함은 서비스를 제공하는 주체를 말합니다.
2. "회원"이라 함은 본 약관에 동의하고 회원가입을 완료한 자를 말합니다.
3. "서비스"라 함은 회사가 제공하는 모든 온라인 서비스를 의미합니다.

제3조 (약관의 효력 및 변경)
...

부칙
본 약관은 2025년 1월 1일부터 시행합니다.
    </textarea>

  <form method="post" action="Controller?type=termsAgree" class="terms-form">
    <label><input type="checkbox" name="chk1" required> 이용약관 동의 (필수)</label>
    <label><input type="checkbox" name="chk2" required> 개인정보 처리방침 동의 (필수)</label>
    <button type="submit">동의하고 회원가입</button>
  </form>

</div>
</body>
</html>
