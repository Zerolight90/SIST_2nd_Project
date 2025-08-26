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
</head>
<body>

<%-- 공통 헤더 (메뉴) --%>
<header>
  <jsp:include page="../common/sub_menu.jsp"/>
</header>

<article>
  <c:choose>
    <%-- 1. 회원(mvo), 카카오(kvo), 비회원(nmemvo) 중 하나라도 로그인된 상태인지 확인 --%>
    <c:when test="${not empty sessionScope.mvo || not empty sessionScope.kvo || not empty sessionScope.nmemvo}">

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
            <c:when test="${not empty sessionScope.nmemvo}">
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
    const cp = "${cp}";
    const mainContent = $("#mainContent"); // mainContent를 jQuery 객체로 한 번만 선언

    // 1. 카카오 회원 추가 정보 입력 유도 다이얼로그
    let $dialog = $("#dialog");
    if ($dialog.length > 0) {
      $dialog.dialog({
        modal: true, autoOpen: true,
        title: '추가 정보 입력 안내',
        width: 450, resizable: false,
        buttons: { "확인": function() { $(this).dialog("close"); } }
      });
    }

    // 2. 마이페이지 첫 화면 로드
    let firstUrl;
    let initialTabType;
    <c:choose>
    <c:when test="${not empty sessionScope.nmemvo}">
    initialTabType = "myReservation";
    firstUrl = `${cp}/Controller?type=myReservation`;
    </c:when>
    <c:when test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
    initialTabType = "myUserInfo";
    firstUrl = `${cp}/Controller?type=myUserInfo`;
    </c:when>
    <c:otherwise>
    initialTabType = "myReservation";
    firstUrl = `${cp}/Controller?type=myReservation`;
    </c:otherwise>
    </c:choose>

    $('.side-nav .nav-link').removeClass('active');
    $('.side-nav .nav-link[data-type="' + initialTabType + '"]').addClass('active');
    mainContent.load(firstUrl);

    // 3. 모든 클릭 이벤트 핸들러 (이벤트 위임 방식)

    // 3-1. 사이드 메뉴 클릭
    $('.side-nav .nav-link:not(.disabled)').on('click', function(e) {
      e.preventDefault();
      $('.side-nav .nav-link').removeClass('active');
      $(this).addClass('active');
      mainContent.load($(this).attr('href'));
    });

    // 3-2. 동적으로 로드된 컨텐츠 내부의 모든 링크 및 버튼 처리
    mainContent.on('click', 'a.view-link, .tab-nav a, .pagination a', function(e) {
      e.preventDefault();
      mainContent.load($(this).attr('href'));
    });

    // 3-3. 나의 무비스토리 - 삭제 버튼
    mainContent.on("click", ".btn-delete", function() {
      const reviewIdx = $(this).data("review-idx");
      if (confirm("정말로 이 관람평을 삭제하시겠습니까?")) {
        $.ajax({
          url: `${cp}/Controller?type=deleteReview`,
          type: "POST",
          data: { reviewIdx: reviewIdx },
          dataType: "json",
          success: (response) => {
            if (response.success) {
              alert("관람평이 삭제되었습니다.");
              $("#review-" + reviewIdx).fadeOut(500, function() { $(this).remove(); });
            } else { alert("삭제 실패: " + response.message); }
          },
          error: () => alert("서버 통신 중 오류가 발생했습니다.")
        });
      }
    });

    // 3-4. 나의 무비스토리 - 수정 버튼
    mainContent.on("click", ".btn-update", function() {
      const reviewIdx = $(this).data("review-idx");
      const rating = $(this).data("rating");
      const comment = $(this).data("comment");

      const dialog = $("#review-edit-dialog");
      dialog.find("#edit-review-idx").val(reviewIdx);
      dialog.find("#edit-rating").val(rating);
      dialog.find("#edit-comment").val(comment);

      dialog.dialog({
        autoOpen: true, height: 400, width: 450, modal: true, title: '관람평 수정',
        buttons: {
          "저장": function() { submitReviewUpdate($(this)); },
          "취소": function() { $(this).dialog("close"); }
        }
      });
    });

    // 4. 수정 내용 전송 함수 (3-4에서 호출)
    function submitReviewUpdate(dialogInstance) {
      const reviewIdx = dialogInstance.find("#edit-review-idx").val();
      const updatedRating = dialogInstance.find("#edit-rating").val();
      const updatedComment = dialogInstance.find("#edit-comment").val();

      $.ajax({
        url: `${cp}/Controller?type=updateReview`,
        type: "POST",
        data: { reviewIdx, rating: updatedRating, comment: updatedComment },
        dataType: "json",
        success: (response) => {
          if (response.success) {
            alert("관람평이 수정되었습니다.");
            const reviewItem = $("#review-" + reviewIdx);
            reviewItem.find(".rating-display").text("평점 ★ " + updatedRating);
            reviewItem.find(".comment-display").text(updatedComment);
            reviewItem.find(".btn-update").data({ rating: updatedRating, comment: updatedComment });
            dialogInstance.dialog("close");
          } else { alert("수정 실패: " + response.message); }
        },
        error: () => alert("서버 통신 중 오류가 발생했습니다.")
      });
    }
  });
</script>
</body>
</html>
