<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./css/sub/sub_page_style.css">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/theater.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  <link rel="icon" href="./images/favicon.png">
</head>

<body>
<%--<header>
  <div class="menu1">
    <div class="inner">
      <!-- 로고 -->
      <h1 class="logo">
        <a href="#" class="logo_link">
          <img src="./images/logo.png" alt="sist" class="logo_img" />
        </a>
        <span class="title">S I S T M O V I E P L E X</span>
      </h1>
    </div>
  </div>


  <div class="nav-top">
    <ul class="nav-l_top">
      <li><a href="#" class="vip-lounge">VIP LOUNGE</a></li>
      <li><a href="#" class="membership">멤버십</a></li>
      <li><a href="#" class="customer-center">고객센터</a></li>
      <li><a href="#" class="admin_page">관리자</a></li> <!--로그인 할때만 표현됨-->
    </ul>

    <ul class="nav-r_top">
      <li><a href="#" class="login">로그인</a></li>
      <li><a href="#" class="signup">회원가입</a></li>
      <li><a href="#" class="quick-booking">빠른예매</a></li>
    </ul>
  </div>


  <div class="icon-menu">
    <ul class="nav-side">
      <li>
        <button class="menu-toggle" aria-label="메뉴 열기">
          <span></span><span></span><span></span>
        </button>
      </li>

      <li>
        <a href="#" class="search-icon" aria-label="검색">
          <i class="fas fa-search"></i>
        </a>
      </li>
    </ul>

    <ul class="nav-icon">
      <li><a href="#" class="calendar-icon" aria-label="상영시간표"><i class="fa-regular fa-calendar"></i></a></li>
      <li><a href="#" class="user-icon" aria-label="나의 SIST"><i class="fa-regular fa-user"></i></a></li>
    </ul>
  </div>

  <div class="nav-center">
    <ul class="l_main">
      <li class="main-item has-submenu">
        <a href="#">영화</a>
        <ul class="submenu">
          <li><a href="#">전체 영화</a></li>
        </ul>
      </li>
      <li class="main-item has-submenu">
        <a href="#">예매</a>
        <ul class="submenu">
          <li><a href="#">빠른예매</a></li>
          <li><a href="#">상영시간표</a></li>
          <li><a href="#">더 부티크 프라이빗 예매</a></li>
        </ul>
      </li>
      <li class="main-item has-submenu">
        <a href="#">극장</a>
        <ul class="submenu">
          <li><a href="#">전체 극장</a></li>
          <li><a href="#">특별관</a></li>
        </ul>
      </li>
    </ul>


    <ul class="r_main">
      <li class="main-item has-submenu">
        <a href="#">이벤트</a>
        <ul class="submenu">
          <li><a href="#">진행중인 이벤트</a></li>
          <li><a href="#">지난 이벤트</a></li>
          <li><a href="#">당첨자 확인</a></li>
        </ul>
      </li>
      <li class="main-item store-menu"><a href="#">스토어</a></li>
      <li class="main-item has-submenu">
        <a href="#">혜택</a>
        <ul class="submenu">
          <li><a href="#">메가박스 멤버쉽</a></li>
          <li><a href="#">제휴/할인</a></li>
        </ul>
      </li>
    </ul>
    <div class="submenu-bg"></div>
    <script>
      // jQuery 코드
      $(function () {
        // "스토어"를 제외한 메뉴만 hover 효과 적용
        $('.nav-center .main-item:not(.store-menu) > a').mouseenter(function () {
          $('.submenu-bg').css('display', 'block');
        });

        $('.nav-center .main-item:not(.store-menu)').mouseleave(function () {
          $('.submenu-bg').css('display', 'none');
        });
      });

    </script>
  </div>

</header>--%>

<header>
  <jsp:include page="jsp/sub_menu.jsp"/>
</header>

<div class="topBox">
  <div class="theaterTopBox">
    <div class="location">
      <span>Home</span>
      &nbsp;>&nbsp;
      <span>전체극장</span>
      >
      <a href="#">극장정보</a>
    </div>
  </div>
</div>

<div id="contents" class="no-padding">
  <div class="theater-detail-page">
    <div class="img">
      <p>더부티크 목동 현대 백화점</p>
    </div>
  </div>
  <div class="inner-wrap">
    <!-- 탭 메뉴 -->
    <ul class="sub-tab-menu">
      <li><button type="button" class="tab-link active" onclick="ex1()">극장정보</button></li>
      <li><button type="button" class="tab-link" onclick="ex2()">상영시간표</button></li>
      <li><button type="button" class="tab-link" onclick="ex3()">관람료</button></li>
    </ul>

    <div id="tab1" class="tab-content show"></div>
    <div id="tab2" class="tab-content"></div>
    <div id="tab3" class="tab-content"></div>

  </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7e9af1de8ac409c7ec1e76b2d2022b5e&autoload=false" async onload="initMap()"></script>

<script>
  function ex1() {
    activateTab(0);
    $("#tab1").load("theater_info.jsp", function(){
      initMap();
    });
  }

  function ex2() {
    activateTab(1);
    $("#tab2").load("theater_timetable.jsp", function () {

    });
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




  function collapse(element) {
    var before = document.getElementsByClassName("active")[0]               // 기존에 활성화된 버튼
    if (before && document.getElementsByClassName("active")[0] != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
      before.nextElementSibling.style.maxHeight = null;   // 기존에 펼쳐진 내용 접고
      before.classList.remove("active");                  // 버튼 비활성화
    }
    element.classList.toggle("active");         // 활성화 여부 toggle

    var content = element.nextElementSibling;
    if (content.style.maxHeight != 0) {         // 버튼 다음 요소가 펼쳐져 있으면
      content.style.maxHeight = null;         // 접기
    } else {
      content.style.maxHeight = content.scrollHeight + "px";  // 접혀있는 경우 펼치기
    }
  }

  function initMap() {

    // 지금 브렌치는 선영이 작성하고 있는 내용입니다.
    var container = document.getElementById('map');
    var options = {
      center: new kakao.maps.LatLng(37.5284455288195, 127.125357402766), //위도, 경도
      level: 3
    };

    var map = new kakao.maps.Map(container, options);


    // 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다
    var points = [
      new kakao.maps.LatLng(37.5284455288195, 127.125357402766)
    ];

    // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
    var bounds = new kakao.maps.LatLngBounds();

    var i, marker;
    for (i = 0; i < points.length; i++) {
      // 마커를 생성
      marker = new kakao.maps.Marker({ position : points[i] });
      marker.setMap(map); //마커가 지도위에 표시되도록 함

      // LatLngBounds 객체에 좌표를 추가합니다
      bounds.extend(points[i]);
    }

  }
</script>

<%--주소(Address) : 서울 강동구 성내로 48
위도(Latitude) : 37.5284455288195 / 경도(Longitude) : 127.125357402766--%>
<%--카카오map--%>

  
  </body>
</html>
