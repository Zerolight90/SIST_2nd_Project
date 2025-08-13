<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>나의 무비스토리</title>
  <link rel="stylesheet" href="${cp}/css/mypage.css">
</head>
<body>
<h2 class="content-title">나의 무비스토리</h2>

<%-- 탭 네비게이션: a 태그의 href를 직접 지정하여 페이지를 새로고침하는 방식으로 변경 --%>
<nav class="tab-nav">
  <a href="Controller?type=myMovieStory&tabName=review" class="${currentTab == 'review' ? 'active' : ''}">관람평</a>
  <a href="Controller?type=myMovieStory&tabName=watched" class="${currentTab == 'watched' ? 'active' : ''}">본 영화</a>
  <a href="Controller?type=myMovieStory&tabName=wished" class="${currentTab == 'wished' ? 'active' : ''}">위시리스트</a>
</nav>

<div class="tab-content">
  <%-- 1. 관람평 탭 --%>
  <c:if test="${currentTab == 'review'}">
    <div class="tab-pane active">
      <c:choose>
        <c:when test="${!empty reviewList}">
          <c:forEach var="review" items="${reviewList}">
            <div class="review-item">
                <%-- 포스터 경로는 외부 URL과 내부 경로를 모두 고려해야 함 --%>
              <c:set var="posterUrlResolved">
                <c:choose>
                  <c:when test="${review.posterUrl.startsWith('http')}">${review.posterUrl}</c:when>
                  <c:otherwise>${cp}/images/posters/${review.posterUrl}</c:otherwise>
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

  <%-- 2. 본 영화 탭 --%>
  <c:if test="${currentTab == 'watched'}">
    <div class="tab-pane active">
      <div class="movie-grid">
        <c:choose>
          <c:when test="${!empty movieList}">
            <c:forEach var="movie" items="${movieList}">
              <div class="movie-card">
                <a href="Controller?type=movieDetail&mIdx=${movie.mIdx}">
                  <c:set var="posterUrlResolved">
                    <c:choose>
                      <c:when test="${movie.posterUrl.startsWith('http')}">${movie.posterUrl}</c:when>
                      <c:otherwise>${cp}${movie.posterUrl}</c:otherwise> <%-- allmovie와 경로 통일 --%>
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
        <c:if test="${!empty paging && paging.startPage > 1}"><a href="Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.startPage - 1}">&lt;</a></c:if>
        <c:if test="${!empty paging}">
          <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
            <c:choose>
              <c:when test="${p == paging.nowPage}"><strong>${p}</strong></c:when>
              <c:otherwise><a href="Controller?type=myMovieStory&tabName=${currentTab}&cPage=${p}">${p}</a></c:otherwise>
            </c:choose>
          </c:forEach>
        </c:if>
        <c:if test="${!empty paging && paging.endPage < paging.totalPage}"><a href="Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.endPage + 1}">&gt;</a></c:if>
      </div>
    </div>
  </c:if>

  <%-- 3. 위시리스트 탭 --%>
  <c:if test="${currentTab == 'wished'}">
    <div class="tab-pane active">
      <div class="movie-grid">
        <c:choose>
          <c:when test="${!empty movieList}">
            <c:forEach var="movie" items="${movieList}">
              <div class="movie-card">
                <a href="Controller?type=movieDetail&mIdx=${movie.mIdx}">
                  <c:set var="posterUrlResolved">
                    <c:choose>
                      <c:when test="${movie.posterUrl.startsWith('http')}">${movie.posterUrl}</c:when>
                      <c:otherwise>${cp}${movie.posterUrl}</c:otherwise> <%-- allmovie와 경로 통일 --%>
                    </c:choose>
                  </c:set>
                  <img src="${posterUrlResolved}" alt="${movie.title}">
                </a>
                <h4>${movie.title}</h4>
                <a href="Controller?type=booking&mIdx=${movie.mIdx}" class="mybtn mybtn-primary">예매</a>
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
        <c:if test="${!empty paging && paging.startPage > 1}"><a href="Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.startPage - 1}">&lt;</a></c:if>
        <c:if test="${!empty paging}">
          <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
            <c:choose>
              <c:when test="${p == paging.nowPage}"><strong>${p}</strong></c:when>
              <c:otherwise><a href="Controller?type=myMovieStory&tabName=${currentTab}&cPage=${p}">${p}</a></c:otherwise>
            </c:choose>
          </c:forEach>
        </c:if>
        <c:if test="${!empty paging && paging.endPage < paging.totalPage}"><a href="Controller?type=myMovieStory&tabName=${currentTab}&cPage=${paging.endPage + 1}">&gt;</a></c:if>
      </div>
    </div>
  </c:if>
</div>


</body>
</html>