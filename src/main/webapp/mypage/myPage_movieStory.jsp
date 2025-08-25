<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< Updated upstream
<c:set var="cp" value="${pageContext.request.contextPath}" />
=======
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap" %>
<%
  Map<String, String> review1 = new HashMap<>();
  review1.put("poster", "https://placehold.co/80x120/222/fff?text=Hitman2");
  review1.put("title", "히트맨 2");
  review1.put("comment", "재미가 있다. 전편보다 나은 속편!");
  List<Map<String, String>> reviewList = new ArrayList<>();
  reviewList.add(review1);
  request.setAttribute("reviewList", reviewList);

  Map<String, String> watched1 = new HashMap<>();
  watched1.put("poster", "https://placehold.co/160x240/e81c23/fff?text=Captain");
  watched1.put("title", "캡틴 아메리카: 브레이브 뉴 월드");
  List<Map<String, String>> watchedList = new ArrayList<>();
  watchedList.add(watched1);
  request.setAttribute("watchedList", watchedList);

  Map<String, String> wish1 = new HashMap<>();
  wish1.put("poster", "https://placehold.co/160x240/1a73e8/fff?text=Dune");
  wish1.put("title", "듄: 파트 2");
  List<Map<String, String>> wishList = new ArrayList<>();
  wishList.add(wish1);
  request.setAttribute("wishList", wishList);
%>
>>>>>>> Stashed changes
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>나의 무비스토리</title>
<<<<<<< Updated upstream
  <link rel="stylesheet" href="${cp}/css/mypage.css">
</head>
<body>
<h2 class="content-title">나의 무비스토리</h2>

<%-- 탭 네비게이션 --%>
<nav class="tab-nav">
  <a href="${cp}/Controller?type=myMovieStory&tabName=review" class="${currentTab == 'review' ? 'active' : ''}">관람평</a>
  <a href="${cp}/Controller?type=myMovieStory&tabName=watched" class="${currentTab == 'watched' ? 'active' : ''}">본 영화</a>
  <a href="${cp}/Controller?type=myMovieStory&tabName=wished" class="${currentTab == 'wished' ? 'active' : ''}">위시리스트</a>
</nav>

<div class="tab-content">
  <%-- ==================== 1. 관람평 탭 ==================== --%>
  <c:if test="${currentTab == 'review'}">
    <div class="tab-pane active">
      <c:choose>
        <c:when test="${!empty reviewList}">
          <c:forEach var="review" items="${reviewList}">
            <div class="review-item">
                <%-- 포스터 경로 처리 --%>
              <c:set var="posterUrlResolved">
                <c:choose>
                  <c:when test="${review.posterUrl.startsWith('http')}">${review.posterUrl}</c:when>
                  <c:otherwise>${cp}${review.posterUrl}</c:otherwise>
                </c:choose>
              </c:set>
              <img src="${posterUrlResolved}" alt="${review.title}" style="width:80px; height:auto; object-fit:cover;"/>
              <div class="review-content">
                <h4>${review.title}</h4>
                <p>${review.comment}</p>
              </div>
              <div class="review-actions"><a href="#">수정</a><a href="#">삭제</a></div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="no-content" style="text-align: center; padding: 80px 20px; color: #888;">작성한 관람평이 없습니다.</div>
        </c:otherwise>
      </c:choose>
    </div>
  </c:if>

  <%-- ==================== 2. 본 영화 탭 ==================== --%>
  <c:if test="${currentTab == 'watched'}">
    <div class="tab-pane active">
      <div class="movie-grid">
        <c:choose>
          <c:when test="${!empty movieList}">
            <c:forEach var="movie" items="${movieList}">
              <div class="movie-card">
                <a href="${cp}/Controller?type=movieDetail&mIdx=${movie.mIdx}">
                    <%-- 포스터 경로 처리 --%>
                  <c:set var="posterUrlResolved">
                    <c:choose>
                      <c:when test="${movie.posterUrl.startsWith('http')}">${movie.posterUrl}</c:when>
                      <c:otherwise>${cp}${movie.posterUrl}</c:otherwise>
                    </c:choose>
                  </c:set>
                  <img src="${posterUrlResolved}" alt="${movie.title}">
                </a>
                <h4>${movie.title}</h4>
                <button class="mybtn">관람평쓰기</button>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="no-content" style="text-align: center; padding: 80px 20px; color: #888; grid-column: 1 / -1;">관람한 영화가 없습니다.</p>
          </c:otherwise>
        </c:choose>
      </div>
        <%-- 페이징 UI --%>
      <div class="pagination">
        <c:if test="${!empty paging && paging.startPage > 1}"><a href="${cp}/Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.startPage - 1}">&lt;</a></c:if>
        <c:if test="${!empty paging}">
          <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
            <c:choose>
              <c:when test="${p == paging.nowPage}"><strong>${p}</strong></c:when>
              <c:otherwise><a href="${cp}/Controller?type=myMovieStory&tabName=${currentTab}&cPage=${p}">${p}</a></c:otherwise>
            </c:choose>
          </c:forEach>
        </c:if>
        <c:if test="${!empty paging && paging.endPage < paging.totalPage}"><a href="${cp}/Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.endPage + 1}">&gt;</a></c:if>
      </div>
    </div>
  </c:if>

  <%-- ==================== 3. 위시리스트 탭 ==================== --%>
  <c:if test="${currentTab == 'wished'}">
    <div class="tab-pane active">
      <div class="movie-grid">
        <c:choose>
          <c:when test="${!empty movieList}">
            <c:forEach var="movie" items="${movieList}">
              <div class="movie-card">
                <a href="${cp}/Controller?type=movieDetail&mIdx=${movie.mIdx}">
                    <%-- 포스터 경로 처리 --%>
                  <c:set var="posterUrlResolved">
                    <c:choose>
                      <c:when test="${movie.posterUrl.startsWith('http')}">${movie.posterUrl}</c:when>
                      <c:otherwise>${cp}${movie.posterUrl}</c:otherwise>
                    </c:choose>
                  </c:set>
                  <img src="${posterUrlResolved}" alt="${movie.title}">
                </a>
                <h4>${movie.title}</h4>
                <a href="${cp}/Controller?type=booking&mIdx=${movie.mIdx}" class="mybtn mybtn-primary">예매</a>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="no-content" style="text-align: center; padding: 80px 20px; color: #888; grid-column: 1 / -1;">찜한 영화가 없습니다.</p>
          </c:otherwise>
        </c:choose>
      </div>
        <%-- 페이징 UI --%>
      <div class="pagination">
        <c:if test="${!empty paging && paging.startPage > 1}"><a href="${cp}/Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.startPage - 1}">&lt;</a></c:if>
        <c:if test="${!empty paging}">
          <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
            <c:choose>
              <c:when test="${p == paging.nowPage}"><strong>${p}</strong></c:when>
              <c:otherwise><a href="${cp}/Controller?type=myMovieStory&tabName=${currentTab}&cPage=${p}">${p}</a></c:otherwise>
            </c:choose>
          </c:forEach>
        </c:if>
        <c:if test="${!empty paging && paging.endPage < paging.totalPage}"><a href="${cp}/Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.endPage + 1}">&gt;</a></c:if>
      </div>
    </div>
  </c:if>
</div>

</body>
</html>
=======
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
  <style>
    /* 탭 디자인을 위한 추가 스타일 */
    .tab-nav { justify-content: center; }
    .tab-nav a { flex-grow: 1; text-align: center; padding: 15px 20px; font-size: 16px; }
    .no-content { text-align: center; padding: 80px 20px; color: #888; }
  </style>
</head>
<body>
<h2 class="content-title">나의 무비스토리</h2>
<nav class="tab-nav" id="movieStoryTabNav">
  <a data-tab="review" class="active" href="#">관람평</a>
  <a data-tab="watched" href="#">본 영화</a>
  <a data-tab="wished" href="#">위시리스트</a>
</nav>
<div id="movieStoryTabContent">
  <div data-tab-content="review" class="tab-pane active">
    <c:forEach var="review" items="${reviewList}">
      <div class="review-item">
        <img src="${review.poster}" alt="${review.title}">
        <div class="review-content"><h4>${review.title}</h4><p>${review.comment}</p></div>
        <div class="review-actions"><a href="#">수정</a><a href="#">삭제</a></div>
      </div>
    </c:forEach>
  </div>
  <div data-tab-content="watched" class="tab-pane">
    <div class="movie-grid">
      <c:forEach var="movie" items="${watchedList}">
        <div class="movie-card"><img src="${movie.poster}" alt="${movie.title}"><h4>${movie.title}</h4><button class="btn">관람평쓰기</button></div>
      </c:forEach>
    </div>
  </div>
  <div data-tab-content="wished" class="tab-pane">
    <div class="movie-grid">
      <c:forEach var="movie" items="${wishList}">
        <div class="movie-card"><img src="${movie.poster}" alt="${movie.title}"><h4>${movie.title}</h4><button class="btn btn-primary">예매</button></div>
      </c:forEach>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const tabLinks = document.querySelectorAll('#movieStoryTabNav a');
    const tabPanes = document.querySelectorAll('#movieStoryTabContent .tab-pane');

    tabLinks.forEach(function(link) {
      link.addEventListener('click', function(event) {
        event.preventDefault();
        const targetTab = this.getAttribute('data-tab');

        tabLinks.forEach(innerLink => innerLink.classList.remove('active'));
        this.classList.add('active');

        tabPanes.forEach(pane => {
          // 클릭된 탭에 해당하는 컨텐츠만 active 클래스를 추가하고, 나머지는 제거
          if (pane.getAttribute('data-tab-content') === targetTab) {
            pane.classList.add('active');
          } else {
            pane.classList.remove('active');
          }
        });
      });
    });
  });
</script>
</body>
</html>
>>>>>>> Stashed changes
