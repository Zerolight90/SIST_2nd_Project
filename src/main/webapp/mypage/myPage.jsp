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
    <c:if test="${not empty sessionScope.mvo}">
      <main class="main-content">
        <iframe name="contentFrame" src="${cp}/Controller?type=myReservation" frameborder="0" style="width:100%; height:100%;"></iframe>
      </main>
    </c:if>

    <c:if test="${not empty sessionScope.kvo && empty sessionScope.mvo}">
      <div id="dialog">
        <p>
          추가 정보를 입력하셔야
          더 많은 기능을 이용하실 수 있습니다.
        </p>
      </div>
      <main class="main-content">
        <iframe name="contentFrame" src=<c:url value="/Controller?type=myUserInfo"/> frameborder="0" style="width:100%; height:100%;"></iframe>
      </main>
    </c:if>

  </div>
</article>

<%-- 공통 푸터 --%>
<footer>
  <jsp:include page="../common/Footer.jsp"/>
</footer>

<script>
  $(function() {
    let option = {
      modal: true,
      autoOpen: false, // 이 부분은 유지하여 초기 자동 열림 방지
      title: '정보 안내', // 제목을 좀 더 명확하게 변경했습니다.
      width: 450,
      height: 300,
      resizable: false,
      buttons: { // '확인' 버튼 추가
        "확인": function() {
          $(this).dialog("close");
        }
      }
    };

    $("#dialog").dialog(option); // 다이얼로그창 등록

    // 특정 조건 (sessionScope.kvo가 있고 sessionScope.mvo가 없을 때)에서만 다이얼로그를 엽니다.
    // JSP 변수 값을 JavaScript로 넘겨 조건문을 사용합니다.
    <c:if test="${not empty sessionScope.kvo && empty sessionScope.mvo}">
    $("#dialog").dialog("open"); // 조건이 충족될 때 다이얼로그를 엽니다.
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
