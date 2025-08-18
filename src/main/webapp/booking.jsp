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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                  <c:when test="${fn:startsWith(dayStr, '0')}">
                    <button type="button" class="btn date-btn" onclick="selectDate(this, '${dvo.locDate}')">${fn:substring(dayStr, 1, 2)}&nbsp;${fn:substring(dvo.dow, 0, 1)}</button>
                    <input type="hidden" value="${dvo.locDate}"/>
                  </c:when>
                  <c:otherwise>
                    <button type="button" class="btn date-btn" onclick="selectDate(this, '${dvo.locDate}')">${dayStr}&nbsp;${fn:substring(dvo.dow, 0, 1)}</button>
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
                    <li class="selected"><a>영화목록</a></li>
                  </ul>
                  <c:set var="timeVO" value="${requestScope.timeArr}" scope="page"/>
                  <c:forEach var="tvo" items="${timeVO}" varStatus="i">
                    <c:if test="${tvo.m_list != null && fn:length(tvo.m_list) > 0}">
                      <div class="movie_all">
                        <c:forEach var="movieVO" items="${tvo.m_list}" varStatus="j">
                          <img src="/images/${movieVO.age}.png"/>
                          <button type="button" class="movie-btn" onclick="selectMovie(this, '${movieVO.mIdx}')">&nbsp;&nbsp;${movieVO.name}</button>
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
                    <li class="selected"><a>지점</a></li>
                  </ul>
                  <c:set var="theaterArr" value="${requestScope.theaterArr}" scope="page"/>

                  <c:if test="${theaterArr != null && fn:length(theaterArr) > 0}">
                    <div class="theater_all">
                      <c:forEach var="theaterVO" items="${theaterArr}" varStatus="i">
                        <button type="button" name="tIdx" id="tIdx${i.index}" class="theater-btn" onclick="selectTheater(this, '${theaterVO.tIdx}')">&nbsp;&nbsp;${theaterVO.tName}</button>
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
                  <button type="button" class="select-btn-style time-btn" onclick="selectTime(this, '${i.index}')">
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
  <form action="Controller" method="post" name="tvo_form">
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

  // 사용자가 선택한 영화의 정보를 갖고 seat.jsp로 이동하는 함수
  function goSeat(tvoIdx){ // 상영예정 idx가 옴
    console.log(tvoIdx)
    <c:if test="${empty sessionScope.mvo && empty sessionScope.kvo}">
    console.log("join")
    document.tvo_form.type = "join";
    document.tvo_form.submit();
    </c:if>
    <c:if test="${not empty sessionScope.mvo}">
    console.log("seat")
    document.tvo_form.tvoIdx.value = tvoIdx;
    document.tvo_form.type = "seat"; // 타입을 seat으로 지정
    document.tvo_form.submit();
    </c:if>
  }

  // 날짜 선택 함수 (수정됨)
  function selectDate(selectedBtn, date) {
    console.log("선택된 날짜:", date);

    // 모든 날짜 버튼에서 selected-btn 클래스 제거
    document.querySelectorAll('.date-btn').forEach(btn => {
      btn.classList.remove('selected-btn');
    });

    // 선택된 버튼에 selected-btn 클래스 추가
    selectedBtn.classList.add('selected-btn');

    // 폼에 값 설정
    document.ff.date.value = date;

    // 시간표 초기화 (날짜가 변경되면 기존 시간표를 지움)
    document.querySelector("#date-box .date-box-in").innerHTML = "";
  }

  // 영화 선택 함수 (새로 추가됨)
  function selectMovie(selectedBtn, movieIdx) {
    console.log("선택된 영화:", movieIdx);

    // 모든 영화 버튼에서 selected-btn 클래스 제거
    document.querySelectorAll('.movie-btn').forEach(btn => {
      btn.classList.remove('selected-btn');
    });

    // 선택된 버튼에 selected-btn 클래스 추가
    selectedBtn.classList.add('selected-btn');

    // 폼에 값 설정
    document.ff.mIdx.value = movieIdx;

    // 시간표 초기화 (영화가 변경되면 기존 시간표를 지움)
    document.querySelector("#date-box .date-box-in").innerHTML = "";
  }

  // 극장 선택 함수 (수정됨)
  function selectTheater(selectedBtn, theaterIdx) {
    console.log("선택된 극장:", theaterIdx);

    // 입력 검증
    if(document.ff.date.value === ""){
      alert("날짜를 선택하세요");
      return;
    }else if(document.ff.mIdx.value === ""){
      alert("영화를 선택하세요");
      return;
    }

    // 모든 극장 버튼에서 selected-btn 클래스 제거
    document.querySelectorAll('.theater-btn').forEach(btn => {
      btn.classList.remove('selected-btn');
    });

    // 선택된 버튼에 selected-btn 클래스 추가
    selectedBtn.classList.add('selected-btn');

    // 폼에 값 설정
    document.ff.tIdx.value = theaterIdx;

    // AJAX로 시간표 조회
    $.ajax({
      url: "Controller?type=theaterShow",
      type: "post",
      data: {
        date: document.ff.date.value,
        mIdx: document.ff.mIdx.value,
        tIdx: document.ff.tIdx.value
      }
    }).done(function (res) {
      console.log("응답:", res);
      $("#date-box .date-box-in").html(res);
    }).fail(function(xhr, status, error) {
      console.log("Ajax 실패!");
      console.log("상태:", status);
      console.log("에러:", error);
      console.log("응답 텍스트:", xhr.responseText);
    });
  }

  // 시간 선택 함수 (새로 추가됨)
  function selectTime(selectedBtn, timeValue) {
    console.log("선택된 시간:", timeValue);

    // 모든 시간 버튼에서 selected-btn 클래스 제거
    document.querySelectorAll('.time-btn').forEach(btn => {
      btn.classList.remove('selected-btn');
    });

    // 선택된 버튼에 selected-btn 클래스 추가
    selectedBtn.classList.add('selected-btn');

    // 보여지고 있는 버튼들 중에서 사용자가 선택한 시간에 상영중인 영화만 보여줘야함 <div> 숨김처리 하기

  }
</script>

<jsp:include page="common/Footer.jsp"/>

</body>

</html>