<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
    let $dialog = $("#dialog"); // 다이얼로그 요소를 변수에 저장 ((399))

    // 다이얼로그 옵션
    let option = {
      modal: true, autoOpen: false,
      title: '추가 정보 입력 안내',
      width: 450, height: 250, resizable: false,
      buttons: {
        "확인": function() {
          $dialog.dialog("close"); // 저장된 변수를 사용하여 닫기 ((405))
        }
      }
    };
    $dialog.dialog(option); // 다이얼로그 초기화 ((400))

    // JSP 변수값에 따라 다이얼로그 열기
    <c:if test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
    $dialog.dialog("open"); // 저장된 변수를 사용하여 열기
    </c:if>

    // Ajax로 첫화면 로딩
    let firstUrl;
    <c:choose>
    <c:when test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
    firstUrl = "${cp}/Controller?type=myUserInfo";
    </c:when>
    <c:otherwise>
    firstUrl = "${cp}/Controller?type=myReservation";
    </c:otherwise>
    </c:choose>
    $("#mainContent").load(firstUrl);

    // 메뉴 클릭시 Ajax로 main-content 교체
    $('.side-nav .nav-link').on('click', function(e) {
      e.preventDefault();
      // 네비게이션 active 표시 처리
      $('.side-nav .nav-link').removeClass('active');
      $(this).addClass('active');
      // Ajax로 main 영역 교체
      const url = $(this).attr('href');
      $('#mainContent').load(url);
    });
  });

</script>

</body>
</html>
