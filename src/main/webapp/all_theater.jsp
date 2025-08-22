<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="./css/theater.css">
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/tab.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="./images/favicon.png">
</head>

<body>
<header>
    <jsp:include page="common/sub_menu.jsp"/>
</header>

<article>
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

    <!--극장 영역-->
    <div id="theaterInfo">

        <div class="inner-wrap">
            <!--전체 극장 리스트 영역-->
            <h1 class="all-theater m70">전체극장</h1>
            <div class="all-theater-box">
                <div class="ec-base-tab typeLight theater-wrapper m50 ">

                    <!-- 지역 탭 -->
                    <ul class="region-tabs menu">
                        <c:set var="regionArr" value="${requestScope.regionArr}" />
                        <c:forEach var="tvo_region" items="${regionArr}" varStatus="i">
                            <li class="${i.index == 0 ? 'active on selected' : ''}">
                                <a class="area_mv" data-region="${tvo_region.tRegion}">${tvo_region.tRegion}</a>
                            </li>
                        </c:forEach>
                    </ul>

                    <!-- 지역별 극장 컨텐츠 -->
                    <div class="theater-content-wrapper">
                        <c:set var="tvoArr" value="${requestScope.tvo}" />

                        <!-- 각 지역별로 탭 컨텐츠 생성 -->
                        <c:forEach var="tvo_region" items="${regionArr}" varStatus="regionIndex">
                        <div id="tabCont_${tvo_region.tRegion}" class="tabCont" style="${regionIndex.index == 0 ? 'display:block' : 'display:none'}; margin-bottom: 50px">
                            <div class="theater-list">
                                <!-- 해당 지역의 극장들만 필터링해서 표시 -->
                                <c:forEach var="tvo" items="${tvoArr}">
                                <c:if test="${tvo.tRegion == tvo_region.tRegion}">
                                <button type="button" onclick="goAllTheater(this, '${tvo.tIdx}')" class="theater-name-box" data-theater-id="${tvo.tIdx}" data-region="${tvo.tRegion}">
                                        ${tvo.tName}
                                </button>
                                </c:if>
                                </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                <div class="user-theater">
                                    <c:choose>
                                        <c:when test="${empty sessionScope.mvo && empty sessionScope.kvo && empty sessionScope.nmemvo}">
                                            <%--로그인전--%>
                                            <div class="theater-footer">
                                                <div class="my-theater">나의 선호극장 정보</div>
                                                <div class="btn_area">
                                                    <button class="login-btn">로그인하기</button>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <%--로그인 후--%>
                                            <div class="theater-footer">
                                                <div class="my-theater">***님의 선호극장</div>
                                                <div class="btn_area">
                                                    <button class="favorite-theater">선호극장 관리</button>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                            </div>
                        </div>
                    </div>



                    <!--전체 극장 리스트 영역 끝-->

                    <!--극장 이벤트 영역-->
                    <div class="event-box m70 m15">
                        <h1 class="theater event-title">극장 이벤트</h1>
                        <span class="more event"><a href="#">더보기 ></a></span>
                    </div>

                    <div id="event_img" style="display:flex;">
                        <ul>
                            <li>
                                <a href="#">
                                    <img src="https://img.megabox.co.kr/SharedImg/event/2025/07/16/hCHfWJas3XsiKkJUxZb2elyg7jXKTiJQ.jpg" alt="여름 방학 특강">
                                </a>
                            </li>
                        </ul>
                        <ul>
                            <li>
                                <a href="#">
                                    <img id="img2" src="https://img.megabox.co.kr/SharedImg/event/2025/07/16/JgEejjYg1rCaMVkaNKvYEIXJfk1io1XC.jpg" alt="티켓 콤보 모두 할인">
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!--극장 이벤트 영역 끝-->

                    <!--극장 공지사항-->
                    <div class="allTheater-notice-info event-box">
                        <h1 class="theater notice-title">극장 공지사항</h1>
                        <span class="more notice"><a href="#">더보기 ></a></span>
                    </div>

                    <div class="notice-board-wrapper">
                        <table class="notice-board">
                            <thead>
                            <tr>
                                <th>극장</th>
                                <th>제목</th>
                                <th>지역</th>
                                <th>등록일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>인천학익(시티오씨엘)</td>
                                <td><a href="#">[인천학익] 메가 원데이 패스 행사 일정 변경 안내</a></td>
                                <td>인천</td>
                                <td>2025.07.28</td>
                            </tr>
                            <tr>
                                <td>강남</td>
                                <td><a href="#">[강남] 전관 대관 행사 진행에 따른 고객 안내(7/26)</a></td>
                                <td>서울</td>
                                <td>2025.07.21</td>
                            </tr>
                            <tr>
                                <td>코엑스</td>
                                <td><a href="#">[코엑스]시사회 진행에 따른 고객 안내 (7/20)</a></td>
                                <td>인천</td>
                                <td>2025.07.28</td>
                            </tr>
                            <tr>
                                <td>안성스타필드</td>
                                <td><a href="#">[안성스타필드]단체관람 행사로 인한 고객 안내 (7월 18일)</a></td>
                                <td>경기</td>
                                <td>2025.07.15</td>
                            </tr>
                            <tr>
                                <td>상암월드컵경기장</td>
                                <td><a href="#">[상암월드컵경기장지점] '2025 K리그' 7월 정규리그 일정 및 국대 경기 진행으로 인한 주차 안내</a></td>
                                <td>서울</td>
                                <td>2025.07.04</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--극장 공지사항 끝-->
                </div>
            </div>
</article>
<footer>
    <jsp:include page="common/Footer.jsp"/>
</footer>

<script>
    function goAllTheater(btn, theaterId) {
        location.href = "Controller?type=allTheater&tIdx=" + theaterId;
    }

    document.addEventListener('DOMContentLoaded', function() {
        // 모든 탭 버튼과 내용 영역을 가져옵니다.
        const tabs = document.querySelectorAll('.menu li');
        const tabContents = document.querySelectorAll('.tabCont');

        // 각 탭 버튼에 클릭 이벤트 리스너를 추가합니다.
        tabs.forEach((tab) => {
            tab.addEventListener('click', (e) => {
                e.preventDefault();

                // 클릭된 탭의 지역 정보를 가져옵니다.
                const regionLink = tab.querySelector('a[data-region]');
                if (!regionLink) return;

                const selectedRegion = regionLink.getAttribute('data-region');

                // 모든 탭에서 active 클래스들을 제거합니다.
                tabs.forEach(item => {
                    item.classList.remove('selected', 'active', 'on');
                });

                // 클릭한 탭에 active 클래스들을 추가합니다.
                tab.classList.add('selected', 'active', 'on');

                // 모든 내용 영역을 숨깁니다.
                tabContents.forEach(content => {
                    content.style.display = 'none';
                });

                // 선택된 지역의 내용 영역만 보여줍니다.
                const targetContent = document.getElementById('tabCont_' + selectedRegion);
                if (targetContent) {
                    targetContent.style.display = 'block';

                    // 애니메이션 효과를 위해 약간의 지연
                    setTimeout(() => {
                        targetContent.style.opacity = '1';
                    }, 50);
                }

                // 콘솔에 디버깅 정보 출력
                console.log('선택된 지역:', selectedRegion);
                console.log('표시될 컨텐츠 ID:', 'tabCont_' + selectedRegion);
            });
        });

        // 극장 버튼 클릭 이벤트
        document.querySelectorAll('.theater-name-box').forEach(button => {
            button.addEventListener('click', function() {
                const theaterId = this.getAttribute('data-theater-id');
                const theaterRegion = this.getAttribute('data-region');
                const theaterName = this.querySelector('.theater-name').textContent;

                // 이전에 선택된 극장 버튼의 선택 상태 제거
                document.querySelectorAll('.theater-name-box').forEach(btn => {
                    btn.classList.remove('selected-theater');
                });

                // 현재 클릭된 극장 버튼에 선택 상태 추가
                this.classList.add('selected-theater');

                // 극장 선택 시 처리할 로직
                console.log('선택된 극장:', theaterName, 'ID:', theaterId, '지역:', theaterRegion);

                // 예: 극장 선택 후 다음 단계로 이동
                // location.href = `/movie/schedule?theaterId=${theaterId}`;

                // 또는 선택된 극장 정보를 폼에 설정
                // document.getElementById('selectedTheaterId').value = theaterId;
            });
        });

        // 페이지 로드 시 첫 번째 탭의 내용이 보이도록 설정
        const firstTabContent = document.querySelector('.tabCont');
        if (firstTabContent) {
            firstTabContent.style.display = 'block';
        }
    });
</script>

</body>
</html>
