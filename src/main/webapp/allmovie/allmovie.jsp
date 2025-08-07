<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전체영화 | CINEFEEL</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <link rel="stylesheet" href="${cp}/css/reset.css" />
    <link rel="stylesheet" href="${cp}/css/style.css" />
    <link rel="stylesheet" href="${cp}/css/sub/sub_page_style.css">
    <link rel="stylesheet" href="${cp}/css/allmovie.css">
    <style>
        .top-btn { position: fixed; bottom: 30px; right: 30px; width: 50px; height: 50px; background-color: #333; color: #fff; border: none; border-radius: 50%; cursor: pointer; opacity: 0; visibility: hidden; transition: opacity 0.3s, visibility 0.3s; z-index: 1000; display: flex; justify-content: center; align-items: center; flex-direction: column; font-size: 12px; }
        .top-btn.visible { opacity: 1; visibility: visible; }
        .top-btn i { font-size: 16px; margin-bottom: 2px; }
        .no-results { text-align: center; padding: 50px; font-size: 16px; color: #888; }
        .reserve-btn.disabled { background-color: #999; border-color: #999; cursor: not-allowed; }
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
            <li data-tab="sistonly">SIST ONLY</li>
            <li data-tab="filmsociety">필름소사이어티</li>
            <li data-tab="classicsociety">클래식소사이어티</li>
        </ul>
        <div class="movie-options">
            <div class="total-count">총 <strong id="movie-total-count">0</strong>개의 영화가 검색되었습니다.</div>
            <div class="search-box">
                <input type="text" id="search-input" placeholder="영화명 검색">
                <button type="button" id="search-button"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
        </div>
        <div id="movie-list-container"></div>
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

        const contextPath = "${cp}";
        const IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w500';

        let currentPage = 1;
        let currentTab = 'boxoffice';
        let currentSearchQuery = '';

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

        function loadMovies(isNewSearch = false) {
            if (isNewSearch) {
                currentPage = 1;
                movieListContainer.innerHTML = '<p class="no-results">영화를 불러오는 중...</p>';
            }

            let url = `${contextPath}/Controller?type=allMovieData&tab=${currentTab}&page=${currentPage}`;
            if (currentSearchQuery) {
                url += `&query=${encodeURIComponent(currentSearchQuery)}`;
            }

            fetch(url)
                .then(response => {
                    if (!response.ok) throw new Error('Server returned an error');
                    return response.json();
                })
                .then(data => {
                    // ▼▼▼ 여기에 디버깅용 console.log 추가 ▼▼▼
                    console.log("서버로부터 받은 전체 데이터:", data); // 1. 서버가 준 데이터 전체를 확인

                    const movies = data.results;
                    console.log("추출된 영화 목록 (movies):", movies); // 2. 영화 목록 배열(results)을 확인
                    console.log("영화 개수:", movies ? movies.length : 0); // 3. 영화 개수를 확인

                    if (isNewSearch) {
                        movieListContainer.innerHTML = '';
                        movieTotalCount.textContent = data.total_results || 0;
                    }

                    if (movies && movies.length > 0) {
                        console.log("✅ 영화 목록을 화면에 추가합니다..."); // 4. 이 메시지가 보이면 화면이 그려져야 함
                        movieListContainer.insertAdjacentHTML('beforeend', createMovieHTML(movies));
                        moreBtnWrap.style.display = 'block';
                    } else if (isNewSearch) {
                        movieListContainer.innerHTML = '<p class="no-results">검색된 영화가 없습니다.</p>';
                    }

                    if (!data.results || data.results.length < 20 || currentPage >= data.total_pages) {
                        moreBtnWrap.style.display = 'none';
                    }
                })
                .catch(error => {
                    console.error('Error fetching movies from server:', error);
                    movieListContainer.innerHTML = '<p class="no-results">영화를 불러오는 중 오류가 발생했습니다.</p>';
                });
        }

        function createMovieHTML(movies) {
            let html = '';
            movies.forEach(movie => {
                const isScheduled = currentTab === 'scheduled';
                const reserveLink = isScheduled ? '#' : contextPath + '/Controller?type=booking&movieId=' + movie.id;
                const reserveBtnClass = isScheduled ? 'reserve-btn disabled' : 'reserve-btn';
                const reserveBtnText = isScheduled ? '개봉예정' : '예매';
                const releaseDate = movie.release_date ? movie.release_date : '미정';

                html += '<div class="movie-item">' +
                    '<a href="' + contextPath + '/Controller?type=movieDetail&movieId=' + movie.id + '" class="poster-link">' +
                    '<img src="' + (movie.poster_path ? IMAGE_BASE_URL + movie.poster_path : 'https://via.placeholder.com/260x372.png/555555/FFFFFF?text=No+Image') + '" alt="' + movie.title + '">' +
                    '</a>' +
                    '<div class="movie-info">' +
                    '<h3>' + movie.title + '</h3>' +
                    '<div class="movie-stats">';

                if (!isScheduled) {
                    html += '<span>예매율 ' + movie.vote_average.toFixed(1) + '</span><span style="margin: 0 5px;">|</span>';
                }

                html += '<span>개봉' + (isScheduled ? '예정' : '') + '일 ' + releaseDate + '</span>' +
                    '</div>' +
                    '<div class="movie-actions">' +
                    '<button type="button" class="like-btn" data-movie-id="' + movie.id + '">' +
                    '<span class="heart-icon"></span>' +
                    '<span>' + movie.vote_count + '</span>' +
                    '</button>' +
                    '<a href="' + reserveLink + '" class="' + reserveBtnClass + '">' + reserveBtnText + '</a>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            });
            return html;
        }

        function addLikeButtonListeners(selector) {
            // ... '좋아요' 기능 ...
        }

        moreBtn.addEventListener('click', () => { currentPage++; loadMovies(); });
        searchButton.addEventListener('click', () => { currentSearchQuery = searchInput.value.trim(); if (currentSearchQuery) loadMovies(true); });
        searchInput.addEventListener('keyup', e => { if (e.key === 'Enter') searchButton.click(); });
        window.addEventListener('scroll', () => { topBtn.classList.toggle('visible', window.scrollY > 200); });
        topBtn.addEventListener('click', () => { window.scrollTo({top: 0, behavior: 'smooth'}); });

        loadMovies(true);
    });
</script>
</body>
</html>