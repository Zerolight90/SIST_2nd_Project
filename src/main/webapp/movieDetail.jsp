<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/sub_page_style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tab.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie_info/movie_info.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie_info/movieDetail.css">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">
</head>

<header>
  <jsp:include page="/common/sub_menu.jsp"/>
</header>
<body>

<div>
  <div class="topBox">
    <div class="theaterTopBox">
      <div class="location">
        <span>Home</span>
        &nbsp;>&nbsp;
        <span>영화</span>
        >
        <a href="Controller?type=allMovie">전체영화</a>
      </div>
    </div>
  </div>

  <!-- 영화 메인 포스터 영역 -->
  <div id="movie_content">
    <div class="movie-hero">

      <c:set var="basePath" value="${pageContext.request.contextPath}" />
      <div class="movie-info">

        <div class="movie_bg" style="background-image: url('${movie.background}');"></div>

       <h2><c:out value="${movie.name}" /></h2>
        <p><c:out value="${movie.gen}" /></p>
        <p class="stats">예매율 <c:out value="${movie.bookingRate}" />% | 누적관객수 <c:out value="${movie.audNum}" />명</p>
        <button class="btn">예매하기</button>
      </div>
      <div class="movie-poster">
        <img src="${movie.poster}" alt="${movie.name} 배경 포스터">
      </div>

    </div>
  </div>

  <%--컨텐츠 시작--%>
  <div class="inner-wrap">
    <div class="ec-base-tab typeLight m50">
      <ul class="menu" style="font-size: 16px;">
        <li class="selected"><a href="#none">주요정보</a></li>
        <li><a href="#none">실관람평</a></li>
        <li><a href="#none">예고편</a></li>
      </ul>
    </div>
    <!-- 비동기식 페이지 전환 : 라인형-->
    <div class="ec-base-tab typeLight eTab">

      <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px">
        <h3>기본 정보</h3>
        <p><strong>감독:</strong> <c:out value="${movie.dir}" /></p>
        <p><strong>배우:</strong> <c:out value="${movie.actor}" /></p>
        <p><strong>장르:</strong> <c:out value="${movie.gen}" /></p>
        <p><strong>러닝타임:</strong> <c:out value="${movie.runtime}" />분</p>
        <p><strong>개봉일:</strong> <c:out value="${movie.date}" /></p>
        <p><strong>관람등급:</strong> <span class="age-rating age-${movie.age}"><c:out value="${movie.age}" /></span></p>

        <h3>줄거리</h3>
        <p><c:out value="${movie.synop}" /></p>
      </div>

      <%--2 상영시간표 탭--%>
      <div id="tabCont1_2" class="tabCont" style="display:none; width: 1100px">
        <!-- 실관람평 내용 -->
        <p>실관람평 탭 내용입니다.</p>
      </div>

      <%--3 영화관람료 탭--%>
      <div id="tabCont1_3" class="tabCont" style="display:none; width: 1100px">
        <!-- 예고편 탭 내용 -->
        <p>예고편 탭 내용입니다.</p>
        <c:if test="${not empty movie.trailer}">
          <iframe width="560" height="315" src="${movie.trailer}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </c:if>
      </div>
    </div>
  </div>
</div>

<script>
  // 1. 모든 탭 버튼(li)과 내용 영역(div)을 가져옵니다.
  const tabs = document.querySelectorAll('.menu li');
  const tabContents = document.querySelectorAll('.tabCont');

  // 2. 각 탭 버튼에 클릭 이벤트 리스너를 추가합니다.
  tabs.forEach((tab, index) => {
    tab.addEventListener('click', (e) => {
      // a 태그의 기본 동작(페이지 이동)을 막습니다.
      e.preventDefault();

      // 3. 모든 탭에서 'selected' 클래스를 제거합니다.
      tabs.forEach(item => item.classList.remove('selected'));

      // 4. 방금 클릭한 탭에만 'selected' 클래스를 추가합니다.
      tab.classList.add('selected');

      // 5. 모든 내용 영역을 숨깁니다.
      tabContents.forEach(content => content.style.display = 'none');

      // 6. 클릭한 탭과 순서가 맞는 내용 영역만 보여줍니다.
      tabContents.style.display = 'block';
    });
  });

  $(function () {
    $(".tabCont").click(function () {
      var tab_id = $(this).attr("data-tab");

      $(".tabCont").style.display = 'none';
      $(".menu>li").removeClass("selected");

      $(this).addClass("active");
      $("#" + tab_id).addClass("active");
    });
  });

  function collapse(element) {
    var before = document.getElementsByClassName("active")               // 기존에 활성화된 버튼
    if (before && document.getElementsByClassName("active") != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
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
</script>

</body>

<jsp:include page="/common/Footer.jsp"/>
</html>
