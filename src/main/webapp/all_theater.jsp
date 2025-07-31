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
    <div class="menu1">
        <div class="inner">
            <!-- 로고 -->
            <h1 class="logo">
                <a href="#" class="logo_link">
                    <img src="./images/logo.png" alt="sist" class="logo_img" />
                </a>
                <span class="title">S I S T M O V I E P L E X</span>
            </h1>
        </div>
    </div>


    <div class="nav-top">
        <ul class="nav-l_top">
            <li><a href="#" class="vip-lounge">VIP LOUNGE</a></li>
            <li><a href="#" class="membership">멤버십</a></li>
            <li><a href="#" class="customer-center">고객센터</a></li>
            <li><a href="#" class="admin_page">관리자</a></li> <!--로그인 할때만 표현됨-->
        </ul>

        <ul class="nav-r_top">
            <li><a href="#" class="login">로그인</a></li>
            <li><a href="#" class="signup">회원가입</a></li>
            <li><a href="#" class="quick-booking">빠른예매</a></li>
        </ul>
    </div>


    <div class="icon-menu">
        <ul class="nav-side">
            <li>
                <button class="menu-toggle" aria-label="메뉴 열기">
                    <span></span><span></span><span></span>
                </button>
            </li>

            <li>
                <a href="#" class="search-icon" aria-label="검색">
                    <i class="fas fa-search"></i>
                </a>
            </li>
        </ul>

        <ul class="nav-icon">
            <li><a href="#" class="calendar-icon" aria-label="상영시간표"><i class="fa-regular fa-calendar"></i></a></li>
            <li><a href="#" class="user-icon" aria-label="나의 SIST"><i class="fa-regular fa-user"></i></a></li>
        </ul>
    </div>

    <div class="nav-center">
        <ul class="l_main">
            <li class="main-item has-submenu">
                <a href="#">영화</a>
                <ul class="submenu">
                    <li><a href="#">전체 영화</a></li>
                </ul>
            </li>
            <li class="main-item has-submenu">
                <a href="#">예매</a>
                <ul class="submenu">
                    <li><a href="#">빠른예매</a></li>
                    <li><a href="#">상영시간표</a></li>
                    <li><a href="#">더 부티크 프라이빗 예매</a></li>
                </ul>
            </li>
            <li class="main-item has-submenu">
                <a href="#">극장</a>
                <ul class="submenu">
                    <li><a href="#">전체 극장</a></li>
                    <li><a href="#">특별관</a></li>
                </ul>
            </li>
        </ul>


        <ul class="r_main">
            <li class="main-item has-submenu">
                <a href="#">이벤트</a>
                <ul class="submenu">
                    <li><a href="#">진행중인 이벤트</a></li>
                    <li><a href="#">지난 이벤트</a></li>
                    <li><a href="#">당첨자 확인</a></li>
                </ul>
            </li>
            <li class="main-item store-menu"><a href="#">스토어</a></li>
            <li class="main-item has-submenu">
                <a href="#">혜택</a>
                <ul class="submenu">
                    <li><a href="#">메가박스 멤버쉽</a></li>
                    <li><a href="#">제휴/할인</a></li>
                </ul>
            </li>
        </ul>
        <div class="submenu-bg"></div>
        <script>
            // jQuery 코드
            $(function () {
                // "스토어"를 제외한 메뉴만 hover 효과 적용
                $('.nav-center .main-item:not(.store-menu) > a').mouseenter(function () {
                    $('.submenu-bg').css('display', 'block');
                });

                $('.nav-center .main-item:not(.store-menu)').mouseleave(function () {
                    $('.submenu-bg').css('display', 'none');
                });
            });

        </script>
    </div>
</header>


<article>

    <!--극장 영역-->
    <div id="theaterInfo">
        <div class="inner-wrap">
            <!--전체 극장 리스트 영역-->
            <h1 class="all-theater">전체극장</h1>
            <div class="all-theater-box">
                <!-- 비동기식 페이지 전환 : 라인형-->
                <div class="ec-base-tab typeLight eTab">
                    <ul class="menu">
                        <li class="selected"><a href="#tabCont1_1">서울</a></li>
                        <li><a href="#tabCont1_2">경기</a></li>
                        <li><a href="#tabCont1_3">인천</a></li>
                        <li><a href="#tabCont1_4">대전/충청/세종</a></li>
                        <li><a href="#tabCont1_5">부산/대구/경상</a></li>
                        <li><a href="#tabCont1_6">광주/전라</a></li>
                        <li><a href="#tabCont1_7">강원</a></li>
                        <li><a href="#tabCont1_8">제주</a></li>
                    </ul>
                    <div id="tabCont1_1" class="theater-tabCont" style="display:block;">
                        <div class="theater-list">
                            <ul class="region-col">
                                <li>강남</li>
                                <li>더 부티크 목동현대백화점</li>
                                <li>상봉</li>
                                <li>송파파크하비오</li>
                                <li>코엑스</li>
                            </ul>
                            <ul class="region-col">
                                <li>강남</li>
                                <li>더 부티크 목동현대백화점</li>
                                <li>상봉</li>
                                <li>송파파크하비오</li>
                                <li>코엑스</li>
                            </ul>
                            <ul class="region-col">
                                <li>강남</li>
                                <li>더 부티크 목동현대백화점</li>
                                <li>상봉</li>
                                <li>송파파크하비오</li>
                                <li>코엑스</li>
                            </ul>
                        </div>
                    </div>
                    <div id="tabCont1_2" class="theater-tabCont" style="display:none;">
                        탭 메뉴2 내용영역입니다.
                    </div>
                    <div id="tabCont1_3" class="theater-tabCont" style="display:none;">
                        탭 메뉴3 내용영역입니다.
                    </div>
                    <div id="tabCont1_4" class="theater-tabCont" style="display:none;">
                        탭 메뉴4 내용영역입니다.
                    </div>
                    <div id="tabCont1_5" class="theater-tabCont" style="display:none;">
                        탭 메뉴5 내용영역입니다.
                    </div>
                    <div id="tabCont1_6" class="theater-tabCont" style="display:none;">
                        탭 메뉴6 내용영역입니다.
                    </div>
                    <div id="tabCont1_7" class="theater-tabCont" style="display:none;">
                        탭 메뉴7 내용영역입니다.
                    </div>
                    <div id="tabCont1_8" class="theater-tabCont" style="display:none;">
                        탭 메뉴8 내용영역입니다.
                    </div>

                    <div class="favorite-box">
                        <span>■ 나의 선호극장 정보</span>
                        <button class="login-btn">로그인하기</button>
                    </div>
                </div>


            </div>
            <!--전체 극장 리스트 영역 끝-->

            <!--극장 이벤트 영역-->
            <div class="event-box m70 m15">
                <h1 class="theater event-title">극장 이벤트</h1>
                <span class="more event"><a href="#">더보기</a></span>
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
                <span class="more notice"><a href="#">더보기</a></span>
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
</script>

</body>
</html>
