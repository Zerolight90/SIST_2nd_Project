<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/allmovie.css" />
<html>
<head>
  <meta charset="UTF-8">
  <title>영화 상세 정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/sub_page_style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tab.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie_info/movie_info.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie_info/movieDetail.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/review/review.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
          예매율 <c:out value="${movie.bookingRate}"/>%
        </p>
        <p class="stats">
          <i class="fa-solid fa-users" aria-hidden="true"></i>
          누적관객수 <c:out value="${movie.audNum}"/>명
        </p>
      </div>
    </div>
    <div class="movie-poster">
      <img src="${movie.poster}" alt="${movie.name} 포스터">
      <button class="btn">
        <a href="Controller?type=booking&mIdx=${movie.mIdx}">예매하기</a>
      </button>
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

    <!-- 주요정보 탭 -->
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
          <div class="sub-label">예매율 <fmt:formatNumber value="${movie.bookingRate}" pattern="#,##0.0"/>%</div>
        </div>
        <div class="rating-item">
          <div class="label">누적 관객수</div>
          <div class="audience-number">${movie.audNum}</div>
          <canvas id="audienceChart" width="300" height="120"></canvas>
        </div>
      </div>
    </div>

    <!-- 실관람평 탭 -->
    <div id="tabCont1_2" class="tabCont" style="display:none; width: 1100px;">

      <div class="review-write">
        <h4>리뷰 작성하기</h4>

        <c:choose>

          <c:when test="${not empty sessionScope.mvo}">

            <form id="reviewForm" action="Controller?type=review" method="post">
              <input type="hidden" name="mIdx" value="${movie.mIdx}">
              <input type="hidden" name="username" value="${sessionScope.mvo.name}" />

              <!-- 이름과 평점을 한 줄에 배치 -->
              <div class="form-row">
                <div class="form-group name-group">
                  <label for="userIdx">이름</label>
                  <div class="nickname-display" id="nicknameDisplay">
                    <c:out value="${sessionScope.mvo.name.charAt(0)}"/>**
                  </div>

                </div>

                <div class="form-group rating-group">
                  <label for="starRating">평점</label>
                  <div id="starRating" class="star-rating" aria-label="평점 선택">
                    <span class="star" data-value="1">&#9733;</span>
                    <span class="star" data-value="2">&#9733;</span>
                    <span class="star" data-value="3">&#9733;</span>
                    <span class="star" data-value="4">&#9733;</span>
                    <span class="star" data-value="5">&#9733;</span>
                  </div>
                  <input type="hidden" id="rating" name="rating" required />
                </div>
              </div>

              <!-- 리뷰 내용 (maxlength=100 적용) -->
              <div class="form-group">
                <label for="reviewText">리뷰내용</label>
                <textarea id="reviewText" name="reviewText" rows="4" maxlength="100" placeholder="리뷰를 작성해주세요 (100자 이내)" required></textarea>
                <div class="char-count"><span id="charCount">0</span>/100</div>
              </div>

              <div class="form-group btn-group">
                <button type="submit" class="btn-submit" id="submitReview">작성 완료</button>
              </div>
            </form>
          </c:when>

          <c:otherwise>
            <p>리뷰를 작성하려면 <strong><a href="${pageContext.request.contextPath}/Controller?type=login&movieDetail&mIdx=${movie.mIdx}">로그인</a></strong>이 필요합니다.</p>
          </c:otherwise>
        </c:choose>
      </div>

      <div class="reivew-read">
        <c:forEach var="review" items="${requestScope.rvo}">
          <div class="review-item">
            <div class="user">
              <c:choose>
                <c:when test="${not empty review.member.name}">
                  ${fn:substring(review.member.name, 0, 1)}**
                </c:when>
                <c:otherwise>
                  <!-- 회원의 이름이 없는 경우 (예: 탈퇴 회원 또는 guest 리뷰) 처리 -->
                  익명 사용자
                </c:otherwise>
              </c:choose>
            </div>
            <div class="review-content">
              <div class="review-header-info">
                <span class="review-score">평점 ${review.reviewRating}</span>
                <span class="time">${review.reviewDate}</span>
              </div>
              <p class="review-text">${fn:escapeXml(review.reviewContent)}</p>
            </div>
          </div>
        </c:forEach>
      </div>


    </div>

    <!-- 예고편 탭 -->
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
      (function($){
        'use strict';

        let player = null;
        window.getPlayer = () => player;

        // ---------------- 차트 초기화 ----------------
        const initCharts = () => {
          try {
            const ratingCanvas = document.getElementById('ratingChart');
            if (ratingCanvas) {
              const ratingCtx = ratingCanvas.getContext('2d');
              const ratingValue = 4.8; // ★ 실제 평점 값으로 바꾸셔도 됩니다
              const centerTextPlugin = {
                id: 'centerText',
                afterDraw(chart) {
                  const {ctx, width, height} = chart;
                  ctx.save();
                  ctx.font = 'bold 36px Noto Sans KR';
                  ctx.fillStyle = '#4a3ea1';
                  ctx.textAlign = 'center';
                  ctx.textBaseline = 'middle';
                  ctx.fillText(ratingValue.toFixed(1), width / 2, height / 2);
                  ctx.restore();
                }
              };
              new Chart(ratingCtx, {
                type: 'doughnut',
                data: { datasets: [{ data: [ratingValue, 5 - ratingValue], backgroundColor: ['#5a3ea1', '#e0e0e0'], borderWidth: 0 }] },
                options: { cutout: '80%', plugins: { tooltip: {enabled: false}, legend: {display: false} } },
                plugins: [centerTextPlugin]
              });
            }

            const audienceCanvas = document.getElementById('audienceChart');
            if (audienceCanvas) {
              const audienceCtx = audienceCanvas.getContext('2d');
              const audienceData = [0, 23632, 23500];
              const audienceLabels = ['08.11', '08.16', '08.17']; //개봉일~어제날짜까
              new Chart(audienceCtx, {
                type: 'line',
                data: { labels: audienceLabels, datasets: [{ label: '누적관객수', data: audienceData, borderColor: '#5a3ea1', fill: false, tension: 0.3, pointRadius: 4, pointBackgroundColor: '#5a3ea1' }] },
                options: { scales: { y: {beginAtZero: true, ticks: {stepSize: 5000}}, x: {grid: {display: false}} }, plugins: { legend: {display: false} }, elements: { line: {borderWidth: 2} } }
              });
            }
          } catch (err) {
            console.warn('Chart init error:', err);
          }
        };

        // ---------------- 유튜브 ----------------
        const extractYouTubeVideoId = (url) => {
          if (!url) return null;
          try {
            const urlObj = new URL(url);
            if (urlObj.hostname === 'youtu.be') return urlObj.pathname.slice(1);
            if (urlObj.hostname.includes('youtube.com')) return urlObj.searchParams.get('v');
          } catch (e) {
            return null;
          }
          return null;
        };

        window.onYouTubeIframeAPIReady = function() {
          const trailerUrl = '<c:out value="${movie.trailer}" />';
          const videoId = extractYouTubeVideoId(trailerUrl);
          const playerContainer = document.getElementById('player');
          if (!playerContainer) return;
          if (videoId) {
            player = new YT.Player('player', {
              width: '720', height: '480', videoId: videoId,
              playerVars: { autoplay: 0, controls: 1, rel: 0, showinfo: 0 },
              events: { onReady: () => {}, onError: (e) => console.error('YouTube Player Error:', e.data) }
            });
          } else {
            playerContainer.innerHTML = '<p>예고편 영상을 불러올 수 없습니다.</p>';
          }
        };

        // ---------------- 탭 ----------------
        const initTabs = () => {
          const tabs = document.querySelectorAll('.menu li');
          const tabContents = document.querySelectorAll('.tabCont');

          if (!tabs.length || !tabContents.length) return;

          const minLen = Math.min(tabs.length, tabContents.length);
          // 초기화
          tabs.forEach(t => t.classList.remove('selected'));
          tabContents.forEach(c => c.style.display = 'none');
          tabs[0].classList.add('selected');
          tabContents[0].style.display = 'block';

          for (let i = 0; i < minLen; i++) {
            tabs[i].addEventListener('click', function(e) {
              e.preventDefault();
              tabs.forEach(t => t.classList.remove('selected'));
              this.classList.add('selected');
              tabContents.forEach(c => c.style.display = 'none');
              if (tabContents[i]) tabContents[i].style.display = 'block';
            });
          }
        };

        // ---------------- 리뷰 ----------------
        const initReviews = () => {
          const $reviewForm = $('#reviewForm');
          const $stars = $('#starRating .star');
          const $ratingInput = $('#rating');
          const $reviewText = $('#reviewText');
          const $charCount = $('#charCount');

          // JSP에서 로그인한 사용자 이름을 JS 변수로 가져오기
          const loginUserNameRaw = '${sessionScope.mvo != null ? sessionScope.mvo.name : ""}';

          const maskUserName = (name) => name ? (name.charAt(0) + '**') : '익명';

          const updateStarColors = (value) => {
            $stars.each(function() {
              $(this).css('color', parseInt($(this).data('value')) <= value ? '#f5a623' : '#ccc');
            });
          };

          // 별점 이벤트
          $stars.on('mouseenter', function() { updateStarColors(parseInt($(this).data('value'))); });
          $stars.on('mouseleave', function() { updateStarColors(parseInt($ratingInput.val()) || 0); });
          $stars.on('click', function() {
            const val = parseInt($(this).data('value'));
            $ratingInput.val(val);
            updateStarColors(val);
          });
          $stars.css('color', '#ccc');

          // 글자수 카운트
          $reviewText.on('input', function() { $charCount.text($(this).val().length); });

          // 리뷰 폼 전송
          $reviewForm.on('submit', function(e) {
            e.preventDefault();

            const rating = $ratingInput.val();
            const reviewText = $reviewText.val().trim();
            const now = new Date().toISOString();
            const userIdMasked = maskUserName(loginUserNameRaw);

            if (!rating) { alert('평점을 선택해주세요.'); return; }
            if (!reviewText) { alert('리뷰 내용을 입력해주세요.'); return; }

            $.ajax({
              url: $reviewForm.attr('action'),
              type: "POST",
              data: $reviewForm.serialize(),
              success: function() {
                const $newReview = $(`
              <div class="review-item" data-likes="0" data-rating="${rating}" data-time="${now}">
                <div class="user">${userIdMasked}</div>
                <div class="review-content">
                  <div class="review-header-info">
                    <span class="review-score">평점 ${rating}</span>
                    <span class="time">방금 전</span>
                  </div>
                  <p class="review-text">${reviewText}</p>
                </div>
              </div>
            `);

                $('.reivew-read').prepend($newReview);

                // 폼 초기화
                $reviewForm[0].reset();
                $charCount.text('0');
                updateStarColors(0);
              }
            });
          });
        };

        // ---------------- 실행 ----------------
        $(function() {
          initCharts();
          initTabs();
          initReviews();
        });

      })(jQuery);
    </script>



<jsp:include page="/common/Footer.jsp"/>
</body>
</html>
