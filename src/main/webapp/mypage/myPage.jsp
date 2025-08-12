<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="${cp}/css/reset.css">
  <link rel="stylesheet" href="${cp}/css/sub/sub_page_style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="${cp}/css/mypage.css">
  <link rel="icon" href="${cp}/images/favicon.png">

  <style>
    [data-tab-content="watched"] .movie-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
    [data-tab-content="watched"] .movie-card { text-align: center; }
    [data-tab-content="watched"] .movie-card img { width: 100%; border-radius: 8px; margin-bottom: 10px; }
    [data-tab-content="wished"] .movie-grid { display: flex; flex-wrap: wrap; gap: 24px; row-gap: 20px; width: 522px; margin: 0 auto; }
    .movie-item { width: 150px; text-align: center; }
    .movie-poster { position: relative; width: 150px; height: 214px; overflow: hidden; border-radius: 5px; background-color: #eee; }
    .movie-poster img { width: 100%; height: 100%; object-fit: cover; }
    .wish-button { position: absolute; top: 8px; right: 8px; background: transparent; border: none; color: white; font-size: 24px; cursor: pointer; padding: 0; text-shadow: 0 0 3px rgba(0,0,0,0.7); }
    .wish-button.wished .fa-heart-o { display: none; }
    .wish-button.wished .fa-heart { display: inline-block; color: #E50914; }
    .wish-button .fa-heart { display: none; }
    .movie-item h4 { font-size: 14px; margin-top: 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  </style>

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body>
<jsp:include page="../common/sub_menu.jsp"/>
<article>
  <div class="container">
    <nav class="side-nav">
      <h2>마이페이지</h2>
      <ul>
        <li><a href="${cp}/Controller?type=myReservation" class="nav-link active">예매/구매내역</a></li>
        <li><a href="${cp}/Controller?type=myCoupon" class="nav-link">제휴쿠폰</a></li>
        <li><a href="${cp}/Controller?type=myPoint" class="nav-link">멤버십 포인트</a></li>
        <li><a href="${cp}/Controller?type=myMovieStory" class="nav-link">나의 무비스토리</a></li>
        <li><a href="${cp}/Controller?type=myUserInfo" class="nav-link">회원정보</a></li>
      </ul>
    </nav>
    <main class="main-content" id="mainContent">
    </main>
  </div>
</article>
<jsp:include page="../common/Footer.jsp"/>

<script>
  $(function() {
    const mainContent = $('#mainContent');
    const cp = "${pageContext.request.contextPath}";

    // --- 초기 화면 로딩 ---
    mainContent.load(`${cp}/Controller?type=myReservation`);

    // --- 사이드 메뉴 클릭 이벤트 ---
    $('.side-nav .nav-link').on('click', function(e) {
      e.preventDefault();
      $('.side-nav .nav-link').removeClass('active');
      $(this).addClass('active');
      mainContent.load($(this).attr('href'));
    });

    // --- 이벤트 위임: #mainContent 내부에서 발생하는 모든 이벤트를 여기서 처리 ---

    // 1. '나의 무비스토리' 탭 클릭
    mainContent.on('click', '#movieStoryTabNav a', function(e) {
      e.preventDefault();
      const tabName = $(this).data('tab');

      // 탭 버튼 스타일 적용
      $('#movieStoryTabNav a').removeClass('active');
      $(this).addClass('active');

      // 모든 탭 콘텐츠 숨기고, 선택한 탭 콘텐츠만 보여줌
      mainContent.find('.tab-pane').removeClass('active');
      mainContent.find(`[data-tab-content="${tabName}"]`).addClass('active');
    });

    // 2. '나의 무비스토리' 페이지네이션 클릭 시 mainContent 전체를 새로 로드
    mainContent.on('click', '.pagination a', function(e) {
      e.preventDefault();
      const page = $(this).data('page');
      // const tabName = $(this).closest('.tab-pane').data('tab-content');
      const url = `${cp}/Controller?type=myMovieStory&cPage=${page}&currentTab=${tabName}`;
      mainContent.load(url);
    });

    // 3. '나의 무비스토리' 위시리스트 하트 버튼 클릭 시 mainContent 전체를 새로 로드
    mainContent.on('click', '.wish-button', function() {
      const mIdx = $(this).data('midx');
      $.ajax({
        url: `${cp}/Controller?type=addWishlist`,
        type: 'POST', data: { mIdx: mIdx }, dataType: 'json',
        success: function(response) {
          if (response.status === 'success' && response.action === 'removed') {
            const currentPage = $('#wishedPagination strong').text() || 1;
            const url = `${cp}/Controller?type=myMovieStory&cPage=${currentPage}&currentTab=wished`;
            mainContent.load(url);
          } else {
            alert('작업 실패: ' + (response.message || '알 수 없는 오류'));
          }
        },
        error: function() { alert('서버 오류로 위시리스트 변경에 실패했습니다.'); }
      });
    });
  });
</script>
</body>
</html>