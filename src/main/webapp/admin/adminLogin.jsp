<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body style="width: 350px; height: 210px">
  <div style="width: 350px; height: 210px; border-radius: 5px;">
    <div style="text-align: center; margin: 0 auto;">
      <h2>관리자 로그인</h2>
    </div>

    <form action="Controller?type=adminCheck" method="post" id="frm">
      <div style="margin-bottom: 10px; margin-left: 73px;">
        <input type="text" placeholder="아이디" name="id" value="" style="width: 200px; height: 39px;"/>
      </div>
      <div style="margin-bottom: 10px; margin-left: 73px;">
        <input type="password" placeholder="비밀번호" name="pw" value="" style="width: 200px; height: 39px;"/>
      </div>
    </form>

    <div style="margin-bottom: 10px; margin-left: 73px;">
      <button type="button" id="login" style="width: 200px; height: 39px; border: 1px solid #329eb1;
      background-color: #329eb1; border-radius: 5px">로그인</button>
    </div>
    <div style="text-align: center">
      <p>ⓢ 2025 SIST CINEMA. All rights reserved.</p>
    </div>
  </div>

<script>
  $("#login").click(function () {
    $("#frm").submit();
  })
</script>

</body>
</html>
