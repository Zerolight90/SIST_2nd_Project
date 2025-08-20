<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>영화 상세 정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/sub_page_style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tab.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie_info/movie_info.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie_info/movieDetail.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">
</head>
<body>

<header>
  <jsp:include page="/common/sub_menu.jsp"/>
</header>

<div class="topBox">
  <div class="theaterTopBox">
    <div class="location">
      <span>Home</span> &gt; <span>영화</span> &gt; <a href="Controller?type=allMovie">전체영화</a>
    </div>
  </div>
</div>

<div id="movie_content">
  <div class="movie-hero">
    <div class="movie-info">
      <div class="movie_bg" style="background-image: url('${movie.background}');"></div>
      <h2><c:out value="${movie.name}" /></h2>
      <p><c:out value="${movie.gen}" /></p>

      <div class="stats_txt">
      <p class="stats">
        <i class="fa-solid fa-ticket" aria-hidden="true"></i>
        예매율
        <c:out value="${movie.bookingRate}"/>%
      </p>

      <p class="stats">
        <i class="fa-solid fa-users" aria-hidden="true"></i>
        누적관객수
        <c:out value="${movie.audNum}"/>명
      </p>
      </div>


    </div>
    <div class="movie-poster">
      <img src="${movie.poster}" alt="${movie.name} 포스터">

      <button class="btn">예매하기</button>
    </div>
  </div>
</div>

<div class="inner-wrap">
  <div class="ec-base-tab typeLight m50">
    <ul class="menu" style="font-size: 16px;">
      <li class="selected"><a href="#none">주요정보</a></li>
      <li><a href="#none">실관람평</a></li>
      <li><a href="#none">예고편</a></li>
    </ul>
  </div>

  <div class="ec-base-tab typeLight eTab">
    <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px;">
      <h3>기본 정보</h3>
      <p><strong>감독:</strong> <c:out value="${movie.dir}" /></p>
      <p><strong>배우:</strong> <c:out value="${movie.actor}" /></p>
      <p><strong>장르:</strong> <c:out value="${movie.gen}" /></p>
      <p><strong>러닝타임:</strong> <c:out value="${movie.runtime}" />분</p>
      <p><strong>개봉일:</strong> <c:out value="${movie.date}" /></p>
      <p><strong>관람등급:</strong> <span class="age-rating age-${movie.age}"><c:out value="${movie.age}" /></span></p>

      <h3>줄거리</h3>
      <p><c:out value="${movie.synop}" /></p>

      <div class="rating-wrapper">

        <div class="rating-item">
          <div class="label">실관람 평점</div>
          <canvas id="ratingChart" width="120" height="120"></canvas>
          <div class="sub-label">예매율 76.9%</div>
        </div>

        <div class="rating-item">
          <div class="label">누적 관객수</div>
          <div class="audience-number">23,632</div>
          <canvas id="audienceChart" width="300" height="120"></canvas>
        </div>

      </div>

    </div>

    <div id="tabCont1_2" class="tabCont" style="display:none; width: 1100px;">
      <p>실관람평 탭 내용입니다.</p>
    </div>


    <div id="tabCont1_3" class="tabCont" style="display:none; width: 1100px;">
       <c:if test="${not empty movie.trailer}">
         <div id="playerWrapper">
           <div id="player"></div>
         </div>
      </c:if>
    </div>


    <script src="https://www.youtube.com/iframe_api"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
      // 평점 도넛 차트

      const ratingCtx = document.getElementById('ratingChart').getContext('2d');

      // 임의 데이터 (DB 연동 전 테스트용)
      const ratingValue = 4.8;       // 5점 만점 평점
      const bookingRate = 76.9;      // 예매율 %
      const audienceData = [0, 23632, 23500];  // 누적 관객수 데이터
      const audienceLabels = ['08.11', '08.16', '08.17'];

      // 도넛 차트 중앙 텍스트 플러그인
      const centerTextPlugin = {
        id: 'centerText',
        afterDraw(chart) {
          const {ctx, width, height} = chart;
          ctx.save();

          ctx.font = 'bold 36px Noto Sans KR';
          ctx.fillStyle = '#4a3ea1';
          ctx.textAlign = 'center';
          ctx.textBaseline = 'middle';
          ctx.fillText(ratingValue.toFixed(1), width / 2, height / 2);  // 중앙 정렬

          ctx.font = 'normal 16px Noto Sans KR';
          ctx.fillStyle = '#999999';
          <%--ctx.fillText(`예매율 ${bookingRate.toFixed(1)}%`, width / 2, height / 2 + 25);--%>

          ctx.restore();
        }
      };


      // 평점 도넛 차트 생성
      new Chart(ratingCtx, {
        type: 'doughnut',
        data: {
          datasets: [{
            data: [ratingValue, 5 - ratingValue],
            backgroundColor: ['#5a3ea1', '#e0e0e0'],
            borderWidth: 0
          }]
        },
        options: {
          cutout: '80%',
          plugins: {
            tooltip: {enabled: false},
            legend: {display: false}
          }
        },
        plugins: [centerTextPlugin]
      });

      // 누적 관객수 라인 차트 생성
      const audienceCtx = document.getElementById('audienceChart').getContext('2d');

      new Chart(audienceCtx, {
        type: 'line',
        data: {
          labels: audienceLabels,
          datasets: [{
            label: '누적관객수',
            data: audienceData,
            borderColor: '#5a3ea1',
            fill: false,
            tension: 0.3,
            pointRadius: 4,
            pointBackgroundColor: '#5a3ea1'
          }]
        },
        options: {
          scales: {
            y: {beginAtZero: true, ticks: {stepSize: 5000}},
            x: {grid: {display: false}}
          },
          plugins: {
            legend: {display: false}
          },
          elements: {
            line: {borderWidth: 2}
          }
        }
      });


      let player;

      // TMDB에서 받은 전체 URL에서 유튜브 영상 ID만 추출하는 함수
      function extractYouTubeVideoId(url) {
        if (!url) return null;
        const urlObj = new URL(url);
        if (urlObj.hostname === 'youtu.be') {
          return urlObj.pathname.slice(1);
        }
        if (urlObj.hostname === 'www.youtube.com' || urlObj.hostname === 'youtube.com') {
          return urlObj.searchParams.get('v');
        }
        return null;
      }

      function onYouTubeIframeAPIReady() {
        // JSP에서 movie.trailer 전체 URL을 받아옴
        const trailerUrl = '<c:out value="${movie.trailer}" />';
        const videoId = extractYouTubeVideoId(trailerUrl);

        if (videoId) {
          player = new YT.Player('player', {
            width: '720',
            height: '480',
            videoId: videoId,
            playerVars: {
              autoplay: 0,
              controls: 1,
              rel: 0,
              showinfo: 0
            },
            events: {
              onReady: onPlayerReady,
              onError: onPlayerError
            }
          });
        } else {
          // 영상 ID가 없으면 플레이어 생성 안 함
          document.getElementById('player').innerHTML = '<p>예고편 영상을 불러올 수 없습니다.</p>';
        }
      }

      function onPlayerReady(event) {
        // 필요 시 플레이어 준비 후 동작 추가 가능
      }

      function onPlayerError(event) {
        console.error('YouTube Player Error:', event.data);
      }

      // 탭 전환 스크립트 (탭과 컨텐츠 개수 맞춤)
      document.addEventListener('DOMContentLoaded', function () {
        const tabs = document.querySelectorAll('.menu li');
        const tabContents = document.querySelectorAll('.tabCont');

        if (tabs.length !== tabContents.length) {
          console.warn('탭과 컨텐츠 개수가 일치하지 않습니다.');
          return;
        }

        tabs.forEach((tab, index) => {
          tab.addEventListener('click', function (e) {
            e.preventDefault();

            tabs.forEach(t => t.classList.remove('selected'));
            tab.classList.add('selected');

            tabContents.forEach(c => c.style.display = 'none');
            if (tabContents[index]) {
              tabContents[index].style.display = 'block';
            }
          });
        });
      });
    </script>


  <jsp:include page="/common/Footer.jsp"/>
</body>
</html>
