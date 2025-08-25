<%@ page import="mybatis.vo.MemberVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="css/inexMovie_top4.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/reset.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="./images/favicon.png">

</head>


<body>
<header>
   <jsp:include page="common/menu.jsp"/>
</header>

<article>
    <!-- 박스 오피스 영역-->
    <div id="content">

        <div class="bg">
            <div class="bg-pattern"></div>
            <img src="https://img.megabox.co.kr/SharedImg/2025/06/30/AX9J4sgTtL3cEgfjXjNH4OYQwlkz2dW6_380.jpg" alt="01.jpg"/>
        </div>

        <div class="cont-area">
            <div class="tab-sorting">
                <button type="button" class="on" sort="boxoRankList" name="btnSort">박스오피스</button>
            </div>

            <a href="#" class="more-movie" title="더 많은 영화보기">
                더 많은 영화보기 <i class="fas fa-plus"></i>
            </a>
        </div>

        <div class="boxoffice">

            <div class="movie-list">
                <c:forEach var="movie" items="${topMovies}">
                    <div class="movie-item">
                        <a href="Controller?type=movieDetail&mIdx=${movie.mIdx}" class="poster-link">
                            <img src="${movie.poster}" alt="${movie.name} 포스터">
                            <div class="summary"><p>${movie.synop}</p></div>
                        </a>

                        <c:choose>
                            <c:when test="${movie.age == '정보 없음'}">
                                <span class="age-rating age-ALL">ALL</span>
                            </c:when>
                            <c:otherwise>
                                <span class="age-rating age-${movie.age}">${movie.age}</span>
                            </c:otherwise>
                        </c:choose>

                        <div class="movie-actions">
                            <button type="button" class="like-btn ${!empty likedMovieSet && likedMovieSet.contains(movie.mIdx) ? 'liked' : ''}" data-midx="${movie.mIdx}">
                                <span class="heart-icon"></span>
                                <span class="like-count">${!empty likeCountMap[movie.mIdx] ? likeCountMap[movie.mIdx] : 0}</span>
                            </button>
                            <a href="Controller?type=booking&throw_mIdx=${movie.mIdx}" class="reserve-btn">예매</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>


        <div class="quick_menu">
            <div class="cell">
                <div class="search">
                    <input type="text" placeholder="영화명을 입력해 주세요" title="영화 검색" class="input-text" id="movieName">
                    <button type="button" class="btn" id="btnSearch"><i class="fas fa-search"></i> 검색</button>
                </div>
            </div>

            <div class="cell">
                <a href="/booking/timetable" title="상영시간표 보기">
                    <i class="fa-solid fa-calendar-days"></i>
                    <span>상영시간표</span>
                </a>
            </div>

            <div class="cell">
                <a href="/movie" title="박스오피스 보기">
                    <i class="fa-solid fa-ranking-star"></i>
                    <span>박스오피스</span>
                </a>
            </div>

            <div class="cell">
                <a href="/booking" title="빠른예매 보기">
                    <i class="fa-solid fa-bolt"></i>
                    <span>빠른예매</span>
                </a>
            </div>
        </div>

        <div class="mouse">
            <img src="images/ico-mouse.png" alt="mouse"/>
        </div>

        <!--마우스 애니메이션 제이쿼리-->
        <script>
            $(document).ready(function(){
                function mouseBounce() {
                    // .mouse를 아래로 40px 이동 (0.7초)
                    $(".mouse").animate({top: "+=10px"}, 700, function(){
                        // 다시 위로 40px 이동 (0.7초), 완료 후 다시 mouseBounce 호출
                        $(".mouse").animate({top: "-=10px"}, 700, mouseBounce);
                    });
                }
                // 초기 위치(top: 50%)에서 정확히 움직이려면 position을 absolute로 하고 CSS에서 top 지정 필요
                // 움직임 시작
                mouseBounce();
            });
        </script>

    </div>

    <!--혜택-->
    <div id="boon" class="boon">
        <div class="boon_tit">
            <h3>혜택</h3>
            <a href="#" class="more-event" title="더 많은 혜택">
                더 많은 혜택보기 <i class="fas fa-plus"></i>
            </a>
        </div>

        <!-- 슬라이더 -->
        <div class="slider">

            <!--슬라이드 타이틀-->
            <div class="slider_tit">
                <a href="#">
                    <img src="https://img.megabox.co.kr/SharedImg/BnftMng/2025/07/25/l9DoEzumv3TiHQfNaPOCLgBLKXQaecr0.jpg" alt=""/>
                </a>
            </div>

            <div class="slider_tit">
                <a href="#">
                    <img src="https://img.megabox.co.kr/SharedImg/BnftMng/2025/07/10/F8oz3G1KYzGcXkTytaNB1PV2HYLeE2nx.png" alt=""/>
                </a>
            </div>

            <div class="slider_tit">
                <a href="#">
                    <img src="https://img.megabox.co.kr/SharedImg/BnftMng/2025/07/07/8Vhr59TwP2wdXZLbjnmTLvdw6FtXeEzU.jpg" alt=""/>
                </a>
            </div>

            <div class="slider_tit">
                <a href="#">
                    <img src="https://img.megabox.co.kr/SharedImg/BnftMng/2025/06/27/2du87w2EeAtprTO1bZL5VFXnJQo2Z9iD.jpg" alt=""/>
                </a>
            </div>

            <!--슬라이드 이미지-->
            <div class="slider_img">
                <a href="#">
                    <img src="https://img.megabox.co.kr/SharedImg/BnftMng/2025/07/25/2q27REHj9CR53xp5LKZmR316DpEotgyH.jpg" alt=""/>
                </a>
            </div>

            <div class="slider_img">
                <a href="#">
                    <img src="./images/toss_img.png" alt=""/>
                </a>
            </div>

            <div class="slider_img">
                <a href="#">
                    <img src="https://img.megabox.co.kr/SharedImg/BnftMng/2025/07/07/0xjhWwgS0NBrjz5BoDBKo0u844BqF7a9.jpg" alt=""/>
                </a>
            </div>

            <div class="slider_img">
                <a href="#">
                    <img src="https://img.megabox.co.kr/SharedImg/BnftMng/2025/06/27/sdXTRaCGQ0fbRVLuUDbzHOs152BFWGFY.jpg" alt=""/>
                </a>
            </div>

            <div class="slider_btn">
                <div class="page">
                    <span class="on"></span>
                    <span class="off"></span>
                    <span class="off"></span>
                    <span class="off"></span>
                </div>

                <div class="util">
                    <button type="button" class="btn-prev" style="opacity: 1;">이전 이벤트 보기</button>
                    <button type="button" class="btn-next" style="opacity: 1;">다음 이벤트 보기</button>

                    <button type="button" class="btn-pause">일시정지</button>
                    <button type="button" class="btn-play on">자동재생</button>
                </div>

                <div class="count">
                    1 / 4
                </div>
            </div>


        </div>

        <div class="menu_link_bg">
            <div class="menu-link">
                <div class="cell vip"><a href="/benefit/viplounge" title="VIP LOUNGE 페이지로 이동">VIP LOUNGE</a></div>
                <div class="cell membership"><a href="/benefit/membership" title="멤버십 페이지로 이동">멤버십</a></div>
                <div class="cell card"><a href="/benefit/discount/guide" title="할인카드안내 페이지로 이동">할인카드안내</a></div>
                <div class="cell event"><a href="/event" title="이벤트 페이지로 이동">이벤트</a></div>
                <div class="cell store"><a href="/store" title="스토어 페이지로 이동">스토어</a></div>
            </div>
        </div>
    </div>

    <!--큐레이션-->
    <div id="Curation">
        <div class="Curation_tit">
            <h3>큐레이션</h3>

            <a href="#" class="more-event" title="더 많은 혜택">
                큐레이션 더 보기 <i class="fas fa-plus"></i>
            </a>
        </div>

        <div class="curation-area">
            <!-- curr-img -->
            <div class="curr-img">
                <p class="curr-img film">메가박스 필름소사이어티</p>
                <div class="img">
                    <a href="#" title="영화상세 보기">
                        <img src="https://img.megabox.co.kr/SharedImg/2025/06/25/vpsfG90KfghLzOlqQlbM08MSblmwgl2w_420.jpg" alt="이사">
                    </a>
                </div>

                <div class="btn-group justify">
                    <div class="left">
                        <a href="#" class="button" title="영화상세 보기">상세정보</a>
                    </div>
                    <div class="right">
                        <a href="#" class="button gblue" title="영화 예매하기">예매</a>
                    </div>
                </div>

                <div class="info">
                    <p class="txt"><span>#</span>필름소사이어티</p>
                    <p class="info_tit">이사</p>
                    <p class="info_summary">
                        화목한 가정을 자부하던 6학년 소녀 렌<br>어느 날 아빠가 집을 나가고 엄마가 이혼을 선언했다.<br><br>
                        “나는 엄마 아빠가 싸워도 참았어<br>근데 왜 엄마 아빠는 못 참는 거야?”<br><br>엄마가 만든 ‘둘을 위한
                        계약서’도 싫고<br>친구들이 이 사실을 알아챌까 두렵다<br><br>“엄마, 부탁이 있어<br>이번 주 토요일 비와
                        호수에 가자”<br><br>몰래 꾸민 세 가족 여행<br>엄마 아빠와 다시 함께 살 수 있을까?
                    </p>
                </div>
            </div>

            <div class="list">
                <ul>
                    <li>
                        <a href="#" title="영화상세 보기">
                            <p class="list film">
                                <img src ="https://www.megabox.co.kr/static/pc/images/main/bg-bage-curation-classic-m.png" alt="f">
                                [오페라] 살로메 @The Met</p>
                            <div class="img"><img src="https://img.megabox.co.kr/SharedImg/2025/07/30/2rjo3n80E7xYoxI7Iegwbscv3eop38HQ_230.jpg" alt="반 고흐. 밀밭과 구름 낀 하늘"></div>

                            <p class="list_tit">[오페라] 살로메 @The Met</p>

                        </a>
                    </li>

                    <li>
                        <a href="#" title="영화상세 보기">
                            <p class="list film">
                                <img src ="https://www.megabox.co.kr/static/pc/images/main/bg-bage-curation-film-m.png" alt="f">
                                스왈로우테일 버터플라이</p>
                            <div class="img"><img src="https://img.megabox.co.kr/SharedImg/2025/06/30/w2nnbPYseX6AEYRAtUFANOMy4uUAJRos_230.jpg" alt="반 고흐. 밀밭과 구름 낀 하늘"></div>

                            <p class="list_tit">스왈로우테일 버터플라이</p>

                        </a>
                    </li>

                    <li>
                        <a href="#" title="영화상세 보기">
                            <p class="list film">
                                <img src = "https://www.megabox.co.kr/static/pc/images/main/bg-bage-curation-film-m.png" alt="f">
                                필름소사이어티</p>
                            <div class="img"><img src="https://img.megabox.co.kr/SharedImg/2025/07/01/bH7Oy3v0WXrni0IGZPujFnCpht3kEUEi_230.jpg" alt="반 고흐. 밀밭과 구름 낀 하늘"></div>

                            <p class="list_tit">미세리코르디아</p>

                        </a>
                    </li>

                    <li>
                        <a href="#" title="영화상세 보기">
                            <p class="list film">
                                <img src ="https://www.megabox.co.kr/static/pc/images/main/bg-bage-curation-classic-m.png" alt="f">
                                필름소사이어티</p>
                            <div class="img"><img src="https://img.megabox.co.kr/SharedImg/2025/07/04/2gu3t4RJ8rYYBi7NoP9cJ1BUDu5vzMn2_230.jpg" alt="반 고흐. 밀밭과 구름 낀 하늘" onerror="noImg(this, 'main');"></div>

                            <p class="list_tit">반 고흐. 밀밭과 구름 낀 하늘</p>

                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div id="imformation">
        <div class="imformation_tit">
            <h3>쌍용박스 안내</h3>
        </div>

        <div class="slider-container">

            <div class="slider-box">
                <!-- 10개의 슬라이드 아이템 -->
                <div class="slide-item"><img src="./images/infomation_img/bg-main-boutiq.png" alt="이미지 1"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-comfort.png" alt="이미지 2"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-dolbyatmos.png" alt="이미지 3"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-dolbycinema.png" alt="이미지 4"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-dva.png" alt="이미지 5"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-led.png" alt="이미지 6"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-mx4d.png" alt="이미지 7"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-suite.png" alt="이미지 8"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-private.png" alt="이미지 9"></div>
                <div class="slide-item"><img src="./images/infomation_img/bg-main-recliner.png" alt="이미지 10"></div>
            </div>
        </div>

        <div class="button-container">
            <button class="prev-btn"><i class="fas fa-chevron-left"></i></button>
            <button class="next-btn"><i class="fas fa-chevron-right"></i></button>
        </div>

        <div class="notice">
            <p class="notice-tit">지점</p>
            <p class="notice-content">
                <a href="#"><span>[인천학익(시티오씨엘)]</span>[인천학익] 1만원 관람 혜택 운영 변경 안내</a>
            </p>
            <p class="date">2025.07.31</p>
            <p class="more-notice">
                <a href="/support/notice" title="전체공지 더보기">더보기
                    <i class="fas fa-chevron-right"></i>
                </a>
            </p>
        </div>



        <div class="info-link">
            <div class="table">
                <div class="info_cell">
                    <a href="/support" title="고객센터 페이지로 이동">
                        <i class="fa-solid fa-headset"></i>
                        <span>고객센터</span>
                    </a>
                </div>

                <div class="info_cell">
                    <a href="/support/faq" title="자주 묻는 질문 페이지로 이동">
                        <i class="fa-solid fa-circle-question"></i>
                        <span>자주 묻는 질문</span>
                    </a>
                </div>

                <div class="info_cell">
                    <a href="/support/inquiry" title="1:1 문의 페이지로 이동">
                        <i class="fa-solid fa-comment-dots"></i>
                        <span>1:1 문의</span>
                    </a>
                </div>

                <div class="info_cell">
                    <a href="/support/rent" title="단체/대관문의 페이지로 이동">
                        <i class="fa-solid fa-users"></i>
                        <span>단체/대관문의</span>
                    </a>
                </div>

                <div class="info_cell">
                    <a href="/support/lost" title="분실물 문의/접수 페이지로 이동">
                        <i class="fa-solid fa-box-open"></i>
                        <span>분실물 문의/접수</span>
                    </a>
                </div>

                <div class="info_cell">
                    <a href="/booking/privatebooking" title="더 부티크 프라이빗 대관예매 페이지로 이동">
                        <i class="fa-solid fa-store"></i>
                        <span>더 부티크 프라이빗<br>대관예매</span>
                    </a>
                </div>
            </div>
        </div>

    </div>

    <script>
        $(document).ready(function(){
            const moveAmount = 190; // 한 번에 이동할 픽셀 값
            const animationSpeed = 500; // 애니메이션 속도 (0.5초)
            const maxRight = 760; // '다음' 버튼이 비활성화될 right 값

            // '다음' 버튼 클릭 이벤트
            $('.next-btn').click(function(){
                // .slide-item의 현재 right 위치 값을 가져옵니다.
                let currentRight = parseInt($('.slide-item').css('right'), 10) || 0;

                // 현재 right 값이 760보다 작을 때만 애니메이션을 실행합니다.
                if (currentRight < maxRight) {
                    $('.slide-item').animate({
                        right: '+=' + moveAmount + 'px'
                    }, animationSpeed);
                }
            });

            // '이전' 버튼 클릭 이벤트
            $('.prev-btn').click(function(){
                // .slide-item의 현재 right 위치 값을 가져옵니다.
                let currentRight = parseInt($('.slide-item').css('right'), 10) || 0;

                // 현재 right 값이 0보다 클 때만 애니메이션을 실행합니다.
                if (currentRight > 0) {
                    $('.slide-item').animate({
                        right: '-=' + moveAmount + 'px'
                    }, animationSpeed);
                }
            });
        });
    </script>
</article>

<jsp:include page="common/Footer.jsp"/>

<script src="js/main/slider.js"></script>
<%-- 쿠폰 발급 알림 스크립트 --%>
<%
    String couponAlertMessage = (String) session.getAttribute("couponAlert");
    // 메시지가 null이 아니고, 빈 문자열("")도 아닐 경우에만 스크립트 실행
    if (couponAlertMessage != null && !couponAlertMessage.trim().isEmpty()) {
%>
<script>
    window.addEventListener('load', function() {
        // 자바 변수를 JavaScript 변수로 가져와서 사용
        var alertMsg = "<%= couponAlertMessage %>";
        alert(alertMsg);
    });
</script>
<%
        // 메시지를 출력한 후 세션에서 제거
        session.removeAttribute("couponAlert");
    }
%>
</body>

</html>