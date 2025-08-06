<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav>
      <div class="dashLeft">
        <div class="leftDiv">
          <p class="bold">대시보드</p>
          <div class="leftDivInner"><a href="Controller?type=statisticalchart">통계 차트</a></div>
        </div>
    <div class="leftDiv">
      <p class="bold">사용자 관리</p>
      <div class="leftDivInner"><a href="Controller?type=admin">회원 정보 관리</a></div>
      <div class="leftDivInner"><a href="Controller?type=nmemInfo">비회원 정보 관리</a></div>
    </div>
    <div class="leftDiv">
      <p class="bold">영화 관리</p>
      <div class="leftDivInner"><a href="Controller?type=movieInfo">영화 정보 관리</a></div>
      <div class="leftDivInner"><a href="Controller?type=playingInfo">영화 상영 관리</a></div>
    </div>
    <div class="leftDiv">
      <p class="bold">극장 관리</p>
      <div class="leftDivInner"><a href="Controller?type=thscInfo">극장 / 상영관 관리</a></div>
    </div>
    <div class="leftDiv">
      <p class="bold">상품 관리</p>
      <div class="leftDivInner"><a href="javascript:prodInfo()">상품 정보 관리</a></div>
    </div>
    <div class="leftDiv">
      <p class="bold">결제 관리</p>
      <div class="leftDivInner"><a href="Controller?type=adminPaymentInfo">결제 내역 관리</a></div>
    </div>
    <div class="leftDiv">
      <p class="bold">게시판 관리</p>
      <div class="leftDivInner"><a href="">공지 / 이벤트 관리</a></div>
    </div>
    <div class="leftDiv">
      <p class="bold">쿠폰 관리</p>
      <div class="leftDivInner"><a href="">쿠폰 정보 관리</a></div>
    </div>
    <div class="leftDiv">
      <p class="bold">시스템 관리</p>
      <div class="leftDivInner"><a href="Controller?type=adminList">관리자 권한 관리</a></div>
      <div class="leftDivInner"><a href="Controller?type=adminLog">관리자 / 사용자 로그 관리</a></div>
    </div>
  </div>

  <script>
    function movieInfo() {
      $.ajax({
        url:"adminMovie.jsp",
        type: "post"
      }).done(function (result) {
        $("#ajax").children().remove();
        $("#ajax").html(result);
      });
    }

    function playingInfo() {
      $.ajax({
        url:"adminTimetable.jsp",
        type: "post"
      }).done(function (result) {
        $("#ajax").children().remove();
        $("#ajax").html(result);
      });
    }

    function tsInfo() {
      $.ajax({
        url:"adminTheaterScreen.jsp",
        type: "post"
      }).done(function (result) {
        $("#ajax").children().remove();
        $("#ajax").html(result);
      });
    }

    function prodInfo() {
      $.ajax({
        url:"adminProdList.jsp",
        type: "post"
      }).done(function (result) {
        $("#ajax").children().remove();
        $("#ajax").html(result);
      });
    }

    function nmemInfo() {
      $.ajax({
        url:"adminNmem.jsp",
        type: "post"
      }).done(function (result) {
        $("#ajax").children().remove();
        $("#ajax").html(result);
      });
    }

    function paymentInfo() {
      $.ajax({
        url:"adminPayment.jsp",
        type: "post"
      }).done(function (result) {
        $("#ajax").children().remove();
        $("#ajax").html(result);
      });
    }
  </script>

</nav>