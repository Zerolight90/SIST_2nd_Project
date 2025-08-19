<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>오류 발생</title>
</head>
<body>
<h2>오류가 발생했습니다.</h2>
<p>
  요청 처리 중 문제가 발생했습니다. <br>
  로그인 정보가 없거나 세션이 만료되었을 수 있습니다.
</p>
<p>
  <a href="Controller?type=index">메인 페이지로 돌아가기</a>
</p>
<p>에러 메시지: ${errorMessage}</p>
</body>
</html>