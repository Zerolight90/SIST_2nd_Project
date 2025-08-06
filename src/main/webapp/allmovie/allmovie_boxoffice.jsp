<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전체영화 | CINEFEEL</title> [cite: 20, 21]
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="../css/reset.css" />
  <link rel="stylesheet" href="../css/style.css" />
  <link rel="stylesheet" href="../css/sub/sub_page_style.css">
  <link rel="stylesheet" href="../css/allmovie.css">
  <style>
    /* TOP 버튼 스타일 */
    .top-btn {
      position: fixed;
      bottom: 30px;
      right: 30px;
      width: 50px;
      height: 50px;
      background-color: #333;
      color: #fff;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      opacity: 0;
      visibility: hidden;
      transition: opacity 0.3s, visibility 0.3s;
      z-index: 1000;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      font-size: 12px;
    }
    .top-btn.visible {
      opacity: 1;
      visibility: visible;
    }
    .top-btn i {
      font-size: 16px;
      margin-bottom: 2px;
    }
  </style>
</head>
<body>
<jsp:include page="../common/sub_menu.jsp" />

<div id="container">
  <div class="content">
    <h2 class="title">전체영화</h2>

    <ul class="tabs">
      <li class="active" data-tab="boxoffice">박스오피스</li>
      <li data-tab="scheduled">상영예정작</li>
      <li data-tab="sistonly">SIST ONLY</li> [cite: 22]
      <li data-tab="filmsociety">필름소사이어티</li>
      <li data-tab="classicsociety">클래식소사이어티</li>
    </ul>

    <div class="movie-options">
      <div class="total-count">
        총 <strong id="movie-total-count">0</strong>개의 영화가 검색되었습니다. [cite: 23]
      </div>
      <div class="search-box">
        <input type="text" id="search-input" placeholder="영화명 검색">
        <button type="button" id="search-button"><i class="fa-solid fa-magnifying-glass"></i></button>
      </div>
    </div>

    <div id="movie-list-container">
    </div>

    <div class="more-btn-wrap" style="display:none;">
      <button type="button" class="more-btn">더보기 <i class="fa-solid fa-chevron-down"></i></button>
    </div>
  </div>
</div>

<button type="button" class="top-btn">
  <i class="fa-solid fa-arrow-up"></i>
  <span>TOP</span>
</button>


<jsp:include page="../common/Footer.jsp" />

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const tabs = document.querySelectorAll('.tabs li');
    const movieTotalCount = document.getElementById('movie-total-count');
    const searchInput = document.getElementById('search-input');
    const searchButton = document.getElementById('search-button');
    const movieListContainer = document.getElementById('movie-list-container');
    const moreBtnWrap = document.querySelector('.more-btn-wrap');
    const moreBtn = document.querySelector('.more-btn');
    const topBtn = document.querySelector('.top-btn');

    const API_KEY = 'YOUR_TMDB_API_KEY'; // 여기에 TMDB API 키를 입력
    const BASE_URL = 'https://api.themoviedb.org/3';
    const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w500';

    let currentPage = 1;
    let currentTab = 'boxoffice';
    let currentSearchQuery = '';

    const apiEndpoints = {
      boxoffice: '/movie/now_playing', // 박스오피스: 현재 상영작
      scheduled: '/movie/upcoming',    // 상영예정작
      sistonly: '/discover/movie?with_keywords=188433', // SIST ONLY: 특정 키워드(예: 독립영화)를 가진 영화
      filmsociety: '/movie/top_rated', // 필름소사이어티: 평점 높은 영화
      classicsociety: '/discover/movie?with_genres=36' // 클래식소사이어티: 역사 장르 영화
    };

    // 탭 클릭 이벤트
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        tabs.forEach(item => item.classList.remove('active'));
        tab.classList.add('active');
        currentTab = tab.getAttribute('data-tab');
        currentPage = 1;
        currentSearchQuery = '';
        searchInput.value = '';
        loadMovies(true);
      });
    });

    // 영화 로드 함수
    function loadMovies(isNewSearch = false) {
      if (isNewSearch) {
        currentPage = 1;
        movieListContainer.innerHTML = '';
      }

      let url = '';
      if (currentSearchQuery) {
        url = `${BASE_URL}/search/movie?api_key=${API_KEY}&query=${encodeURIComponent(currentSearchQuery)}&language=ko-KR&page=${currentPage}`;
      } else {
        const endpoint = apiEndpoints[currentTab];
        url = `${BASE_URL}${endpoint}&api_key=${API_KEY}&language=ko-KR&page=${currentPage}`;
      }

      fetch(url)
              .then(response => response.json())
              .then(data => {
                const movies = data.results;
                if (isNewSearch) {
                  movieTotalCount.textContent = data.total_results || 0;
                }

                if (movies.length > 0) {
                  movieListContainer.insertAdjacentHTML('beforeend', createMovieHTML(movies));
                  moreBtnWrap.style.display = 'block';
                }

                if (!data.results || data.results.length < 20 || currentPage >= data.total_pages) {
                  moreBtnWrap.style.display = 'none';
                }

                addLikeButtonListeners('.like-btn');
              })
              .catch(error => console.error('Error fetching movies:', error));
    }

    // 영화 HTML 생성 함수
    function createMovieHTML(movies) {
      let html = !movieListContainer.hasChildNodes() ? '<div class="movie-list">' : '';
      movies.forEach(movie => {
        const isScheduled = currentTab === 'scheduled';
        html += `
                <div class="movie-item">
                    <a href="#" class="poster-link">
                        <img src="${movie.poster_path ? IMAGE_BASE_URL + movie.poster_path : 'https://via.placeholder.com/260x372.png/555555/FFFFFF?text=No+Image'}" alt="${movie.title}">
                    </a>
                    <div class="movie-info">
                        <h3>${movie.title}</h3>
                        <div class="movie-stats">
                            ${!isScheduled ? `<span>예매율 ${movie.vote_average.toFixed(1)}</span><span style="margin: 0 5px;">|</span>` : ''}
                            <span>개봉${isScheduled ? '예정' : ''}일 ${movie.release_date}</span>
                        </div>
                        <div class="movie-actions">
                            <button type="button" class="like-btn">
                                <span class="heart-icon"></span>
                                <span>${movie.vote_count}</span>
                            </button>
                             <a href="${isScheduled ? '#' : '../booking.jsp'}" class="reserve-btn" ${isScheduled ? 'style="background-color: #999; border-color: #999; cursor: not-allowed;"' : ''}>
                                ${isScheduled ? '개봉예정' : '예매'}
                            </a>
                        </div>
                    </div>
                </div>
            `;
      });
      if (!movieListContainer.hasChildNodes()) {
        html += '</div>';
      }
      return html;
    }

    // '좋아요' 버튼 이벤트 리스너
    function addLikeButtonListeners(selector) {
      document.querySelectorAll(selector).forEach(button => {
        if (button.dataset.eventAttached) return;
        button.addEventListener('click', function(e) {
          e.preventDefault();
          this.classList.toggle('liked');
        });
        button.dataset.eventAttached = 'true';
      });
    }

    // 더보기 버튼 이벤트
    moreBtn.addEventListener('click', function() {
      currentPage++;
      loadMovies();
    });

    // 검색 버튼 이벤트
    searchButton.addEventListener('click', () => {
      currentSearchQuery = searchInput.value.trim();
      if (currentSearchQuery) {
        loadMovies(true);
      }
    });

    searchInput.addEventListener('keyup', (event) => {
      if (event.key === 'Enter') {
        searchButton.click();
      }
    });

    // TOP 버튼 스크롤 이벤트
    window.addEventListener('scroll', () => {
      if (window.scrollY > 200) {
        topBtn.classList.add('visible');
      } else {
        topBtn.classList.remove('visible');
      }
    });

    // TOP 버튼 클릭 이벤트
    topBtn.addEventListener('click', () => {
      window.scrollTo({top: 0, behavior: 'smooth'});
    });


    // 초기 영화 목록 로드 (박스오피스)
    loadMovies(true);
  });
</script>
</body>
</html>