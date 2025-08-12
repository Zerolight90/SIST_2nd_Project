<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2 class="content-title">나의 무비스토리</h2>

<div class="tab-nav" id="movieStoryTabNav">
  <a data-tab="review" class="${currentTab == 'review' ? 'active' : ''}" href="#">관람평</a>
  <a data-tab="watched" class="${currentTab == 'watched' ? 'active' : ''}" href="#">본 영화</a>
  <a data-tab="wished" class="${currentTab == 'wished' ? 'active' : ''}" href="#">위시리스트</a>
</div>

<div id="movieStoryTabContent">
  <div data-tab-content="review" class="tab-pane ${currentTab == 'review' ? 'active' : ''}">
  <div class="movie-grid">
      <c:choose>
        <c:when test="${not empty reviewList}">
          <c:forEach var="review" items="${reviewList}">
            <div class="review-item">
              <img src="${review.posterUrl}" alt="${review.title}">
              <div class="review-content"><h4>${review.title}</h4><p>${review.comment}</p></div>
              <div class="review-actions"><a href="#">수정</a><a href="#">삭제</a></div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise><p class="no-content">작성된 관람평이 없습니다.</p></c:otherwise>
      </c:choose>
    </div>
  </div>

  <div data-tab-content="watched" class="tab-pane ${currentTab == 'watched' ? 'active' : ''}">
  <div class="movie-grid">
      <c:choose>
        <c:when test="${not empty watchedList}">
          <c:forEach var="movie" items="${watchedList}">
            <div class="movie-card">
              <img src="${movie.posterUrl}" alt="${movie.title}">
              <h4>${movie.title}</h4>
              <button class="btn">관람평쓰기</button>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise><p class="no-content">시청한 영화가 없습니다.</p></c:otherwise>
      </c:choose>
    </div>
    <div class="pagination" id="watchedPagination">
      <c:if test="${watchedPaging.totalPage > 1}">
        <c:if test="${watchedPaging.startPage > 1}"><a href="#" data-page="${watchedPaging.startPage - 1}">&lt;</a></c:if>
        <c:forEach begin="${watchedPaging.startPage}" end="${watchedPaging.endPage}" var="p">
          <c:choose>
            <c:when test="${p == watchedPaging.nowPage}"><strong>${p}</strong></c:when>
            <c:otherwise><a href="#" data-page="${p}">${p}</a></c:otherwise>
          </c:choose>
        </c:forEach>
        <c:if test="${watchedPaging.endPage < watchedPaging.totalPage}"><a href="#" data-page="${watchedPaging.endPage + 1}">&gt;</a></c:if>
      </c:if>
    </div>
  </div>

  <div data-tab-content="wished" class="tab-pane ${currentTab == 'wished' ? 'active' : ''}">
  <div class="movie-grid">
      <c:choose>
        <c:when test="${not empty wishList}">
          <c:forEach var="movie" items="${wishList}">
            <div class="movie-item">
              <div class="movie-poster">
                <img src="${movie.posterUrl}" alt="${movie.title}">
                <button class="wish-button wished" data-midx="${movie.mIdx}"><i class="fa fa-heart-o"></i><i class="fa fa-heart"></i></button>
              </div>
              <h4>${movie.title}</h4>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise><p class="no-content">위시리스트에 담은 영화가 없습니다.</p></c:otherwise>
      </c:choose>
    </div>
    <div class="pagination" id="wishedPagination">
      <c:if test="${wishPaging.totalPage > 1}">
        <c:if test="${wishPaging.startPage > 1}"><a href="#" data-page="${wishPaging.startPage - 1}">&lt;</a></c:if>
        <c:forEach begin="${wishPaging.startPage}" end="${wishPaging.endPage}" var="p">
          <c:choose>
            <c:when test="${p == wishPaging.nowPage}"><strong>${p}</strong></c:when>
            <c:otherwise><a href="#" data-page="${p}">${p}</a></c:otherwise>
          </c:choose>
        </c:forEach>
        <c:if test="${wishPaging.endPage < wishPaging.totalPage}"><a href="#" data-page="${wishPaging.endPage + 1}">&gt;</a></c:if>
      </c:if>
    </div>
  </div>
</div>