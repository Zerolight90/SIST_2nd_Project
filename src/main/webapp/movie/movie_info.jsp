<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sub/sub_page_style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tab.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie_info/movie_info.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">
</head>

<header>
    <jsp:include page="/common/sub_menu.jsp"/>
</header>
<body>

<div>

    <div class="topBox">
        <div class="theaterTopBox">
            <div class="location">
                <span>Home</span>
                &nbsp;>&nbsp;
                <span>극장</span>
                >
                <a href="Controller?type=allTheater">전체극장</a>
            </div>
        </div>
    </div>

    <!-- 영화 메인 포스터 영역 -->
    <section class="movie-hero">
        <div class="movie-info">
            <h2>극장판 귀멸의 칼날: 무한성편</h2>
            <p>Demon Slayer: Kimetsu No Yaiba Infinity Castle Arc</p>
            <p class="stats">예매율 73.8% | 누적관객수 23,632명</p>
            <button class="btn">예매하기</button>
        </div>
        <div class="movie-poster">
            <img src="poster.jpg" alt="귀멸의 칼날 포스터">
        </div>
    </section>

    <%--컨텐츠 시작--%>
    <div class="inner-wrap">
        <div class="ec-base-tab typeLight m50">
            <ul class="menu" style="font-size: 16px;">
                <li class="selected"><a href="#none">주요정보</a></li>
                <li><a href="#none">실관람평</a></li>
                <li><a href="#none">예고편</a></li>
            </ul>
        </div>
        <!-- 비동기식 페이지 전환 : 라인형-->
        <div class="ec-base-tab typeLight eTab">

            <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px">

            </div>

            <%--2 상영시간표 탭--%>
            <div id="tabCont1_2" class="tabCont" style="display:none; width: 1100px">


            </div>

            <%--3 영화관람료 탭--%>
            <div id="tabCont1_3" class="tabCont" style="display:none; width: 1100px">

            </div>
        </div>
    </div>
</div>

 <script>
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

        $(function () {
        $(".tabCont").click(function () {
            var tab_id = $(this).attr("data-tab");

            $(".tabCont").style.display = 'none';
            $(".menu>li").removeClass("selected");

            $(this).addClass("active");
            $("#" + tab_id).addClass("active");
        });
    });

        function collapse(element) {
            var before = document.getElementsByClassName("active")[0]               // 기존에 활성화된 버튼
            if (before && document.getElementsByClassName("active")[0] != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
                before.nextElementSibling.style.maxHeight = null;   // 기존에 펼쳐진 내용 접고
                before.classList.remove("active");                  // 버튼 비활성화
            }
            element.classList.toggle("active");         // 활성화 여부 toggle

            var content = element.nextElementSibling;
            if (content.style.maxHeight != 0) {         // 버튼 다음 요소가 펼쳐져 있으면
                content.style.maxHeight = null;         // 접기
            } else {
                content.style.maxHeight = content.scrollHeight + "px";  // 접혀있는 경우 펼치기
            }
        }
</script>

</body>

<jsp:include page="/common/Footer.jsp"/>
</html>
