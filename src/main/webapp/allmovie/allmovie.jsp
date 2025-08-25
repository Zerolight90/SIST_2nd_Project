<<<<<<< Updated upstream
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Set, org.json.simple.JSONArray" %>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
>>>>>>> Stashed changes
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<<<<<<< Updated upstream
    <title>전체영화 | SIST CINEMA</title>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/sub_page_style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/allmovie.css" />
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">
</head>
<body>
<jsp:include page="../common/sub_menu.jsp" />
<c:set var="basePath" value="${pageContext.request.contextPath}" />
=======
    <title>전체영화 | CINEFEEL</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/style.css" />
    <link rel="stylesheet" href="../css/sub/sub_page_style.css">
    <link rel="stylesheet" href="../css/allmovie.css">
</head>
<body>
<!-- Header -->
<jsp:include page="../common/sub_menu.jsp" />
>>>>>>> Stashed changes

<div id="container">
    <div class="content">
        <h2 class="title">전체영화</h2>

        <ul class="tabs">
<<<<<<< Updated upstream
            <li class="${currentCategory == 'boxoffice' ? 'active' : ''}"><a href="Controller?type=allMovie&category=boxoffice">박스오피스</a></li>
            <li class="${currentCategory == 'scheduled' ? 'active' : ''}"><a href="Controller?type=allMovie&category=scheduled">상영예정작</a></li>
            <li class="${currentCategory == 'filmsociety' ? 'active' : ''}"><a href="Controller?type=allMovie&category=filmsociety">필름소사이어티</a></li>
            <li class="${currentCategory == 'classicsociety' ? 'active' : ''}"><a href="Controller?type=allMovie&category=classicsociety">클래식소사이어티</a></li>
        </ul>

        <div class="movie-options">
            <div class="total-count">총 <strong>${totalCount}</strong>개의 영화가 검색되었습니다.</div>
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="영화명을 입력하세요">
                <button type="button" id="searchBtn"><i class="fa fa-search"></i></button>
            </div>
        </div>

        <div class="movie-list">
            <c:forEach var="movie" items="${movieList}">
                <div class="movie-item">
                    <a href="Controller?type=movieDetail&mIdx=${movie.mIdx}" class="poster-link">
                        <img src="${movie.poster}" alt="${movie.name} 포스터">
                        <div class="summary"><p>${movie.synop}</p></div>
                    </a>
                    <div class="movie-info">
                        <h3>
                            <c:choose>
                                <c:when test="${movie.age == '정보 없음'}">
                                    <span class="age-rating age-ALL">ALL</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="age-rating age-${movie.age}">${movie.age}</span>
                                </c:otherwise>
                            </c:choose>
                                ${movie.name}
                        </h3>
                        <div class="movie-stats">
                                <%-- 예매율(bookingRate)이 0보다 클 경우에만 표시 --%>
                            <c:if test="${movie.bookingRate > 0}">
                                <span>예매율 <fmt:formatNumber value="${movie.bookingRate}" pattern="#,##0.0"/>%</span>
                                <span style="color: #ddd; margin: 0 5px;">|</span>
                            </c:if>
                            <span>개봉일 ${movie.date}</span>
                        </div>
                        <div class="movie-actions">
                            <button type="button" class="like-btn ${!empty likedMovieSet && likedMovieSet.contains(movie.mIdx) ? 'liked' : ''}" data-midx="${movie.mIdx}">
                                <span class="heart-icon"></span>
                                <span class="like-count">${!empty likeCountMap[movie.mIdx] ? likeCountMap[movie.mIdx] : 0}</span>
                            </button>
                            <a href="Controller?type=booking&mIdx=${movie.mIdx}" class="reserve-btn">예매</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="pagination">
            <c:if test="${empty param.keyword}">
                <c:if test="${paging.startPage > 1}"><a href="Controller?type=allMovie&category=${currentCategory}&cPage=${paging.startPage - 1}">&lt;</a></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <c:choose>
                        <c:when test="${p == paging.nowPage}"><strong>${p}</strong></c:when>
                        <c:otherwise><a href="Controller?type=allMovie&category=${currentCategory}&cPage=${p}">${p}</a></c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${paging.endPage < paging.totalPage}"><a href="Controller?type=allMovie&category=${currentCategory}&cPage=${paging.endPage + 1}">&gt;</a></c:if>
            </c:if>
        </div>
    </div>
</div>
z`
<jsp:include page="../common/Footer.jsp" />

<script>
    $(function() {
        // --- 전역 변수 ---
        let currentKeyword = ""; // 현재 검색어를 저장하여 페이징 시 사용

        // --- 이벤트 핸들러 ---

        // 1. 검색 버튼 클릭 또는 Enter 키 입력
        $('#searchBtn').on('click', () => performSearch(1));
        $('#searchInput').on('keypress', e => { if (e.which === 13) performSearch(1); });

        // 2. 좋아요 버튼 클릭 (이벤트 위임)
        $('.movie-list').on('click', '.like-btn', handleLikeClick);

        // 3. 페이징 버튼 클릭 (이벤트 위임)
        $('.pagination').on('click', 'a', function(e) {
            e.preventDefault(); // 모든 페이지 링크의 기본 이동을 막습니다.

            // 검색어가 있으면 검색 페이징을, 없으면 카테고리 페이징을 수행합니다.
            if (currentKeyword) {
                performSearch($(this).data('page'));
            } else {
                location.href = $(this).attr('href'); // 검색어가 없으면 원래 링크로 이동
            }
        });

        // --- 함수 정의 ---

        // 검색 실행 함수
        function performSearch(page) {
            const keyword = $('#searchInput').val();
            if (keyword.trim() === "") {
                location.href = "Controller?type=allMovie"; // 검색창 비우고 검색 시 초기화
                return;
            }
            currentKeyword = keyword;

            $.ajax({
                url: "Controller?type=searchMovie",
                type: "POST",
                data: { keyword: keyword, cPage: page || 1 },
                dataType: "json",
                success: updateMovieView, // 성공 시 화면 업데이트 함수 호출
                error: () => alert("검색 중 오류가 발생했습니다.")
            });
        }

        // 좋아요 클릭 처리 함수
        function handleLikeClick(e) {
            e.preventDefault();
            e.stopPropagation();

            if ("${empty sessionScope.mvo}" === "true") {
                alert("로그인이 필요한 서비스입니다.");
                location.href = "Controller?type=login";
                return;
            }

            const likeBtn = $(this);
            const mIdx = likeBtn.data('midx');

            $.ajax({
                url: "Controller?type=addWishlist", // 추가와 삭제를 모두 이 URL에서 처리
                type: "POST", data: { "mIdx": mIdx }, dataType: "json",
                success: function(res) {
                    if (res.status === "success") {
                        likeBtn.find('.like-count').text(res.newLikeCount);
                        likeBtn.toggleClass('liked'); // 'liked' 클래스를 추가하거나 제거
                    } else {
                        alert("오류: " + res.message);
                    }
                },
                error: () => alert("서버와 통신 중 문제가 발생했습니다.")
            });
        }

        // 화면 업데이트 함수 (검색 결과용)
        function updateMovieView(data) {
            const movieListEl = $('.movie-list');
            const paginationEl = $('.pagination');

            movieListEl.empty();
            paginationEl.empty();
            $('.total-count strong').text(data.totalCount);
            $('.tabs li').removeClass('active'); // 검색 시에는 탭 활성화 해제

            if (data.movieList && data.movieList.length > 0) {
                const likedMovieSet = new Set(data.likedMovieSet || []);
                const likeCountMap = data.likeCountMap || {};

                $.each(data.movieList, function(i, movie) {
                    const likedClass = likedMovieSet.has(String(movie.mIdx)) ? 'liked' : '';
                    const likeCount = likeCountMap[movie.mIdx] || 0;
                    const movieHtml = `
                        <div class="movie-item">
                            <a href="Controller?type=movieDetail&mIdx=\${movie.mIdx}" class="poster-link">
                                <img src="\${movie.poster}" alt="\${movie.name} 포스터">
                                <div class="summary"><p>\${movie.synop || ''}</p></div>
                            </a>
                            <div class="movie-info">
                                <h3><span class="age-rating age-\${movie.age}">\${movie.age}</span> \${movie.name}</h3>
                                <div class="movie-stats"><span>개봉일 \${movie.date}</span></div>
                                <div class="movie-actions">
                                    <button type="button" class="like-btn \${likedClass}" data-midx="\${movie.mIdx}">
                                        <span class="heart-icon"></span>
                                        <span class="like-count">\${likeCount}</span>
                                    </button>
                                    <a href="Controller?type=booking&mIdx=\${movie.mIdx}" class="reserve-btn">예매</a>
                                </div>
                            </div>
                        </div>`;
                    movieListEl.append(movieHtml);
                });
            } else {
                movieListEl.html("<p style='text-align:center; padding: 50px; width:100%;'>검색된 영화가 없습니다.</p>");
            }

            const p = data.paging;
            if (p.startPage > 1) paginationEl.append(`<a href="#" data-page="\${p.startPage - 1}">&lt;</a>`);
            for (let i = p.startPage; i <= p.endPage; i++) {
                if (i === p.nowPage) {
                    paginationEl.append(`<strong>\${i}</strong>`);
                } else {
                    // 검색 결과 페이징 링크에는 일반 href 대신 data-page 속성을 사용
                    paginationEl.append(`<a href="#" data-page="\${i}">\${i}</a>`);
                }
            }
            if (p.endPage < p.totalPage) paginationEl.append(`<a href="#" data-page="\${p.endPage + 1}">&gt;</a>`);
        }
    });
</script>

</body>
</html>
=======
            <li class="active" data-tab="boxoffice">박스오피스</li>
            <li data-tab="scheduled">상영예정작</li>
            <li data-tab="sistonly">SIST ONLY</li>
            <li data-tab="filmsociety">필름소사이어티</li>
            <li data-tab="classicsociety">클래식소사이어티</li>
        </ul>

        <div class="movie-options">
            <div class="total-count">
                총 <strong>60</strong>개의 영화가 검색되었습니다.
            </div>
            <div class="search-box">
                <input type="text" placeholder="영화명 검색">
                <button type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
        </div>

        <div id="boxoffice" class="tab-content active">
            <jsp:include page="allmovie_boxoffice.jsp" />
        </div>
        <div id="scheduled" class="tab-content">
            <jsp:include page="allmovie_scheduled.jsp" />
        </div>
        <div id="sistonly" class="tab-content">
            <jsp:include page="allmovie_sistonly.jsp" />
        </div>
        <div id="filmsociety" class="tab-content">
            <jsp:include page="allmovie_filmsociety.jsp" />
        </div>
        <div id="classicsociety" class="tab-content">
            <jsp:include page="allmovie_classicsociety.jsp" />
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="../common/Footer.jsp" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tabs = document.querySelectorAll('.tabs li');
        const tabContents = document.querySelectorAll('.tab-content');

        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                tabs.forEach(item => item.classList.remove('active'));
                tabContents.forEach(content => content.classList.remove('active'));

                tab.classList.add('active');
                const tabId = tab.getAttribute('data-tab');
                if(document.getElementById(tabId)) {
                    document.getElementById(tabId).classList.add('active');
                }
            });
        });
    });
</script>
</body>
</html>
>>>>>>> Stashed changes
