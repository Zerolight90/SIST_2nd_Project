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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>


    <style>

        .inner-wrap {
            position: relative;
            width: 1100px;
            margin: 0 auto;
        }

        .event-list{
            height: 365px;
        }

        .event-list ul li {
            position: relative;
            float: left;
            width: 245px;
            margin: 0 0 0 40px;
            padding: 0;
        }

        /*1,5,9,, 번째 게시물 margin:0 주기*/
        .event-list ul li:nth-child(4n + 1) {
            margin:0;
        }

        /*5번째 게시물부터 위 간격주기*/
        .event-list ul li:nth-child(n + 5) {
            margin-top: 60px;
        }

        .event-list ul li a {
            overflow: hidden;
            display: block;
            border: 1px solid #e4e4e4;
            border-radius: 10px;
            min-height: 364px;
        }
        .event-list ul li a .img {
            width: 100%;
            height: 244px;
            font-size: 0;
            line-height: 0;
            border-bottom: 1px solid #e4e4e4;
            background-color: #eee;
        }

        .event-list ul li a .img img {
            width: 100% !important;
            height: 243px !important;
        }

        .event-list ul li a .tit {
            overflow: hidden;
            height: 60px;
            margin: 0 0 10px 0;
            padding: 20px 17px 0 17px;
            line-height: 1.3;
            font-weight: 700;
            color: #222;
            display: block !important;
        }

        .event-list ul li a .date {
            padding: 0 17px 20px 17px;
            font-size: .8667em;
            line-height: 1.1;
            color: #666;
        }

        .event-list p {
            display: block;
            margin: 0;
            padding: 0;
        }

        a:link {
            color: #444;
            text-decoration: none;
        }

        a {
            background-color: transparent;
        }

        .notice-tab .tab-event{
            width: 25% !important;
        }

        .name{
            padding: 40px 0 20px 0;
            display: inline-block;
            font-size: 13px;
            font-size: 1.4666em;
            color: #503396;
        }

        .right{
            float: right;
            margin-top: 50px;
        }

        /*슬라이드**********************************************/
        .swiper-wrap .count {
            position: absolute; /* 슬라이더 위에 겹쳐서 표시 */
            right: 0;
            top: 0;
            z-index: 10; /* 다른 요소보다 위에 표시 */
            color: #fff; /* 글자색 흰색 */
            background-color: rgba(0, 0, 0, 0.5); /* 배경 반투명 검정 */
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 14px;
        }

        /* 여러 배너를 담는 컨테이너 */
        .banner-group {
            display: flex; /* 자식 요소를 가로로 정렬 */
            gap: 20px; /* 배너 사이 간격 */
        }

        /* 개별 배너 아이템 */
        .banner-item {
            flex-basis: 50%; /* 컨테이너 너비의 50%를 차지 */
        }

        /* 이미지에 맞게 크기 조절 */
        .banner-item img {
            width: 100%;
            height: auto;
            display: block;
        }

        /*게시물 정렬 맞추기*/
        .clearfix::after {
            content: "";
            display: table;
            clear: both;
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
                <a href="Controller?type=userEventBoardList">진행중인 이벤트</a>
            </div>
        </div>
    </div>

    <div class="inner-wrap">
        <div class="container">

            <div class="page-content" style="width: calc(100%);">
                <!-- 상단 탭 -->
                <div class="page-title">
                    <h2 class="tit">진행중인 이벤트</h2>
                </div>

                <div class="ec-base-tab typeLight notice-tab-wrap ">
                    <ul class="notice-tab menu">
                        <li class="tabBtn on selected tab-event"><a class="btn">전체</a></li>
                        <li class="tabBtn tab-event"><a class="btn" id="movie-tab-btn">영화</a></li>
                        <li class="tabBtn tab-event"><a class="btn" id="theater-tab-btn">극장</a></li>
                        <li class="tabBtn tab-event"><a class="btn" id="StageGreeting-tab-btn">시사회/무대인사</a></li>
                    </ul>
                </div>

                <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px">

                    <div class="inner-wrap" style="outline: 1px solid red;">



                        <div class="swiper-wrap" style="outline: 1px solid red; height: 375px;">
                            <p class="name" style="padding-top: 50px">추천 이벤트</p>
                            <div class="swiper mySwiper" style="height: 275px;">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <div class="banner-group">
                                            <div class="banner-item">
                                                <a href="링크1">
                                                    <img src="https://img.megabox.co.kr/SharedImg/event/2025/07/22/FfVWWnx0SUGb3bG2ApWIPAe94rP8cV7O.jpg" alt="이벤트 이미지1"/>
                                                </a>
                                            </div>
                                            <div class="banner-item">
                                                <a href="링크2">
                                                    <img src="https://img.megabox.co.kr/SharedImg/event/2024/11/26/8bZ1i8M4zwZyFKbnqfdtORk7ryTxOzCv.jpg" alt="이벤트 이미지2"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-slide">
                                        <div class="banner-group">
                                            <div class="banner-item">
                                                <a href="링크1">
                                                    <img src="https://img.megabox.co.kr/SharedImg/event/2025/07/22/FfVWWnx0SUGb3bG2ApWIPAe94rP8cV7O.jpg" alt="이벤트 이미지1"/>
                                                </a>
                                            </div>
                                            <div class="banner-item">
                                                <a href="링크2">
                                                    <img src="https://img.megabox.co.kr/SharedImg/event/2024/11/26/8bZ1i8M4zwZyFKbnqfdtORk7ryTxOzCv.jpg" alt="이벤트 이미지2"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="swiper-button-prev"></div>
                                <div class="swiper-button-next"></div>

                                <div class="swiper-pagination"></div>


                            </div>
                            <div class="count">
                                1 / 4
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <%--영화--%>
                        <p class="name">영화</p>
                        <div class="right">
                            <a onclick="showDetailTab(1); return false;" title="더보기">더보기></a>
                        </div>


                        <div class="event-list m15">
                            <ul>
                                <%--반복문--%>
                                <c:set var="movieCount" value="0"/>
                                <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1">
                                    <c:if test="${vo.sub_boardType eq 'movie' and movieCount < 4}">
                                        <li>
                                            <a href="Controller?type=userViewEventBoard&boardIdx=${vo.boardIdx}">
                                                <p class="img">
                                                    <img src="<c:url value='/event_thumbnails/${vo.thumbnail_url}'/>" alt="${vo.boardTitle}"/>
                                                </p>
                                                <p class="tit" style="font-size: 1.2em;">${vo.boardTitle}</p>
                                                <p class="date">${vo.boardStartRegDate} ~ ${vo.boardEndRegDate}</p>
                                            </a>
                                        </li>
                                        <c:set var="movieCount" value="${movieCount + 1}"/> <%-- 게시물 하나 표시 후 카운트 증가 --%>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <div class="container">
                        <%--극장--%>
                        <p class="name">극장</p>
                        <div class="right">
                            <a onclick="showDetailTab(2); return false;" title="더보기">더보기></a>
                        </div>

                        <div class="event-list m15">
                            <ul>
                                <c:set var="theaterCount" value="0"/>
                                <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1">
                                    <c:if test="${vo.sub_boardType eq 'theater' and theaterCount < 4}">
                                        <li>
                                            <a href="Controller?type=userViewEventBoard&boardIdx=${vo.boardIdx}">
                                                <p class="img">
                                                    <img src="<c:url value='/event_thumbnails/${vo.thumbnail_url}'/>" alt="${vo.boardTitle}"/>
                                                </p>
                                                <p class="tit" style="font-size: 1.2em;">${vo.boardTitle}</p>
                                                <p class="date">${vo.boardStartRegDate} ~ ${vo.boardEndRegDate}</p>
                                            </a>
                                        </li>
                                        <c:set var="theaterCount" value="${theaterCount + 1}"/> <%-- 게시물 하나 표시 후 카운트 증가 --%>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <div class="container">
                        <%--시사회/무대인사--%>
                        <p class="name">시사회/무대인사</p>
                        <div class="right">
                            <a onclick="showDetailTab(3); return false;" title="더보기">더보기></a>
                        </div>

                        <div class="event-list m15">
                            <ul>
                                <c:set var="stageGrettingCount" value="0"/>
                                <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1">
                                    <c:if test="${vo.sub_boardType eq 'stageGreeting' and stageGrettingCount < 4}">
                                        <li>
                                            <a href="Controller?type=userViewEventBoard&boardIdx=${vo.boardIdx}">
                                                <p class="img">
                                                    <img src="<c:url value='/event_thumbnails/${vo.thumbnail_url}'/>" alt="${vo.boardTitle}"/>
                                                </p>
                                                <p class="tit" style="font-size: 1.2em;">${vo.boardTitle}</p>
                                                <p class="date">${vo.boardStartRegDate} ~ ${vo.boardEndRegDate}</p>
                                            </a>
                                        </li>
                                        <c:set var="stageGrettingCount" value="${stageGrettingCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                </div>

                <%--영화탭--%>
                <div id="tabCont1_2" class="tabCont" style="display:none; margin-bottom: 50px">
                    <%--필터영역--%>
                    <div class="board-list-util">
                        <div class="result-count"><strong>전체 <em class="font-gblue">${totalCount}</em>건</strong></div>

                        <div class="board-search"   style="margin-left: auto;" >
                            <input type="text" id="searchTxtMega" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" value="" maxlength="15">
                            <button type="button" id="searchBtnMega" class="btn-search-input">검색</button>
                        </div>
                    </div>

                    <div class="event-list m15">
                        <ul class="clearfix">
                            <%--반복문--%>
                            <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1" >
                                <c:if test="${vo.sub_boardType eq 'movie'}">
                                    <li>
                                        <a href="Controller?type=userViewEventBoard&boardIdx=${vo.boardIdx}">
                                            <p class="img">
                                                <img src="<c:url value='/event_thumbnails/${vo.thumbnail_url}'/>" alt="${vo.boardTitle}"/>
                                            </p>
                                            <p class="tit" style="font-size: 1.2em;">${vo.boardTitle}</p>
                                            <p class="date">${vo.boardStartRegDate} ~ ${vo.boardEndRegDate}</p>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                </div>

                <%--극장탭--%>
                <div id="tabCont1_3" class="tabCont" style="display:none; margin-bottom: 50px">
                    <%--필터영역--%>
                    <div class="board-list-util">
                        <div class="result-count"><strong>전체 <em class="font-gblue">${totalCount}</em>건</strong></div>

                        <div class="board-search"   style="margin-left: auto;" >
                            <input type="text" id="searchTxtMega" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" value="" maxlength="15">
                            <button type="button" id="searchBtnMega" class="btn-search-input">검색</button>
                        </div>
                    </div>

                    <div class="event-list m15">
                        <ul class="clearfix">
                            <%--반복문--%>
                            <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1">
                                <c:if test="${vo.sub_boardType eq 'theater'}">
                                    <li>
                                        <a href="Controller?type=userViewEventBoard&boardIdx=${vo.boardIdx}">
                                            <p class="img">
                                                <img src="<c:url value='/event_thumbnails/${vo.thumbnail_url}'/>" alt="${vo.boardTitle}"/>
                                            </p>
                                            <p class="tit" style="font-size: 1.2em;">${vo.boardTitle}</p>
                                            <p class="date">${vo.boardStartRegDate} ~ ${vo.boardEndRegDate}</p>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <div id="tabCont1_4" class="tabCont" style="display:none; margin-bottom: 50px">
                    <%--필터영역--%>
                    <div class="board-list-util">
                        <div class="result-count"><strong>전체 <em class="font-gblue">${totalCount}</em>건</strong></div>

                        <div class="board-search"   style="margin-left: auto;" >
                            <input type="text" id="searchTxtMega" title="검색어를 입력해 주세요." placeholder="검색어를 입력해 주세요." class="input-text" value="" maxlength="15">
                            <button type="button" id="searchBtnMega" class="btn-search-input">검색</button>
                        </div>
                    </div>

                    <div class="event-list m15">
                        <ul class="clearfix">
                            <%--반복문--%>
                            <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1">
                                <c:if test="${vo.sub_boardType eq 'stageGreeting'}">
                                    <li>
                                        <a href="Controller?type=userViewEventBoard&boardIdx=${vo.boardIdx}">
                                            <p class="img">
                                                <img src="<c:url value='/event_thumbnails/${vo.thumbnail_url}'/>" alt="${vo.boardTitle}"/>
                                            </p>
                                            <p class="tit" style="font-size: 1.2em;">${vo.boardTitle}</p>
                                            <p class="date">${vo.boardStartRegDate} ~ ${vo.boardEndRegDate}</p>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



    <footer>
        <jsp:include page="common/Footer.jsp"/>
    </footer>
    <script src="js/main/slider.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script>

        const swiper = new Swiper('.mySwiper', {
            loop: true,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev'
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true
            },
            autoplay: {
                delay: 3000,
                disableOnInteraction: false // 사용자가 조작해도 자동재생 유지
            },
            on: {
                slideChange: function () {
                    const countElement = document.querySelector('.count');
                    if (countElement) {
                        countElement.textContent = `\${this.realIndex + 1} / \${this.slides.length - 2}`;
                    }
                }
            }
        });




        // 1. 모든 탭 버튼(li)과 내용 영역(div)을 가져옵니다.
        const tabs = document.querySelectorAll('.menu li');
        const tabContents = document.querySelectorAll('.tabCont');

        // 2. 각 탭 버튼에 클릭 이벤트 리스너를 추가합니다.
        tabs.forEach((tab, index) => {
            tab.addEventListener('click', (e) => {
                // a 태그의 기본 동작(페이지 이동)을 막습니다.
                e.preventDefault();

                // 3. 모든 탭에서 'selected' 클래스를 제거합니다.
                tabs.forEach(item => item.classList.remove('selected'));

                // 4. 방금 클릭한 탭에만 'selected' 클래스를 추가합니다.
                tab.classList.add('selected');

                // 5. 모든 내용 영역을 숨깁니다.
                tabContents.forEach(content => content.style.display = 'none');

                // 6. 클릭한 탭과 순서가 맞는 내용 영역만 보여줍니다.
                tabContents[index].style.display = 'block';
            });
        });

        // '더보기' 링크 클릭 시 '영화' 탭으로 이동하는 함수
        function showDetailTab(num) {
            if(num===1){
                document.getElementById('movie-tab-btn').click();
                //location.href="Controller?type=userEventBoardList&sub_boardType=movie";
            }else if(num===2){
                document.getElementById('theater-tab-btn').click();
            }else if(num===3){
                document.getElementById('StageGreeting-tab-btn').click();
            }
        }

    </script>

</body>
</html>
