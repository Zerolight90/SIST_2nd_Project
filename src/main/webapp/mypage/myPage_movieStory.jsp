<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>나의 무비스토리</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
  <style>
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
          <%-- [수정] review.poster -> review.posterUrl --%>
        <img src="${pageContext.request.contextPath}/${review.posterUrl}" alt="${review.title}">
        <div class="review-content"><h4>${review.title}</h4><p>${review.comment}</p></div>
        <div class="review-actions"><a href="#">수정</a><a href="#">삭제</a></div>
      </div>
    </c:forEach>
  </div>
  <div data-tab-content="watched" class="tab-pane">
    <div class="movie-grid">
      <c:forEach var="movie" items="${watchedList}">
        <%-- [수정] movie.poster -> movie.posterUrl --%>
        <div class="movie-card"><img src="${pageContext.request.contextPath}/${movie.posterUrl}" alt="${movie.title}"><h4>${movie.title}</h4><button class="btn">관람평쓰기</button></div>
      </c:forEach>
    </div>
  </div>
  <div data-tab-content="wished" class="tab-pane">
    <div class="movie-grid">
      <c:forEach var="movie" items="${wishList}">
        <%-- [수정] movie.poster -> movie.posterUrl --%>
        <div class="movie-card"><img src="${pageContext.request.contextPath}/${movie.posterUrl}" alt="${movie.title}"><h4>${movie.title}</h4><button class="btn btn-primary">예매</button></div>
      </c:forEach>
    </div>
  </div>
</div>
</body>
</html>
