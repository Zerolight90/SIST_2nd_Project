<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="nav">
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
                <a href="<c:url value="/booking.jsp"/>">예매</a>
                <ul class="submenu">
                    <li><a href="<c:url value="/booking.jsp"/>">빠른예매</a></li>
                    <li><a href="#">상영시간표</a></li>
                    <li><a href="#">더 부티크 프라이빗 예매</a></li>
                </ul>
            </li>
            <li class="main-item has-submenu">
                <a href="<c:url value="/theater_index.jsp"/>">극장</a>
                <ul class="submenu">
                    <li><a href="<c:url value="/theater_index.jsp"/>">전체 극장</a></li>
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
            <li class="main-item store-menu"><a href="<c:url value="/store.jsp"/>">스토어</a></li>
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
</div>
