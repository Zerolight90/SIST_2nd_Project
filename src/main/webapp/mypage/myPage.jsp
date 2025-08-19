<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <title>마이페이지</title>
  <!-- 기본 CSS와 jQuery UI -->
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="../css/reset.css">
  <link rel="stylesheet" href="../css/sub/sub_page_style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <link rel="stylesheet" href="../css/mypage.css">
  <link rel="icon" href="../images/favicon.png">


  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body>

<%-- 공통 헤더 (메뉴) --%>
<header>
  <jsp:include page="../common/sub_menu.jsp"/>
</header>

<%-- 마이페이지 컨텐츠 --%>
<article>
  <div class="container">
    <nav class="side-nav">
      <h2>마이페이지</h2>
      <ul>
        <li><a href="${cp}/Controller?type=myReservation" class="nav-link active" data-type="myReservation">예매/구매내역</a></li>
        <li><a href="${cp}/Controller?type=myPrivateinquiry" class="nav-link" data-type="myPrivateinquiry">1:1문의내역</a></li>
        <li><a href="${cp}/Controller?type=myCoupon" class="nav-link" data-type="myCoupon">제휴쿠폰</a></li>
        <li><a href="${cp}/Controller?type=myPoint" class="nav-link" data-type="myPoint">멤버십 포인트</a></li>
        <li><a href="${cp}/Controller?type=myMovieStory" class="nav-link" data-type="myMovieStory">나의 무비스토리</a></li>
        <li><a href="${cp}/Controller?type=myUserInfo" class="nav-link" data-type="myUserInfo">회원정보</a></li>
      </ul>
    </nav>

    <c:choose>
      <c:when test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
        <%-- 추가 정보 입력 다이얼로그 --%>
        <div id="dialog">
          <p>
            카카오 간편 가입 회원은<br>
            전화번호·생년월일 등 추가 정보를 입력해야<br>
            모든 마이페이지 기능을 사용하실 수 있습니다.
          </p>
        </div>

        <main class="main-content" id="mainContent">
            <%-- 기본은 회원정보 화면을 Ajax로 Load --%>
        </main>
      </c:when>
      <c:otherwise>
        <main class="main-content" id="mainContent">
            <%-- 기본은 예매내역 화면을 Ajax로 Load --%>
        </main>
      </c:otherwise>
    </c:choose>
  </div>
</article>

<%-- 공통 푸터 --%>
<footer>
  <jsp:include page="../common/Footer.jsp"/>
</footer>

<script>
  $(function() {
    let $dialog = $("#dialog"); // 다이얼로그 요소

    // 다이얼로그 옵션 설정
    let option = {
      modal: true, autoOpen: false,
      title: '추가 정보 입력 안내',
      width: 450, height: 250, resizable: false,
      buttons: { "확인": function() { $dialog.dialog("close"); } }
    };
    $dialog.dialog(option); // 다이얼로그 초기화

    // 카카오 간편가입 후 추가 정보 미입력 시 다이얼로그 열기
    <c:if test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
    $dialog.dialog("open");
    </c:if>

    const mainContent = $("#mainContent"); // 메인 컨텐츠 영역을 변수로 지정

    // --- 초기 화면 로드 ---
    let firstUrl;
    <c:choose>
    <c:when test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
    firstUrl = "${cp}/Controller?type=myUserInfo";
    // 회원정보 탭을 기본으로 활성화
    $('.side-nav .nav-link[data-type="myUserInfo"]').addClass('active').siblings().removeClass('active');
    </c:when>
    <c:otherwise>
    firstUrl = "${cp}/Controller?type=myReservation";
    // 예매내역 탭을 기본으로 활성화
    $('.side-nav .nav-link[data-type="myReservation"]').addClass('active').siblings().removeClass('active');
    </c:otherwise>
    </c:choose>
    mainContent.load(firstUrl); // Ajax로 첫 화면 로드

    // --- 이벤트 핸들러 (이벤트 위임 사용) ---

    // 1. 좌측 사이드 메뉴 클릭 처리
    $('.side-nav .nav-link').on('click', function(e) {
      e.preventDefault(); // 기본 링크 동작 방지
      $('.side-nav .nav-link').removeClass('active'); // 모든 메뉴에서 active 클래스 제거
      $(this).addClass('active'); // 클릭한 메뉴에 active 클래스 추가
      const url = $(this).attr('href');
      mainContent.load(url); // Ajax로 메인 영역 교체
    });

    // 2. 동적으로 로드된 '나의 무비스토리' 탭 클릭 처리
    mainContent.on('click', '.tab-nav a', function(e) {
      e.preventDefault(); // 기본 링크 동작(페이지 전체 이동) 방지
      const url = $(this).attr('href');
      mainContent.load(url); // mainContent 영역만 Ajax로 새로고침
    });

    // 3. 동적으로 로드된 '페이징' 링크 클릭 처리
    mainContent.on('click', '.pagination a', function(e) {
      e.preventDefault(); // 기본 링크 동작(페이지 전체 이동) 방지
      const url = $(this).attr('href');
      mainContent.load(url); // mainContent 영역만 Ajax로 새로고침
    });
  });
</script>

</body>
</html>
