<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./css/sub/sub_page_style.css">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/booking.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  <link rel="icon" href="./images/favicon.png">
</head>
<header>
  <jsp:include page="common/sub_menu.jsp"/>
</header>

<body>
<div>
  <div class="inner-wrap">
    <div class="util-title">
      <h2>빠른예매</h2>
    </div>
    <form action="Controller" method="post">
      <div id="booking-wrap">
        <!-- 상단 날짜영역 -->
        <div class="booking-date">
          <div class="date-container">
            <c:forEach var="dvo" items="${requestScope.dvo_list}" varStatus="i">
              <div class="date-item">
                <c:set var="dayStr" value="${fn:substring(dvo.locDate, 8, 10)}" />
                <c:choose>
                  <c:when test="${fn:startsWith(dayStr, '0')}"> <!-- 0으로 시작하면 마지막 글자만 보여주고 -->
                    <button type="button" class="btn" onclick="inDate(this.nextElementSibling.value)">${fn:substring(dayStr, 1, 2)}&nbsp;${fn:substring(dvo.dow, 0, 1)}</button>
                    <input type="hidden" value="${dvo.locDate}"/>
                  </c:when>
                  <c:otherwise>  <!-- 0으로 시작하지 않으면 모두 보여준다 -->
                    <button type="button" class="btn" onclick="inDate(this.nextElementSibling.value)">${dayStr}&nbsp;${fn:substring(dvo.dow, 0, 1)}</button>
                    <input type="hidden" value="${dvo.locDate}"/>
                  </c:otherwise>
                </c:choose>
              </div>
            </c:forEach>
          </div>
        </div>

        <!-- 중앙의 영화 / 극장 / 시간 영역 -->
        <div id="book-wrap-body">
          <!-- 영화 선택 -->
          <div class="book-box" id="movie-box">
            <h3 class="box-tit">영화</h3>
            <div class="book-main" id="movie-list">
              <div class="main-in">
                <div class="ec-base-tab typeLight eTab">
                  <ul class="menu">
                    <li class="selected"><a href="#" onclick="switchTab(this, 'movie-all')">전체</a></li>
                    <li><a href="#" onclick="switchTab(this, 'movie-curation')">큐레이션</a></li>
                  </ul>
                  <c:set var="timeVO" value="${requestScope.timeArr}" scope="page"/>
                    <c:forEach var="tvo" items="${timeVO}" varStatus="i">
                      <c:if test="${tvo.m_list != null && fn:length(tvo.m_list) > 0}">
                        <div class="movie_all">
                        <c:forEach var="movieVO" items="${tvo.m_list}" varStatus="i">
                            <img src="/images/${movieVO.age}.png"/>
                            <button type="button" onclick="inMovie(this.nextElementSibling.value)">&nbsp;&nbsp;${movieVO.name}</button>
                            <input type="hidden" value="${movieVO.mIdx}"/>
                          <hr/>
                        </c:forEach>
                        </div>
                      </c:if>
                    </c:forEach>

                </div>
              </div>
            </div>
            <div class="book_ft">모든영화<br/>목록에서 영화를 선택하세요.</div>
          </div>

          <!-- 극장 선택 -->
          <div class="book-box" id="theater-box">
            <h3 class="box-tit">극장</h3>
            <div class="book-main" id="theater-list">
              <div class="main-in">
                <div class="ec-base-tab typeLight eTab">
                  <ul class="menu">
                    <li class="selected"><a href="#" onclick="switchTab(this, 'theater-all')">전체</a></li>
<%--                    <li><a href="#" onclick="switchTab(this, 'theater-special')">특별관</a></li>--%>
                  </ul>
                  <c:set var="theaterArr" value="${requestScope.theaterArr}" scope="page"/>

                  <c:if test="${theaterArr != null && fn:length(theaterArr) > 0}">
                  <div class="theater_all">
                    <c:forEach var="theaterVO" items="${theaterArr}" varStatus="i">
                      <button type="button" name="tIdx" id="tIdx${i.index}">&nbsp;&nbsp;${theaterVO.tName}</button>
                      <input type="hidden" value="${theaterVO.tIdx}">
                    </c:forEach>
                  </div>
                  </c:if>

                </div>
              </div>
            </div>
            <div class="book_ft">전체극장<br/>목록에서 극장을 선택하세요.</div>
          </div>

          <!-- 시간 선택 -->
          <div id="date-box">
            <h3 class="date-box-tit">시간</h3>
            <div class="select-time">
              <button type="button" onclick="left_btn_click()">
                <
              </button>
              <div id="time-container">
              <c:forEach var="date" begin="0" end="24" varStatus="i">
                <button class="select-btn-style">
                  <c:if test="${i.index < 10}">
                    0${i.index}
                  </c:if>
                  <c:if test="${i.index >= 10}">
                    ${i.index}
                  </c:if>
                </button>
                <input type="hidden" value="${i.index}">
              </c:forEach>
              </div>
              <button type="button" onclick="right_btn_click()">
                >
              </button>
            </div>
            <div class="date-box-in">
              <!-- 비동기식 통신으로 res 가 들어갈 곳 -->
            </div>
          </div>
        </div>
      </div>

        <!-- 광고영역 -->
        <div class="book-add">
          <span>광고배너</span>
        </div>
    </form>
  </div>
</div>

<div class="booking-data" style="display: none">
  <form action="Controller" method="post" name="ff">
    <input type="hidden" name="date" id="form_date" value=""/>
    <input type="hidden" name="mIdx" id="form_mIdx" value=""/>
    <input type="hidden" name="tIdx" id="form_tIdx" value=""/>
  </form>
</div>

<div class="booking-data" style="display: none">
  <form action="Controller?type=seat" method="post" name="tvo_form">
    <input type="hidden" name="tvoIdx" id="tvoIdx" value=""/>
  </form>
</div>

<script>
  let currentCenterIndex = new Date().getHours(); // 현재 시간
  const range = 4; // 양쪽 범위
  const buttons = document.querySelectorAll("#time-container button");

  // 특정 index를 중심으로 보여주는 함수
  function showRange(centerIndex) {
    buttons.forEach(btn => btn.style.display = "none");

    for (let i = centerIndex - range; i <= centerIndex + range; i++) {
      if (i >= 0 && i < buttons.length) {
        buttons[i].style.display = "inline-block";
      }
    }
  }

  function left_btn_click() {
    if (currentCenterIndex > 0) {
      currentCenterIndex--;
      showRange(currentCenterIndex);
    }
  }

  function right_btn_click() {
    if (currentCenterIndex < buttons.length - 1) {
      currentCenterIndex++;
      showRange(currentCenterIndex);
    }
  }

  // 초기 실행
  document.addEventListener("DOMContentLoaded", () => {
    showRange(currentCenterIndex);
  });

  function goSeat(tvoIdx){ // 상영예정 idx가 옴
    console.log(tvoIdx)
    document.tvo_form.tvoIdx.value = tvoIdx;
    document.tvo_form.submit();
  }

  function inDate(date) {
    console.log(date);
    document.ff.date.value = date;
  }

  function inMovie(movie) {
    console.log(movie);
    document.ff.mIdx.value = movie;
  }

  $(function (){
    $("#theater-list .theater_all button").click(function (){
      let v1 = $(this.nextElementSibling).val();
      console.log(v1);
      if(document.ff.date.value === ""){
        alert("날짜를 선택하세요")
        return;
      }else if(document.ff.mIdx.value === ""){
        alert("영화를 선택하세요")
        return;
      }
      document.ff.tIdx.value = v1;
      $.ajax({
        url: "Controller?type=theaterShow",
        type: "post",
        data: {date: $("#form_date").val(), mIdx: $("#form_mIdx").val(), tIdx: $("#form_tIdx").val()}
      }).done(function (res) {
        console.log("응답 :"+res); <!-- res의 담긴 값을 보기 위한 console.log -->
        <!-- res에는 all.jsp에서 반복문이 구동되어 쌓인 결과가 저장되고 -->
        $("#date-box .date-box-in").html(res); <!-- res에 담긴 <tr>태그들을 "table.table>tbody"의 자리에 넣어준다 -->
      }).fail(function(xhr, status, error) {
        console.log("Ajax 실패!");
        console.log("상태:", status);
        console.log("에러:", error);
        console.log("응답 텍스트:", xhr.responseText);
      });
    });
  });
</script>

<jsp:include page="common/Footer.jsp"/>

</body>

</html>