<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        table{
            width: 600px;
            border-collapse: collapse;
        }
        table th, table td{
            border: 1px solid #000;
            padding: 5px;
        }
        table caption{
            text-indent: -9999px;
            height: 0;
        }
    </style>
</head>
<body>
<header>
    <h1>영화목록</h1>
</header>
<article>
    <table>
        <caption>영화목록 테이블 (DB 출력 확인용)</caption>
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>시놉시스</th>
            <th>이미지</th>
            <th>개봉일</th>
            <th>인기도</th>
            <th>평균평점</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="vo" items="${requestScope.ar}" varStatus="vs">
            <tr>
                <td>${vo.movie_id}</td>
                <td>${vo.title}</td>
                <td>${vo.overview}</td> <%-- mybatis.vo.getName()과 같다 --%>
                <td><img src="${vo.poster_path}"/></td>
                <td>${vo.release_date}</td>
                <td>${vo.popularity}</td>
                <td>${vo.vote_average}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</article>
</body>
</html>