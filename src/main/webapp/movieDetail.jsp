<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <form id="reviewForm">
              <div class="form-group">
                <label>이름</label>
                <div style="font-weight: 700; font-size: 16px; color: #333; margin-bottom: 12px;">
                  <c:out value="${sessionScope.mvo.name.charAt(0)}"/>**
                </div>
              </div>

              <!-- extraCategory 체크박스 그룹 -->
              <div class="form-group">
                <label>평가 항목 선택 (복수 선택 가능)</label>
                <div style="display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 12px;">
                  <label><input type="checkbox" name="extraCategory" value="연출" /> 연출</label>
                  <label><input type="checkbox" name="extraCategory" value="영상미" /> 영상미</label>
                  <label><input type="checkbox" name="extraCategory" value="스토리" /> 스토리</label>
                  <label><input type="checkbox" name="extraCategory" value="편집" /> 편집</label>
                  <label><input type="checkbox" name="extraCategory" value="음향" /> 음향</label>
                </div>
              </div>

              <!-- 평점 별 5개 -->
              <div class="form-group">
                <label>평점</label>
                <div id="starRating" style="font-size: 28px; color: #ccc; cursor: pointer; user-select: none;">
                  <span class="star" data-value="1">&#9733;</span>
                  <span class="star" data-value="2">&#9733;</span>
                  <span class="star" data-value="3">&#9733;</span>
                  <span class="star" data-value="4">&#9733;</span>
                  <span class="star" data-value="5">&#9733;</span>
                </div>
                <input type="hidden" id="rating" name="rating" required />
              </div>

              <!-- 리뷰 내용 -->
              <div class="form-group">
                <label for="reviewText">리뷰 내용</label>
                <textarea id="reviewText" name="reviewText" rows="4" placeholder="리뷰를 작성해주세요" required></textarea>
              </div>

              <div class="form-group btn-group">
                <button type="submit" class="btn-submit">작성 완료</button>
              </div>
            </form>
          </c:when>
          <c:otherwise>
            <p>리뷰를 작성하려면 <strong><a href="/Controller?type=login">로그인</a></strong>이 필요합니다.</p>
          </c:otherwise>
        </c:choose>
      </div>

      <div class="reivew-read">

        <c:forEach var="review" items="${requestScope.rvo}">
          <div class="review-item">
<%--            <div class="user">--%>
<%--              <c:choose>--%>
<%--                <c:when test="${not empty review.member.name}">--%>
<%--                  ${fn:substring(member.name, 0, 1)}**--%>
<%--                </c:when>--%>
<%--             </c:choose>--%>
<%--            </div>--%>
            <div class="review-content">
              <div class="review-header-info">
                <span class="review-score">관람평 ${review.reviewRating}</span>
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
  // 평점 도넛 차트
  const ratingCtx = document.getElementById('ratingChart').getContext('2d');
  const ratingValue = 4.8;
  const bookingRate = 76.9;
  const audienceData = [0, 23632, 23500];
  const audienceLabels = ['08.11', '08.16', '08.17'];

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
      ctx.font = 'normal 16px Noto Sans KR';
      ctx.fillStyle = '#999999';
      ctx.restore();
    }
  };

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

  // 누적 관객수 라인 차트
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

  // 유튜브 플레이어 관련 함수
  let player;
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
    const trailerUrl = '<c:out value="${movie.trailer}" />';
    const videoId = extractYouTubeVideoId(trailerUrl);
    if (videoId) {
      player = new YT.Player('player', {
        width: '720',
        height: '480',
        videoId: videoId,
        playerVars: { autoplay: 0, controls: 1, rel: 0, showinfo: 0 },
        events: { onReady: onPlayerReady, onError: onPlayerError }
      });
    } else {
      document.getElementById('player').innerHTML = '<p>예고편 영상을 불러올 수 없습니다.</p>';
    }
  }
  function onPlayerReady(event) {}
  function onPlayerError(event) {
    console.error('YouTube Player Error:', event.data);
  }

  // 탭 전환 스크립트
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

  // 리뷰 정렬 및 작성 스크립트
  $(function() {
    $('.sort-btn').on('click', function() {
      const sortType = $(this).data('sort');
      const $list = $('.review-list');
      const $items = $list.children('.review-item').toArray();

      $('.sort-btn').removeClass('active');
      $(this).addClass('active');

      if (sortType === 'latest') {
        $items.sort((a, b) => new Date($(b).data('time')) - new Date($(a).data('time')));
      } else if (sortType === 'likes') {
        $items.sort((a, b) => $(b).data('likes') - $(a).data('likes'));
      } else if (sortType === 'rating') {
        $items.sort((a, b) => $(b).data('rating') - $(a).data('rating'));
      }

      $list.empty();
      $items.forEach(item => $list.append(item));
    });

    $('.sort-btn[data-sort="latest"]').addClass('active');

    // 닉네임 마스킹 함수
    function maskUserName(name) {
      if (!name) return '';
      return name.charAt(0) + '**';
    }

    // 로그인 유저 닉네임 세팅
    const loginUserName = '<c:out value="${sessionScope.mvo.name}" />';
    if (loginUserName) {
      $('#userId').val(maskUserName(loginUserName));
    }

    // 리뷰 작성 폼 제출 이벤트
    $('#reviewForm').on('submit', function(e) {
      e.preventDefault();

      const userIdRaw = $('#userId').val().trim();
      const userId = maskUserName(userIdRaw);
      const rating = $('#rating').val();
      const extraCategory = $('#extraCategory').val();
      const extraScore = $('#extraScore').val() || 0;
      const reviewText = $('#reviewText').val().trim();

      if (!userIdRaw) {
        alert('닉네임을 입력해주세요.');
        $('#userId').focus();
        return;
      }
      if (!rating) {
        alert('평점을 선택해주세요.');
        $('#rating').focus();
        return;
      }
      if (!reviewText) {
        alert('리뷰 내용을 입력해주세요.');
        $('#reviewText').focus();
        return;
      }

      const now = new Date().toISOString();

      const $newReview = $(`
        <li class="review-item" data-likes="0" data-rating="${rating}" data-time="${now}">
          <div class="user-icon">${userId}</div>
          <div class="review-content">
            <div class="review-score">
              <span class="label">관람평</span>
              <span class="score">${rating}</span>
              <span class="extra">${extraCategory} +${extraScore}</span>
            </div>
            <p class="review-text"></p>
            <div class="review-footer">
              <span class="likes"><i class="fa-regular fa-thumbs-up"></i> 0</span>
              <span class="time">방금 전</span>
            </div>
          </div>
        </li>
      `);

      $newReview.find('.review-text').text(reviewText);

      $('.review-list').prepend($newReview);

      this.reset();

      $('.sort-btn').removeClass('active');
      $('.sort-btn[data-sort="latest"]').addClass('active');
      $('.sort-btn[data-sort="latest"]').trigger('click');
    });
  });

  $(function() {
    // 별점 클릭 이벤트
    const $stars = $('#starRating .star');
    $stars.on('mouseenter', function() {
      const val = parseInt($(this).data('value'));
      $stars.each(function() {
        $(this).css('color', parseInt($(this).data('value')) <= val ? '#f5a623' : '#ccc');
      });
    }).on('mouseleave', function() {
      const ratingVal = parseInt($('#rating').val()) || 0;
      $stars.each(function() {
        $(this).css('color', parseInt($(this).data('value')) <= ratingVal ? '#f5a623' : '#ccc');
      });
    }).on('click', function() {
      const val = parseInt($(this).data('value'));
      $('#rating').val(val);
      $stars.each(function() {
        $(this).css('color', parseInt($(this).data('value')) <= val ? '#f5a623' : '#ccc');
      });
    });

    // 초기 별점 색상 세팅
    $stars.css('color', '#ccc');
  });

</script>

<jsp:include page="/common/Footer.jsp"/>
</body>
</html>
