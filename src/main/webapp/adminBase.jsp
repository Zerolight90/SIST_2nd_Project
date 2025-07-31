<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/admin.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body style="margin: auto">
    <!-- 관리자 화면에 처음 들어오는 보이는 상단영역 -->
  <div class="dashHead bold">
    <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">admin 관리자님</p></div>
    <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
      <a href="">SIST</a>
      <a href="">로그아웃</a>
    </div>
  </div>

  <div class="dashBody">
      <div class="dashLeft">
         <jsp:include page="/admin.jsp"/>
      </div>
      <div class="adminContent">
          <div>
              <strong>콘텐츠 영역</strong>
          </div>
      </div>
  </div>
</body>
</html>
