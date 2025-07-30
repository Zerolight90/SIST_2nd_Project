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
                            <a href="#" class="button gblue" title="영화 예매하기">예매</a>
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


    <div id="Curation">
        큐레이션
    </div>

    <div id="imformation">
        쌍용박스 안내
    </div>

</article>

<jsp:include page="jsp/Footer.jsp"/>

<script src="js/main/slider.js"></script>
</body>

</html>