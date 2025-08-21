<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body>

<%-- 공통 헤더 (메뉴) --%>
<header>
  <jsp:include page="../common/sub_menu.jsp"/>
</header>

<article>
  <c:choose>
    <%-- 1. 회원(mvo), 카카오(kvo), 비회원(nmenvo) 중 하나라도 로그인된 상태인지 확인 --%>
    <c:when test="${not empty sessionScope.mvo || not empty sessionScope.kvo || not empty sessionScope.nmenvo}">
      <div class="container">
          <%-- 사이드 메뉴 영역 --%>
        <nav class="side-nav">
          <c:choose>
            <%-- 1-1. 정회원 또는 카카오 회원일 경우 --%>
            <c:when test="${not empty sessionScope.mvo || not empty sessionScope.kvo}">
              <h2>마이페이지</h2>
              <ul>
                <li><a href="${cp}/Controller?type=myReservation" class="nav-link active" data-type="myReservation">예매/구매내역</a></li>
                <li><a href="${cp}/Controller?type=myPrivateinquiry" class="nav-link" data-type="myPrivateinquiry">1:1문의내역</a></li>
                <li><a href="${cp}/Controller?type=myCoupon" class="nav-link" data-type="myCoupon">제휴쿠폰</a></li>
                <li><a href="${cp}/Controller?type=myPoint" class="nav-link" data-type="myPoint">멤버십 포인트</a></li>
                <li><a href="${cp}/Controller?type=myMovieStory" class="nav-link" data-type="myMovieStory">나의 무비스토리</a></li>
                <li><a href="${cp}/Controller?type=myUserInfo" class="nav-link" data-type="myUserInfo">회원정보</a></li>
              </ul>
            </c:when>

            <%-- 1-2. 비회원일 경우 --%>
            <c:when test="${not empty sessionScope.nmenvo}">
              <h2>비회원 예매조회</h2>
              <ul>
                <li><a href="${cp}/Controller?type=myReservation" class="nav-link active" data-type="myReservation">예매/구매내역</a></li>
                <li><a href="#" class="nav-link disabled" onclick="alert('회원 전용 서비스입니다.'); return false;">1:1문의내역</a></li>
                <li><a href="#" class="nav-link disabled" onclick="alert('회원 전용 서비스입니다.'); return false;">제휴쿠폰</a></li>
                <li><a href="#" class="nav-link disabled" onclick="alert('회원 전용 서비스입니다.'); return false;">멤버십 포인트</a></li>
                <li><a href="#" class="nav-link disabled" onclick="alert('회원 전용 서비스입니다.'); return false;">나의 무비스토리</a></li>
                <li><a href="#" class="nav-link disabled" onclick="alert('회원 전용 서비스입니다.'); return false;">회원정보</a></li>
              </ul>
            </c:when>
          </c:choose>
        </nav>

          <%-- 메인 컨텐츠가 표시될 영역 --%>
        <main class="main-content" id="mainContent">
            <%-- 이 영역의 내용은 하단의 스크립트(AJAX)를 통해 동적으로 채워집니다. --%>
        </main>

          <%-- 카카오 간편 가입 회원의 추가 정보 입력 유도 다이얼로그 --%>
        <c:if test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
          <div id="dialog" style="display:none;">
            <p>
              카카오 간편 가입 회원은<br>
              전화번호·생년월일 등 추가 정보를 입력해야<br>
              모든 마이페이지 기능을 사용하실 수 있습니다.
            </p>
          </div>
        </c:if>
      </div>
    </c:when>

    <%-- 2. 로그인되지 않은 상태일 경우 --%>
    <c:otherwise>
      <%-- 비정상적인 접근으로 간주하고 로그인 페이지로 즉시 이동시킴 --%>
      <c:redirect url="/Controller?type=login"/>
    </c:otherwise>
  </c:choose>
</article>

<%-- 공통 푸터 --%>
<footer>
  <jsp:include page="../common/Footer.jsp"/>
</footer>

<script>
  $(function() {
    // 다이얼로그 요소 가져오기 (카카오 회원용)
    let $dialog = $("#dialog");

    // 카카오 회원이면서 추가 정보가 필요한 경우에만 다이얼로그 초기화 및 실행
    if ($dialog.length > 0) {
      let option = {
        modal: true, autoOpen: false,
        title: '추가 정보 입력 안내',
        width: 450, height: 250, resizable: false,
        buttons: { "확인": function() { $dialog.dialog("close"); } }
      };
      $dialog.dialog(option);
      $dialog.dialog("open");
    }

    // 메인 컨텐츠 영역을 jQuery 객체로 저장
    const mainContent = $("#mainContent");
    const cp = "${cp}"; // Context Path 변수

    // --- 1. 첫 화면 결정 및 로드 ---
    let firstUrl;
    let initialTabType;

    <c:choose>
    <%-- Case 1: 비회원일 경우 (nmenvo 세션 존재) --%>
    <c:when test="${not empty sessionScope.nmenvo}">
    initialTabType = "myReservation";
    firstUrl = cp + "/Controller?type=myReservation";
    </c:when>

    <%-- Case 2: 카카오 회원이면서 추가 정보가 필요할 경우 --%>
    <c:when test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
    initialTabType = "myUserInfo";
    firstUrl = cp + "/Controller?type=myUserInfo";
    </c:when>

    <%-- Case 3: 그 외 모든 회원 (정회원, 정보입력 완료한 카카오 회원) --%>
    <c:otherwise>
    initialTabType = "myReservation";
    firstUrl = cp + "/Controller?type=myReservation";
    </c:otherwise>
    </c:choose>

    // 결정된 탭에 'active' 클래스를 적용하고, mainContent에 첫 화면을 로드
    $('.side-nav .nav-link').removeClass('active');
    $('.side-nav .nav-link[data-type="' + initialTabType + '"]').addClass('active');
    mainContent.load(firstUrl);


    // --- 2. 이벤트 핸들러 설정 (이벤트 위임 방식) ---

    // 2-1. 좌측 사이드 메뉴 클릭 처리 (비활성화된 링크는 제외)
    $('.side-nav .nav-link:not(.disabled)').on('click', function(e) {
      e.preventDefault(); // 기본 링크 동작 방지
      $('.side-nav .nav-link').removeClass('active'); // 모든 메뉴에서 active 클래스 제거
      $(this).addClass('active'); // 클릭한 메뉴에 active 클래스 추가
      const url = $(this).attr('href');
      mainContent.load(url); // Ajax로 메인 영역 교체
    });

    // 2-2. 동적으로 로드된 컨텐츠 내부의 링크 처리 (공통 핸들러)
    // .tab-nav a: 무비스토리 탭
    // .pagination a: 페이지 번호
    // .view-link: 1:1문의 제목
    mainContent.on('click', '.tab-nav a, .pagination a, .view-link', function(e) {
      e.preventDefault(); // 링크의 기본 동작(페이지 전체 이동) 방지
      const url = $(this).attr('href');
      mainContent.load(url); // mainContent 영역만 Ajax로 새로고침
    });
  });
</script>

</body>
</html>
