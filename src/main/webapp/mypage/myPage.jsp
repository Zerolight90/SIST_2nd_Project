<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

  <title>마이페이지</title>
  <link rel="stylesheet" href="${cp}/css/reset.css">
  <link rel="stylesheet" href="${cp}/css/sub/sub_page_style.css">
  <link rel="stylesheet" href="${cp}/css/mypage.css">
  <link rel="icon" href="${cp}/images/favicon.png">
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
        <li><a href="${cp}/Controller?type=myReservation" target="contentFrame" class="nav-link active">예매/구매내역</a></li>
        <li><a href="${cp}/Controller?type=myCoupon" target="contentFrame" class="nav-link">제휴쿠폰</a></li>
        <li><a href="${cp}/Controller?type=myPoint" target="contentFrame" class="nav-link">멤버십 포인트</a></li>
        <li><a href="${cp}/Controller?type=myMovieStory" target="contentFrame" class="nav-link">나의 무비스토리</a></li>
        <li><a href="${cp}/Controller?type=myUserInfo" target="contentFrame" class="nav-link">회원정보</a></li>
      </ul>
    </nav>


    <c:choose>

      <c:when test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
        <%-- 추가 정보 입력 다이얼로그와 내 정보수정 화면 --%>
        <div id="dialog">
          <p>
            카카오 간편 가입 회원은<br>
            전화번호·생년월일 등 추가 정보를 입력해야<br>
            모든 마이페이지 기능을 사용하실 수 있습니다.
          </p>
        </div>

        <main class="main-content">
          <iframe name="contentFrame" src="<c:url value='/Controller?type=myUserInfo'/>" frameborder="0" style="width:100%; height:100%;"></iframe>
        </main>
      </c:when>
      <c:otherwise>

        <%-- (일반 회원 or 추가정보 모두 입력된 카카오 회원) --%>
        <main class="main-content">
          <iframe name="contentFrame" src="<c:url value='/Controller?type=myReservation'/>" frameborder="0" style="width:100%; height:100%;"></iframe>
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
    let option = {
      modal: true, autoOpen: false,
      title: '추가 정보 입력 안내',
      width: 450, height: 250, resizable: false,
      buttons: {
        "확인": function() { $(this).dialog("close"); }
      }
    };

    $("#dialog").dialog(option);

    // JSP 변수값에 따라 다이얼로그 열기
    <c:if test="${not empty sessionScope.kvo && (empty sessionScope.mvo || empty sessionScope.mvo.birth || empty sessionScope.mvo.phone)}">
    $("#dialog").dialog("open");
    </c:if>
  });


  document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.side-nav .nav-link');
    navLinks.forEach(link => {
      link.addEventListener('click', function() {
        navLinks.forEach(l => l.classList.remove('active'));
        this.classList.add('active');
      });
    });
  });
</script>

</body>
</html>
