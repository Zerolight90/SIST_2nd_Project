<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전체영화 | SIST CINEMA</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/sub_page_style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/allmovie.css" />
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">

    <style>
        .tabs li a { display: block; text-decoration: none; color: inherit; }

        /* 페이징 UI 스타일 */
        .pagination { text-align: center; margin-top: 40px; }
        .pagination a, .pagination strong {
            display: inline-block;
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #333;
            border-radius: 4px;
        }
        .pagination strong {
            background-color: #503396;
            color: #fff;
            border-color: #503396;
        }

        /* 연령 등급 뱃지 스타일 */
        .age-rating {
            display: inline-block;
            width: 24px;
            height: 24px;
            border-radius: 4px;
            color: #fff;
            font-size: 13px;
            font-weight: bold;
            text-align: center;
            line-height: 24px;
            margin-right: 6px;
            vertical-align: middle;
            background-color: #888;
        }
        .age-rating.age-ALL { background-color: #3aa342; }
        .age-rating.age-12 { background-color: #f5ad00; }
        .age-rating.age-15 { background-color: #e88400; }
        .age-rating.age-19 { background-color: #d8232a; }

    </style>
</head>
<body>
<jsp:include page="../common/sub_menu.jsp" />
<c:set var="basePath" value="${pageContext.request.contextPath}" />

<div id="container">
    <div class="content">
        <h2 class="title">전체영화</h2>

        <ul class="tabs">
            <li class="${currentCategory == 'boxoffice' ? 'active' : ''}"><a href="Controller?type=allMovie&category=boxoffice">박스오피스</a></li>
            <li class="${currentCategory == 'scheduled' ? 'active' : ''}"><a href="Controller?type=allMovie&category=scheduled">상영예정작</a></li>
            <li class="${currentCategory == 'sistory' ? 'active' : ''}"><a href="Controller?type=allMovie&category=sistory">SIST ONLY</a></li>
            <li class="${currentCategory == 'filmsociety' ? 'active' : ''}"><a href="Controller?type=allMovie&category=filmsociety">필름소사이어티</a></li>
            <li class="${currentCategory == 'classicsociety' ? 'active' : ''}"><a href="Controller?type=allMovie&category=classicsociety">클래식소사이어티</a></li>
        </ul>

        <div class="movie-options">
            <div class="total-count">총 <strong>${totalCount}</strong>개의 영화가 검색되었습니다.</div>
        </div>

        <div class="movie-list">
            <c:forEach var="movie" items="${movieList}" varStatus="status">
                <div class="movie-item">
                    <a href="Controller?type=movieDetail&mIdx=${movie.mIdx}" class="poster-link">
                        <img src="${movie.poster}" alt="${movie.name} 포스터">
                    </a>
                    <div class="movie-info">
                        <h3><span class="age-rating age-${movie.age}">${movie.age}</span> ${movie.name}</h3>
                        <div class="movie-stats"><span>개봉일 ${movie.date}</span></div>
                        <div class="movie-actions">
                            <button type="button" class="like-btn">♡ 0</button>
                            <a href="Controller?type=booking&mIdx=${movie.mIdx}" class="reserve-btn">예매</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="pagination">
            <c:if test="${paging.startPage > 1}">
                <a href="Controller?type=allMovie&category=${currentCategory}&cPage=${paging.startPage - 1}">&lt;</a>
            </c:if>

            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                <c:choose>
                    <c:when test="${p == paging.nowPage}">
                        <strong>${p}</strong>
                    </c:when>
                    <c:otherwise>
                        <a href="Controller?type=allMovie&category=${currentCategory}&cPage=${p}">${p}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${paging.endPage < paging.totalPage}">
                <a href="Controller?type=allMovie&category=${currentCategory}&cPage=${paging.endPage + 1}">&gt;</a>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="../common/Footer.jsp" />

</body>
</html>