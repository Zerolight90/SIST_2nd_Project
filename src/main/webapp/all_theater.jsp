<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/tab.css">
    <link rel="stylesheet" href="./css/theater.css">
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
                    <li class="active on selected"><a class="area_mv">서울</a></li>
                    <li><a class="area_mv">경기</a></li>
                    <li><a class="area_mv">인천</a></li>
                    <li><a class="area_mv">대전/충청/세종</a></li>
                    <li><a class="area_mv">부산/대구/경상</a></li>
                    <li><a class="area_mv">광주/전라</a></li>
                    <li><a class="area_mv">강원</a></li>
                    <li><a class="area_mv">제주</a></li>
                </ul>

                <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px">
                    <!-- 서울 극장 리스트 -->
                    <div class="theater-list">
                        <div class="theater-column">
                            <ul>
                                <li><a href="#">강남</a></li>
                                <li><a href="#">더부티크목동현대백화점</a></li>
                                <li><a href="#">상봉</a></li>
                                <li><a href="#">송파파크하비오</a></li>
                                <li><a href="#">코엑스</a></li>
                            </ul>
                        </div>
                        <div class="theater-column">
                            <ul>
                                <li>강동</li>
                                <li>동대문</li>
                                <li>상암월드컵경기장</li>
                                <li>신촌</li>
                                <li>홍대</li>
                            </ul>
                        </div>
                        <div class="theater-column">
                            <ul>
                                <li>구의아트플</li>
                                <li>마곡</li>
                                <li>성수</li>
                                <li>이수</li>
                                <li>화곡 <sup>ⓡ</sup></li>
                            </ul>
                        </div>
                        <div class="theater-column">
                            <ul>
                                <li>군자</li>
                                <li>목동</li>
                                <li>센트럴</li>
                                <li>창동</li>
                                <li>ARTNINE</li>
                            </ul>
                        </div>
                    </div>
                    <%-- //서울 극장 리스트 끝--%>
                </div>
                <div id="tabCont1_2" class="tabCont" style="display:none; margin-bottom: 50px">
                    안녕2
                </div>







                <div class="user-theater">
                    <%--로그인전--%>
                    <div class="theater-footer" style="border:1px solid red; border-radius: 5px; height:46px;">
                        <div class="my-theater">나의 선호극장 정보</div>
                        <button class="login-btn">로그인하기</button>
                    </div>


                    <%--로그인 후--%>
                    <div class="theater-footer" style="border:1px solid red; border-radius: 5px; height:46px;">
                        <div class="my-theater">***님의 선호극장</div>
                        <button class="favorite-theater">선호극장 관리</button>
                    </div>
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
            <div class="event-box m70 m15">
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

</script>

</body>
</html>
