<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./css/sub/sub_page_style.css">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  <link rel="icon" href="./images/favicon.png">
</head>

<body>
<header>
  <jsp:include page="jsp/sub_menu.jsp"/>
</header>


<div id="contents" class="no-padding">
  <div class="theater-detail-page">
    <div class="img" style="border:1px solid red">
      <h1>백그라운드 이미지</h1>
    </div>
    <div class="inner-wrap">
      <!-- 탭 메뉴 -->
      <ul class="sub-tab-menu">
        <li><a href="javascript:void(0);" class="tab-link active" onclick="ex1()">극장정보</a></li>
        <li><a href="javascript:void(0);" class="tab-link" onclick="ex2()">상영시간표</a></li>
        <li><a href="javascript:void(0);" class="tab-link" onclick="ex3()">관람료</a></li>
      </ul>

      <div id="tab1" class="tab-content show"></div>
      <div id="tab2" class="tab-content"></div>
      <div id="tab3" class="tab-content"></div>
    </div>

  </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
  function ex1() {
    activateTab(0);
    $("#tab1").load("theater_info.jsp");
  }

  function ex2() {
    activateTab(1);
    $("#tab2").load("theater_timetable.jsp");
  }

  function ex3() {
    activateTab(2);
    $("#tab3").load("theater_price.jsp");
  }

  function activateTab(index) {
    $(".tab-link").removeClass("active");
    $(".tab-link").eq(index).addClass("active");

    $(".tab-content").removeClass("show");
    $("#tab" + (index + 1)).addClass("show");
  }

  $(document).ready(function () {
    ex1();
  });
</script>
  
  </body>
</html>
