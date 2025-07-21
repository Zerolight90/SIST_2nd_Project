<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./CSS/style.css">
    <link rel="stylesheet" href="./CSS/reset.css">
</head>
<body>
<header>
    <h1><%= "SIST BOX" %></h1>
    <nav> 메뉴바</nav>
</header>
<br/>
<article>
    <div id="content">
        박스 오피스 영역
    </div>

    <div id="boon">
        헤택
    </div>

    <div id="Curation">
        큐레이션
    </div>

    <div id="imformation">
        메가박스 안내
    </div>
</article>



<jsp:include page="JSP/Footer.jsp"/>

</body>

</html>