<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./CSS/style.css">
  <link rel="stylesheet" href="./CSS/reset.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <link rel="icon" href="./images/favicon.png">
</head>

<body>

<header>
  <jsp:include page="JSP/menu.jsp"/>
</header>

<article>

  <div class="storeTop">
    <div class="storeTopBox">
      <div class="location">
        <span>Home</span>
        &nbsp;>&nbsp;
        <a href="Controller?type=store">스토어</a>
      </div>
    </div>
  </div>

  <div id="contents">
    <div class="storeTopBox">
      <h2 style="padding: 10px">스토어</h2>
    </div>
  </div>

  <div class="tabmenu">
    <div class="storeTopBox">
      <ul>
        <li id="t1"><a href="javascript:ex1()">위드유</a></li>
        <li id="t2"><a href="javascript:ex2()">위드유 영상</a></li>
        <li id="t3"><a href="javascript:ex3()">위드유 대화</a></li>
        <li id="t4"><a href="javascript:ex4()">위드유 대결</a></li>
      </ul>
    </div>
  </div>

  <!-- 각 탭에 표현할 내용들 -->
  <div id="tab1" class="tab_cont show">
    위드유 내용입니다.
  </div>
  <div id="tab2" class="tab_cont">
    히
  </div>
  <div id="tab3" class="tab_cont">
    세 번째 Tab 내용입니다.
  </div>
  <div id="tab4" class="tab_cont">
    4 번째 Tab 내용입니다.
  </div>

</article>

<footer>
  <jsp:include page="JSP/Footer.jsp"/>
</footer>

<script>
  function ex1(){
    // 첫 번째 탭을 클릭했을 때 수행하는 곳
    // 현재 문서에서 아이디가 t1인 요소를 검색한다.
    var t1 = document.getElementById("t1")
    var t2 = document.getElementById("t2")
    var t3 = document.getElementById("t3")
    var t4 = document.getElementById("t4")

    t1.className = "selected"; // <li class = "selected"......
    t2.className = ""; // 기존에 지정된 class를 삭제
    t3.className = "";
    t4.className = "";
    // 탭 처리 ----------------------------------
    // 해당 탭에 표현한 내용처리를 지금부터 하자!
    // 먼저 tab1, tab2, tab3 이라는 아이디를 가진 요소들 모두 검색하자!
    var tab1 = document.getElementById("tab1")
    var tab2 = document.getElementById("tab2")
    var tab3 = document.getElementById("tab3")
    var tab4 = document.getElementById("tab4")
    tab1.className = "tab_cont show"
    tab2.className = "tab_cont"
    tab3.className = "tab_cont"
    tab4.className = "tab_cont"
  }

  function ex2(){
    // 첫 번째 탭을 클릭했을 때 수행하는 곳
    // 현재 문서에서 아이디가 t1인 요소를 검색한다.
    var t1 = document.getElementById("t1")
    var t2 = document.getElementById("t2")
    var t3 = document.getElementById("t3")
    var t4 = document.getElementById("t4")

    t2.className = "selected"; // <li class = "selected"......
    t1.className = ""; // 기존에 지정된 class를 삭제
    t3.className = "";
    t4.className = "";
    // 탭 처리 ----------------------------------
    // 해당 탭에 표현한 내용처리를 지금부터 하자!
    // 먼저 tab1, tab2, tab3 이라는 아이디를 가진 요소들 모두 검색하자!
    var tab1 = document.getElementById("tab1")
    var tab2 = document.getElementById("tab2")
    var tab3 = document.getElementById("tab3")
    var tab4 = document.getElementById("tab4")
    tab2.className = "tab_cont show"
    tab1.className = "tab_cont"
    tab3.className = "tab_cont"
    tab4.className = "tab_cont"
  }

  function ex3() {
    // 첫 번째 탭을 클릭했을 때 수행하는 곳
    // 현재 문서에서 아이디가 t1인 요소를 검색한다.
    var t1 = document.getElementById("t1")
    var t2 = document.getElementById("t2")
    var t3 = document.getElementById("t3")
    var t4 = document.getElementById("t4")

    t3.className = "selected"; // <li class = "selected"......
    t1.className = ""; // 기존에 지정된 class를 삭제
    t2.className = "";
    t4.className = "";
    // 탭 처리 ----------------------------------
    // 해당 탭에 표현한 내용처리를 지금부터 하자!
    // 먼저 tab1, tab2, tab3 이라는 아이디를 가진 요소들 모두 검색하자!
    var tab1 = document.getElementById("tab1")
    var tab2 = document.getElementById("tab2")
    var tab3 = document.getElementById("tab3")
    var tab4 = document.getElementById("tab4")
    tab3.className = "tab_cont show"
    tab2.className = "tab_cont"
    tab1.className = "tab_cont"
    tab4.className = "tab_cont"
  }

  function ex4() {
    // 첫 번째 탭을 클릭했을 때 수행하는 곳
    // 현재 문서에서 아이디가 t1인 요소를 검색한다.
    var t1 = document.getElementById("t1")
    var t2 = document.getElementById("t2")
    var t3 = document.getElementById("t3")
    var t4 = document.getElementById("t4")

    t3.className = ""; // <li class = "selected"......
    t1.className = ""; // 기존에 지정된 class를 삭제
    t2.className = "";
    t4.className = "selected";
    // 탭 처리 ----------------------------------
    // 해당 탭에 표현한 내용처리를 지금부터 하자!
    // 먼저 tab1, tab2, tab3 이라는 아이디를 가진 요소들 모두 검색하자!
    var tab1 = document.getElementById("tab1")
    var tab2 = document.getElementById("tab2")
    var tab3 = document.getElementById("tab3")
    var tab4 = document.getElementById("tab4")
    tab3.className = "tab_cont"
    tab2.className = "tab_cont"
    tab1.className = "tab_cont"
    tab4.className = "tab_cont show"
  }
</script>

</body>
</html>