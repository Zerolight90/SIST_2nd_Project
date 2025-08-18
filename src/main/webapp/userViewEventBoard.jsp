<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/tab.css">
    <link rel="stylesheet" href="./css/theater.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <link rel="icon" href="./images/favicon.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

    <style>
        .page-title .event-detail-date {
            overflow: hidden;
            width: 1100px;
            margin: 0 auto 30px auto;
            padding: 15px 0 25px 0;
            line-height: 1.1;
            border-bottom: 1px solid #555;
        }


    </style>
</head>
<body>


<header>
    <jsp:include page="common/sub_menu.jsp"/>
</header>

<div>
    <div class="topBox">
        <div class="theaterTopBox">
            <div class="location">
                <span>Home</span>
                &nbsp;>&nbsp;
                <span>이벤트</span>
                >
                <a href="Controller?type=userBoardList">이벤트 상세</a>
            </div>
        </div>
    </div>

    <div class="inner-wrap">
        <div class="container">

            <div class="page-content-event">
                <c:if test="${requestScope.vo ne null}">
                    <c:set var="vo" value="${requestScope.vo}"/>
                </c:if>
                <!-- 상단 탭 -->
                <div class="page-title">
                    <h2 class="tit">${vo.boardTitle}</h2>
                    <p class="event-detail-date">
                        <span>기간</span>
                        <em>${vo.boardStartRegDate}~${vo.boardEndRegDate}</em>
                    </p>

                    <div>
                        ${vo.boardContent}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<footer>
    <jsp:include page="./common/Footer.jsp"/>
</footer>
</body>
</html>
