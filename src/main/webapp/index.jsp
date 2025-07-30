<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <link rel="icon" href="./images/favicon.png">
</head>
<body>
<header>
   <jsp:include page="jsp/menu.jsp"/>
</header>

<article>
    <div id="content">
        박스 오피스 영역
    </div>

    <div id="boon">
        혜택
    </div>

    <div id="Curation">
        큐레이션
    </div>

    <div id="imformation">
        쌍용박스 안내
    </div>
</article>

<jsp:include page="jsp/Footer.jsp"/>

</body>

</html>