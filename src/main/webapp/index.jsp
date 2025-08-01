<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="./images/favicon.png">

</head>

<body>
<header>
   <jsp:include page="jsp/menu.jsp"/>
</header>

<article>
    <div id="content">
        <!--            박스 오피스 영역-->
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
            <ul>
                <li>
                    <a href="#" title="영화상세 보기">
                        <p class="bage film">필름소사이어티</p>
                        <div class="img">
                            <img src="https://img.megabox.co.kr/SharedImg/2025/07/14/VRpdyzPdC6Rq5SsHkKjIwOac05VMoHnU_420.jpg" alt="미세리코르디아"/>

                            <!--영화 특별 요소-->
                            <div class="screen-type2">
                                <!--                                     <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_mega_mx4d.png" alt="mx4d"></p>-->
                                <!--                                     <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbycinema.png" alt="dolby"></p>-->
                                <!--                                     <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbyatmos.png" alt="atmos"></p>-->
                            </div>

                            <!--등급-->
                            <div class="movie-grade_box">
                                <img src="images/12_56x56.png"  alt="12.jpg"/>
                            </div>

                            <!-- 리뷰 -->
                            <div class="summary">
                                <p class="review">
                                    제레미는 과거 자신이 일했던 빵집 사장의 장례식을 위해 고향 마을로 돌아온다.
                                    미망인 마르틴의 부탁으로 그 집에 며칠 더 머무르기로 하지만
                                    아들 뱅상은 이를 못마땅하게 여기고 어릴 적 친구 왈테르도 그를 경계한다.
                                    마을 성당의 노신부도 감시하는듯 그의 주변을 맴도는데&hellip;
                                    주인공을 둘러싼 사람들의 기이한 태도 속에 뜻밖의 실종 사건이 발생한다.
                                </p>

                                <div class="rating">
                                    <span class="review_txt"> 관람평</span>
                                    <span class="score">8.5</span>
                                </div>

                            </div>
                        </div>
                        <p class="tit">미세리코르디아</p>
                    </a>

                    <div class="btn-util">
                        <button type="button" class="button btn-like">
                            <i class="fas fa-heart"></i> 2.2k
                        </button>
                        <div class="case">
                            <a href="#" class="button gblue" title="영화 예매하기">예매</a>
                        </div>
                    </div>
                </li>


                <li>
                    <a href="#" title="영화상세 보기">
                        <p class="bage film">필름소사이어티</p>
                        <div class="img">
                            <img src="https://img.megabox.co.kr/SharedImg/2025/06/12/hWiZN7PP9G18jB18bS2BfyOTRDPpJH0m_420.jpg" alt="F1 더 무비"/>

                            <!--영화 특별 요소-->
                            <div class="screen-type2">
                                <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_mega_mx4d.png" alt="mx4d"></p>
                                <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbycinema.png" alt="dolby"></p>
                                <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbyatmos.png" alt="atmos"></p>
                            </div>

                            <!--등급-->
                            <div class="movie-grade_box">
                                <img src="images/15_56x56.png"  alt="15.jpg"/>
                            </div>

                            <!-- 리뷰 -->
                            <div class="summary">
                                <p class="review">
                                    제레미는 과거 자신이 일했던 빵집 사장의 장례식을 위해 고향 마을로 돌아온다.
                                    미망인 마르틴의 부탁으로 그 집에 며칠 더 머무르기로 하지만
                                    아들 뱅상은 이를 못마땅하게 여기고 어릴 적 친구 왈테르도 그를 경계한다.
                                    마을 성당의 노신부도 감시하는듯 그의 주변을 맴도는데&hellip;
                                    주인공을 둘러싼 사람들의 기이한 태도 속에 뜻밖의 실종 사건이 발생한다.
                                </p>

                                <div class="rating">
                                    <span class="review_txt"> 관람평</span>
                                    <span class="score">8.5</span>
                                </div>
                            </div>
                        </div>
                        <p class="tit">F1 더 무비</p>
                    </a>

                    <div class="btn-util">
                        <button type="button" class="button btn-like">
                            <i class="fas fa-heart"></i> 2.2k
                        </button>
                        <div class="case">
                            <a href="#" class="button gblue" title="영화 예매하기">예매</a>
                        </div>
                    </div>
                </li>

                <li>
                    <a href="#" title="영화상세 보기">
                        <p class="bage film">전독시</p>
                        <div class="img">
                            <img src="https://img.megabox.co.kr/SharedImg/2025/06/19/TyfP6NNlQZow6YlCAvvFL2MXyYhRxWR4_420.jpg" alt="전독시"/>

                            <!--영화 특별 요소-->
                            <div class="screen-type2">
                                <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_mega_mx4d.png" alt="mx4d"></p>
                                <!--                                     <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbycinema.png" alt="dolby"></p>-->
                                <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbyatmos.png" alt="atmos"></p>
                            </div>

                            <!--등급-->
                            <div class="movie-grade_box">
                                <img src="images/12_56x56.png"  alt="12.jpg"/>
                            </div>

                            <!-- 리뷰 -->
                            <div class="summary">
                                <p class="review">
                                    제레미는 과거 자신이 일했던 빵집 사장의 장례식을 위해 고향 마을로 돌아온다.
                                    미망인 마르틴의 부탁으로 그 집에 며칠 더 머무르기로 하지만
                                    아들 뱅상은 이를 못마땅하게 여기고 어릴 적 친구 왈테르도 그를 경계한다.
                                    마을 성당의 노신부도 감시하는듯 그의 주변을 맴도는데&hellip;
                                    주인공을 둘러싼 사람들의 기이한 태도 속에 뜻밖의 실종 사건이 발생한다.
                                </p>

                                <div class="rating">
                                    <span class="review_txt"> 관람평</span>
                                    <span class="score">8.5</span>
                                </div>
                            </div>
                        </div>
                        <p class="tit">전독시</p>
                    </a>

                    <div class="btn-util">
                        <button type="button" class="button btn-like">
                            <i class="fas fa-heart"></i> 2.2k
                        </button>
                        <div class="case">
                            <a href="#" class="button gblue" title="영화 예매하기">예매</a>
                        </div>
                    </div>
                </li>

                <li>
                    <a href="#" title="영화상세 보기">
                        <p class="bage film">필름소사이어티</p>
                        <div class="img">
                            <img src="https://img.megabox.co.kr/SharedImg/2025/07/03/3BxH4UoFoFlObYgjI3iBYpygQMGwFHXl_420.jpg" alt="발레리나"/>

                            <!--영화 특별 요소-->
                            <div class="screen-type2">
                                <!--                                     <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_mega_mx4d.png" alt="mx4d"></p>-->
                                <!--                                     <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbycinema.png" alt="dolby"></p>-->
                                <p><img src="https://img.megabox.co.kr/static/pc/images/movie/type_dolbyatmos.png" alt="atmos"></p>
                            </div>

                            <!--등급-->
                            <div class="movie-grade_box">
                                <img src="images/19_112x112.png"  alt="19.jpg"/>
                            </div>

                            <!-- 리뷰 -->
                            <div class="summary">
                                <p class="review">
                                    제레미는 과거 자신이 일했던 빵집 사장의 장례식을 위해 고향 마을로 돌아온다.
                                    미망인 마르틴의 부탁으로 그 집에 며칠 더 머무르기로 하지만
                                    아들 뱅상은 이를 못마땅하게 여기고 어릴 적 친구 왈테르도 그를 경계한다.
                                    마을 성당의 노신부도 감시하는듯 그의 주변을 맴도는데&hellip;
                                    주인공을 둘러싼 사람들의 기이한 태도 속에 뜻밖의 실종 사건이 발생한다.
                                </p>

                                <div class="rating">
                                    <span class="review_txt"> 관람평</span>
                                    <span class="score">8.5</span>
                                </div>
                            </div>
                        </div>
                        <p class="tit">발레리나</p>
                    </a>

                    <div class="btn-util">
                        <button type="button" class="button btn-like">
                            <i class="fas fa-heart"></i> 2.2k
                        </button>
                        <div class="case">
                            <a href="booking.jsp" class="button gblue" title="영화 예매하기">예매</a>
                        </div>
                    </div>
                </li>
            </ul>
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

        <div class="info_slider">
            <div class="info_btn">
                <button class="b_btn">&lt;</button>
                <button class="n_btn">&gt;</button>
            </div>
            <ul>
                <li>
                    <a href="#">
                        <img src="images/infomation_img/bg-main-dolbycinema.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드1</a>
                </li>

                <li>
                    <a href="#">
                        <img src="images/infomation_img/bg-main-dva.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드2
                    </a>
                </li>

                <li>
                    <a href="#">
                        <img src="images/infomation_img/bg-main-mx4d.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드3
                    </a>
                </li>

                <li>
                    <a href="#">
                        <img src="images/infomation_img/bg-main-dolbyatmos.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드4
                    </a>
                </li>

                <li>
                    <a href="#"><img src="images/infomation_img/bg-main-led.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드5
                    </a>
                </li>

                <li>
                    <a href="#">
                        <img src="images/infomation_img/bg-main-private.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드6
                    </a>
                </li>

                <li>
                    <a href="#"><img src="images/infomation_img/bg-main-suite.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드7
                    </a>
                </li>

                <li>
                    <a href="#">
                        <img src="images/infomation_img/bg-main-boutiq.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드8
                    </a>
                </li>

                <li>
                    <a href="#"><img src="./images/infomation_img/bg-main-recliner.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드9
                    </a>
                </li>

                <li>
                    <a href="#">
                        <img src="images/infomation_img/bg-main-comfort.png" alt="dolbyatmos" draggable="false"/>
                        슬라이드10
                    </a>
                </li>
            </ul>
        </div>

        <script>

        </script>
    </div>

</article>

<jsp:include page="jsp/Footer.jsp"/>

<script src="js/main/slider.js"></script>
</body>

</html>