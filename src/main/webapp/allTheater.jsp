<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./css/theater.css">
  <link rel="stylesheet" href="./css/sub/sub_page_style.css">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/tab.css">
  <%--<link rel="stylesheet" href="./css/board.css">--%>
  <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">--%> <!--폰트어썸 css 라이브러리-->
  <%--<link rel="icon" href="./images/favicon.png">--%>
  <%--<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>--%>

  <style>
    .parking-info .parking-section .icon-box .ico-parking {
      width: 67px;
      height: 57px;
      background-image: url("./images/ico/ico-parking.png");
    }

    .parking-info .parking-section .icon-box .ico-parking-confirm {
      width: 70px;
      height: 63px;
      background-image: url("./images/ico/ico-confirm.png");
    }

    .parking-info .parking-section .icon-box .ico-cash {
      width: 70px;
      height: 68px;
      background-image: url("./images/ico/ico-cash.png");
    }

    .parking-info .transportation-section .icon-box .ico-bus {
      width: 67px;
      height: 70px;
      background-image: url("./images/ico/ico-bus.png");
    }

    .parking-info .transportation-section .icon-box .ico-metro {
      width: 70px;
      height: 68px;
      background-image: url("./images/ico/ico-metro.png");
    }

    .public-transportation .transportation-section .icon-box {
      position: absolute;
      top: 30px;
      left: 0;
      width: 150px;
      text-align: center;
    }

    .public-transportation .transportation-section .info {
      padding-left: 150px;
    }

    .iconset {
      overflow: hidden;
      display: inline-block;
      margin: -1px 0 0 0;
      padding: 0;
      font-size: 0;
      line-height: 0;
      vertical-align: middle;
      background-position: 0 0;
      background-repeat: no-repeat;
    }

    .parking-info .parking-section .info {
      padding-left: 150px;
    }

    .parking-info .parking-section .icon-box {
      position: absolute;
      top: 30px;
      left: 0;
      width: 150px;
      text-align: center;
    }

    .parking-info .parking-section {
      min-height: 85px;
      padding: 30px 0 0 0;
      position: relative;
    }

    .dot-list li {
      list-style: disc;
    }


    .public-transportation {
      border: 1px solid #d8d9db;
      border-radius: 10px;
    }

    .parking-info {
      border: 1px solid #d8d9db;
      border-radius: 10px;
    }

    .public-transportation .transportation-section {
      position: relative;
      padding: 30px 0 0 0;
      min-height: 100px;
      padding: 30px 0 0 0;
      position: relative;
    }



    /*추가*/

    .event-list{
      height: 365px;
    }

    .event-list ul li {
      position: relative;
      float: left;
      width: 245px;
      margin: 0 0 0 40px;
      padding: 0;
    }

    /*1,5,9,, 번째 게시물 margin:0 주기*/
    .event-list ul li:nth-child(4n + 1) {
      margin:0;
    }

    /*5번째 게시물부터 위 간격주기*/
    .event-list ul li:nth-child(n + 5) {
      margin-top: 60px;
    }

    .event-list ul li a {
      overflow: hidden;
      display: block;
      border: 1px solid #e4e4e4;
      border-radius: 10px;
      min-height: 364px;
    }
    .event-list ul li a .img {
      width: 100%;
      height: 244px;
      font-size: 0;
      line-height: 0;
      border-bottom: 1px solid #e4e4e4;
      background-color: #eee;
    }

    .event-list ul li a .img img {
      width: 100% !important;
      height: 243px !important;
    }

    .event-list ul li a .tit {
      overflow: hidden;
      height: 60px;
      margin: 0 0 10px 0;
      padding: 20px 17px 0 17px;
      line-height: 1.3;
      font-weight: 700;
      color: #222;
      display: block !important;
    }

    .event-list ul li a .date {
      padding: 0 17px 20px 17px;
      font-size: .8667em;
      line-height: 1.1;
      color: #666;
    }

    .event-list p {
      display: block;
      margin: 0;
      padding: 0;
    }



  </style>
</head>

<body>

<header>
  <jsp:include page="/common/sub_menu.jsp"/>
</header>
<article>
  <div>

    <div class="topBox">
      <div class="theaterTopBox">
        <div class="location">
          <span>Home</span>
          &nbsp;>&nbsp;
          <span>극장</span>
          >
          <a href="Controller?type=allTheater">전체극장</a>
        </div>
      </div>
    </div>
    <c:set var="theater" value="${requestScope.theater}"/>
    <%--상단 이미지 + 지점명--%>
    <div class="theater-detail-page">
      <div class="img">
        <p>${theater.tName}</p>
        <%--<button type="button">선호극장</button>--%>
      </div>
    </div>

    <%--컨텐츠 시작--%>
    <div class="inner-wrap">
      <div class="ec-base-tab typeLight m50 w368">
        <ul class="menu" style="font-size: 16px;">
          <li class="selected"><a href="#none">극장정보</a></li>
          <li><a href="#none">상영시간표</a></li>
          <li><a href="#none">관람료</a></li>
        </ul>
      </div>
      <!-- 비동기식 페이지 전환 : 라인형-->
      <div class="ec-base-tab typeLight eTab">

        <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px">
          <div style="width: 1100px; margin-top: 10px; display: flex">
            <!--영화관 상세정보 영역-->
            <div id="theaterDetails">
              <div class="inner-wrap">
                <div class="theater-info-text m50">
                  <p class="big">
                    ${theater.tInfo}<br>
                  </p>
                  <hr>
                  <p></p>
                </div>
                <hr>
                <!--시설안내-->
                <div class="event-box m70">
                  <h2 class="theater traffic">시설안내</h2>
                </div>

                <!--보유시설-->
                <div class="theater-floor-info">
                <h3 class="small-tit m15">보유시설</h3>
                  <ul>
                    <c:forEach var="facility" items="${requestScope.facilitiesArr}">
                      <li>
                        <div class="sisul-img-info">
                          <div>
                            <c:if test="${fn:contains(facility, '일반상영관')}">
                              <img src="./images/ico/ico-facility-theater.png" alt="일반상영관"/>
                            </c:if>
                            <c:if test="${fn:contains(facility, '장애인석')}">
                              <img src="./images/ico/ico-facility-disabled.png" alt="장애인석"/>
                            </c:if>
                            <c:if test="${fn:contains(facility, '부티크')}">
                              <img src="./images/ico/ico-facility-boutique3.png" alt="부티크"/>
                            </c:if>
                            <c:if test="${fn:contains(facility, '스위트룸')}">
                              <img src="./images/ico/ico-facility-sweet.png" alt="스위트룸"/>
                            </c:if>
                            <c:if test="${fn:contains(facility, '컴포트')}">
                              <img src="./images/ico/ico-facility-comfort.png" alt="컴포트"/>
                            </c:if>
                            <c:if test="${fn:contains(facility, '스페셜')}">
                              <img src="./images/ico/ico-facility-special.png" alt="스페셜"/>
                            </c:if>
                            <c:if test="${fn:contains(facility, '커플석')}">
                              <img src="./images/ico-facility-theater-couple.png" alt="커플석"/>
                            </c:if>
                          </div>
                          <div class="tFacilities_text">${facility}</div>
                        </div>
                      </li>
                    </c:forEach>
                  </ul>
                </div>

                <!--층별안내-->
                <div class="theater-floor-info">
                  <h3 class="small-tit m15">층별안내</h3>
                  <ul>
                    <c:forEach var="floor" items="${requestScope.floorInfoArr}">
                      <li>${floor}</li>
                    </c:forEach>
                  </ul>
                </div>

                <!--교통-->
                <div class="theater-traffic-info">
                  <div class="event-box m70">
                    <h2 class="theater traffic">교통안내</h2>
                  </div>
                  <h3 class="small-tit m30">주소</h3>
                  <p>${theater.tAddress}<%--&nbsp;<button>주소 복사</button>--%></p>

                  <%--카카오맵--%>
                  <h3 class="small-tit m30">지도</h3>
                  <div id="map" style="width:500px; height:400px; border:1px solid purple;">
                  </div>

                  <%--주차안내--%>
                  <h3 class="small-tit m50">주차</h3>
                  <div class="parking-info">

                    <div class="parking-info">
                      <div class="parking-section">
                        <div class="icon-box"><i class="iconset ico-parking" title="주차안내">주차안내</i></div>

                        <div class="info">
                          <p class="parking-tit">주차안내</p>

                          <ul class="dot-list">
                            <c:forEach var="tParkingInfoArr" items="${requestScope.tParkingInfoArr}">
                              <li>${tParkingInfoArr}</li>
                            </c:forEach>
                          </ul>
                        </div>
                      </div>



                      <div class="parking-section">
                        <div class="icon-box"><i class="iconset ico-parking-confirm" title="주차확인">주차확인</i></div>

                        <div class="info">
                          <p class="parking-tit">주차확인</p>

                          <ul class="dot-list">

                            <c:forEach var="tParkingChkArr" items="${requestScope.tParkingChkArr}">
                              <li>${tParkingChkArr}</li>
                            </c:forEach>

                          </ul>
                        </div>
                      </div>



                      <div class="parking-section mtb30">
                        <div class="icon-box"><i class="iconset ico-cash" title="주차요금">주차요금</i></div>

                        <div class="info">
                          <p class="parking-tit">주차요금</p>

                          <ul class="dot-list">
                            <c:forEach var="tParkingPriceArr" items="${requestScope.tParkingPriceArr}">
                              <li>${tParkingPriceArr}</li>
                            </c:forEach>
                          </ul>
                        </div>
                      </div>

                    </div>

                  </div>



                  <h3 class="small-tit m50">대중교통</h3>
                  <div class="parking-info" >
                  <div class="public-transportation">

                    <!-- 버스 정보 -->

                    <div class="transportation-section">
                      <div class="icon-box"><i class="iconset ico-bus" title="버스">버스</i></div>

                      <div class="info">
                        <p class="parking-tit">버스</p>
                        <ul class="dot-list">
                            <c:forEach var="tBusRouteToTheaterArr" items="${requestScope.tBusRouteToTheaterArr}">
                              <li>${tBusRouteToTheaterArr}</li>
                            </c:forEach>
                        </ul>
                      </div>
                    </div>


                    <!-- 지하철 정보 -->

                    <div class="transportation-section mtb30">
                      <div class="icon-box"><i class="iconset ico-metro" title="지하철">지하철</i></div>

                      <div class="info">
                        <p class="parking-tit">지하철</p>
                        <ul class="dot-list">

                          <c:forEach var="tSubwayRouteToTheaterArr" items="${requestScope.tSubwayRouteToTheaterArr}">
                            <li>${tSubwayRouteToTheaterArr}</li>
                          </c:forEach>

                        </ul>
                      </div>
                    </div>
                  </div>


                  </div>
                </div>

                <c:choose>
                  <c:when test="${theater.bvo_list eq '' or theater.bvo_list eq null }">
                  </c:when>
                  <c:otherwise>  <!-- 0으로 시작하지 않으면 모두 보여준다 -->

                    <!--이벤트-->
                    <div class="theater-event-info">
                      <div class="event-box m70"></div>
                      <h2 class="theater event">이벤트</h2>
                      <span class="more notice"><a href="Controller?type=userEventBoardList">더보기 ></a></span>
                    </div>

                  <div class="event-list m30">
                    <ul>
                     <c:set var="theaterCount" value="0"/>
                      <c:forEach var="theaterBoard" items="${theater.bvo_list}" varStatus="i">

                          <c:if test="${fn:contains(theaterBoard.boardType, '이벤트') and theaterCount < 4}">
                            <li>
                              <a href="Controller?type=userViewEventBoard&boardIdx=${theaterBoard.boardIdx}">
                                <p class="img" style="background-image:none;">
                                  <img src="<c:url value='/event_thumbnails/${theaterBoard.thumbnail_url}'/>" alt="${theaterBoard.boardTitle}"/>
                                </p>
                                <p class="tit" style="font-size: 1.2em;">${theaterBoard.boardTitle}</p>
                                <p class="date">${theaterBoard.boardStartRegDate} ~ ${theaterBoard.boardEndRegDate}</p>
                              </a>
                            </li>
                            <c:set var="theaterCount" value="${theaterCount + 1}"/> <%--게시물 하나 표시 후 카운트 증가 --%>
                          </c:if>

                      </c:forEach>
                    </ul>
                  </div>
                  </c:otherwise>
                </c:choose>


                <c:choose>
                <c:when test="${theater.bvo_list eq '' or theater.bvo_list eq null }">
                </c:when>
                <c:otherwise>  <!-- 0으로 시작하지 않으면 모두 보여준다 -->
                <!--공지사항-->
                <div class="theater-notice-info">
                  <div class="theater-notice-title event-box">
                    <h1 class="theater notice-title">극장 공지사항</h1>
                    <span class="more notice"><a href="Controller?type=userBoardList">더보기 ></a></span>
                  </div>
                  <div class="notice-tit">
                    <c:forEach var="theaterBoard" items="${theater.bvo_list}" varStatus="i">
                      <c:if test="${fn:contains(theaterBoard.boardType, '공지사항')}">
                    <button type="button" class="collapsible" onclick="collapse(this);">
                      <div class="notice-tit-list">${theaterBoard.boardTitle}<%--(${fn:substring(theaterBoard.boardEndRegDate, 5, 10)})--%></div>
                      <p class="notice-area">${theater.tName}</p>
                      <p class="notice-date">${fn:substring(theaterBoard.boardStartRegDate, 0, 10)}</p>
                    </button>
                    <div class="content">
                      ${theaterBoard.boardContent}
                    </div>
                      </c:if>
                    </c:forEach>
                  </div>
                </div>

                </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>

        <%--2 상영시간표 탭--%>
        <div id="tabCont1_2" class="tabCont" style="display:none; width: 1100px">
          <div id="theaterPriceInfo">
            <div class="inner-wrap">
              <div class="event-box m70">
                <h2 class="theater price-info-tit">상영시간표</h2>
              </div>

              <!--타임테이블-->
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

              <%-- 영화별로 그룹화하여 표시 --%>
              <c:set var="processedMovies" value=""/>

              <c:forEach var="timeVO" items="${mappingTime}">
                <c:if test="${timeVO.m_list != null and fn:length(timeVO.m_list) > 0}">
                  <c:set var="currentMovie" value="${timeVO.m_list[0].name}"/>

                  <%-- 이미 처리된 영화인지 확인 --%>
                  <c:if test="${not fn:contains(processedMovies, currentMovie)}">

                    <%-- 영화 제목 표시 --%>
                    <div class="show-movie-list">
                      <div class="show-movie">
                        <div class="show-movie-list-title">
                          <img src="/images/${timeVO.m_list[0].age}.png" alt="${timeVO.m_list[0].age}세"/>
                          <span class="title-movie-title">${currentMovie}</span>
                          <p class="information">
                            <span class="show-status">상영중</span>
                            <span class="show-total-time">/상영시간 ${timeVO.m_list[0].runtime}분</span>
                          </p>
                        </div>
                      </div>
                    </div>

                    <%-- 현재 영화의 모든 상영관과 시간 정보 수집 --%>
                    <c:set var="processedScreens" value=""/>

                    <c:forEach var="innerTimeVO" items="${mappingTime}">
                      <c:if test="${innerTimeVO.m_list != null and fn:length(innerTimeVO.m_list) > 0 and
                             innerTimeVO.s_list != null and fn:length(innerTimeVO.s_list) > 0}">

                        <%-- 같은 영화인 경우만 처리 --%>
                        <c:if test="${innerTimeVO.m_list[0].name eq currentMovie}">
                          <c:set var="currentScreen" value="${innerTimeVO.s_list[0].sName}"/>

                          <%-- 이미 처리된 상영관인지 확인 --%>
                          <c:if test="${not fn:contains(processedScreens, currentScreen)}">

                            <%-- 상영관 정보 표시 --%>
                            <div class="show-theater-info">
                              <div class="theater-info">
                                <div class="theater-type">
                                  <p class="screen-name">${currentScreen}</p>
                                  <p class="chair">총 ${innerTimeVO.s_list[0].sCount}석</p>
                                </div>
                                <div class="theater-time">

                                    <%-- 현재 영화, 현재 상영관의 모든 상영 시간 수집 --%>
                                  <c:forEach var="timeSlotVO" items="${mappingTime}">
                                    <c:if test="${timeSlotVO.m_list != null and fn:length(timeSlotVO.m_list) > 0 and
                                           timeSlotVO.s_list != null and fn:length(timeSlotVO.s_list) > 0}">

                                      <%-- 같은 영화, 같은 상영관인 경우 시간 표시 --%>
                                      <c:if test="${timeSlotVO.m_list[0].name eq currentMovie and
                                             timeSlotVO.s_list[0].sName eq currentScreen}">
                                        <div class="time-btn" onclick="selectShowTime('${timeSlotVO.startTime}', '${timeSlotVO.s_list[0].sIdx}', ${timeSlotVO.m_list[0].mIdx})">
                                          <span>${fn:substring(timeSlotVO.startTime, 11, 16)}</span>
                                          <em>${timeSlotVO.s_list[0].sCount - fn:length(timeSlotVO.r_list)}석</em> <!-- 전체좌석수 - 결제된 좌석 수 (남은좌석) -->
                                        </div>
                                      </c:if>
                                    </c:if>
                                  </c:forEach>

                                </div>
                              </div>
                            </div>

                            <%-- 처리된 상영관 목록에 추가 --%>
                            <c:set var="processedScreens" value="${processedScreens},${currentScreen}"/>
                          </c:if>
                        </c:if>
                      </c:if>
                    </c:forEach>

                    <%-- 처리된 영화 목록에 추가 --%>
                    <c:set var="processedMovies" value="${processedMovies},${currentMovie}"/>
                  </c:if>
                </c:if>
              </c:forEach>

              <div class="box-info mtb70">
                <ul class="floor-info">
                  <li>지연입장에 의한 관람불편을 최소화하고자 본 영화는 약 10분 후 시작됩니다.</li>
                  <li>쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</li>
                </ul>
              </div>
            </div>
          </div>

        </div>

        <c:set var="pvo" value="${requestScope.pvo}"/>
        <c:set var="twoD" value="${requestScope.screenTypeArr[0].codeType}"/>
        <c:set var="threeD" value="${requestScope.screenTypeArr[1].codeType}"/>
        <c:set var="fourD" value="${requestScope.screenTypeArr[2].codeType}"/>
        <%--3 영화관람료 탭--%>
        <div id="tabCont1_3" class="tabCont" style="display:none; width: 1100px">
          <div>
            <div id="theaterPriceInfo">
              <div class="inner-wrap">
                <!--영화관람료-->
                <div class="event-box m70">
                  <!--영화관람료 영역-->
                  <div class="event-box">
                    <h2 class="theater price-info-tit">영화관람료</h2>
                  </div>
                  <!--관람료 표-->
                  <div class="table-container">
                    <div class="section">
                      <h3 class="show-li">${requestScope.screenTypeArr[0].screenCode}</h3>
                      <table class="price-table">
                        <thead>
                        <tr>
                          <th>요일</th>
                          <th>상영시간</th>
                          <th>일반</th>
                          <th>청소년</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                          <td rowspan="2">월~목</td>
                          <td>조조 (06:00~10:59)</td>
                          <td>${pvo.normal - pvo.morning + twoD}</td>
                          <td>${pvo.teen - pvo.morning + twoD}</td>
                        </tr>
                        <tr>
                          <td>일반 (11:00~)</td>
                          <td>${pvo.normal + twoD}</td>
                          <td>${pvo.teen + twoD}</td>
                        </tr>
                        <tr>
                          <td rowspan="2">금~일<br>공휴일</td>
                          <td>조조 (06:00~10:59)</td>
                          <td>${pvo.normal - pvo.morning + pvo.week + twoD}</td>
                          <td>${pvo.teen - pvo.morning + pvo.week + twoD}</td>
                        </tr>
                        <tr>
                          <td>일반 (11:00~)</td>
                          <td>${pvo.normal + pvo.week + twoD}</td>
                          <td>${pvo.teen + pvo.week + twoD}</td>
                        </tr>
                        </tbody>
                      </table>
                    </div>

                    <div class="section">
                      <h3 class="show-li">${requestScope.screenTypeArr[1].screenCode}</h3>
                      <table class="price-table">
                        <thead>
                        <tr>
                          <th>요일</th>
                          <th>상영시간</th>
                          <th>일반</th>
                          <th>청소년</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                          <td rowspan="2">월~목</td>
                          <td>조조 (06:00~10:59)</td>
                          <td>${pvo.normal - pvo.morning + threeD}</td>
                          <td>${pvo.teen - pvo.morning + threeD}</td>
                        </tr>
                        <tr>
                          <td>일반 (11:00~)</td>
                          <td>${pvo.normal + threeD}</td>
                          <td>${pvo.teen + threeD}</td>
                        </tr>
                        <tr>
                          <td rowspan="2">금~일<br>공휴일</td>
                          <td>조조 (06:00~10:59)</td>
                          <td>${pvo.normal + threeD}</td>
                          <td>10,000</td>
                        </tr>
                        <tr>
                          <td>일반 (11:00~)</td>
                          <td>${pvo.normal - pvo.morning + pvo.week + threeD}</td>
                          <td>${pvo.teen - pvo.morning + pvo.week + threeD}</td>
                        </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                  <!--극장 요금표 끝-->



                  <!--요금제-->
                  <div class="theater-event-info m50">
                    <h2 class="theater age-info-tit">요금제</h2>
                  </div>
                  <div class="theater-age-info">
                    <div class="event-box m30">
                      <ul class="floor-info">
                        <li class="show-li"><span class="aqua">경로</span>&nbsp;<span>65세 이상 본인에 한함(신분증 확인)</span></li>
                        <li class="show-li"><span class="aqua">청소년 요금</span>&nbsp;<span>7세~19세의 초,중,고 재학생(학생증, 교복, 청소년증, 의료보험증, 주민등록 등/초본, 그 외 청소년 확인 가능 서류)</span></li>
                        <li class="show-li">생후 48개월 미만의 경우 증빙원(예 : 의료보험증, 주민등록 초/등본 등) 지참 시에만 무료 관람 가능</li>
                      </ul>
                    </div>
                  </div>

                  <!--우대적용-->
                  <div class="theater-event-info m50">
                    <h2 class="theater benefit-info-tit">우대적용</h2>
                  </div>
                  <div class="theater-benefit-info">
                    <div class="event-box m30">
                      <ul class="floor-info">
                        <li><span class="aqua">국가유공자</span>&nbsp;<span>현장에서 국가유공자증을 소지한 본인 외 동반 1인까지 적용</span></li>
                        <li><span class="aqua">장애인</span>&nbsp;<span>현장에서 복지카드를 소지한 장애인(중증:동반 1인까지/경증:본인에 한함)</span></li>
                        <li><span class="aqua">미취학아동</span>&nbsp;<span>부모 동반한 생후 48개월부터~6세 까지의 미취학아동 본인(의료보험증, 주민등록 초/등본 확인)</span></li>
                        <li><span class="aqua">소방종사자</span>&nbsp;<span>공무원증을 소지하거나 정복을 입은 소방관 본인</span></li>
                      </ul>
                      <br/><br/>
                      <p class="mtb70">관람 가격 및 시간대 운영은 극장마다 상이할 수 있으며, 상기 가격은 메가박스 ${theater.tName}점에 한하여 적용됩니다.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</article>

<footer>
  <jsp:include page="/common/Footer.jsp"/>
</footer>


<%--카카오 api--%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7e9af1de8ac409c7ec1e76b2d2022b5e&libraries=services"></script>
<%--<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7e9af1de8ac409c7ec1e76b2d2022b5e"></script>--%>
<script>


  // 1. 모든 탭 버튼(li)과 내용 영역(div)을 가져옵니다.
  const tabs = document.querySelectorAll('.menu li');
  const tabContents = document.querySelectorAll('.tabCont');

  // 2. 각 탭 버튼에 클릭 이벤트 리스너를 추가합니다.
  tabs.forEach((tab, index) => {
    tab.addEventListener('click', (e) => {
      // a 태그의 기본 동작(페이지 이동)을 막습니다.
      e.preventDefault();

      // 3. 모든 탭에서 'selected' 클래스를 제거합니다.
      tabs.forEach(item => item.classList.remove('selected'));

      // 4. 방금 클릭한 탭에만 'selected' 클래스를 추가합니다.
      tab.classList.add('selected');

      // 5. 모든 내용 영역을 숨깁니다.
      tabContents.forEach(content => content.style.display = 'none');

      // 6. 클릭한 탭과 순서가 맞는 내용 영역만 보여줍니다.
      tabContents[index].style.display = 'block';
    });
  });

  $(function () {
    $(".tabCont").click(function () {
      var tab_id = $(this).attr("data-tab");

      $(".tabCont").style.display = 'none';
      $(".menu>li").removeClass("selected");

      $(this).addClass("active");
      $("#" + tab_id).addClass("active");
    });
  });


  //카카오지도_주소로 좌표 변환하여 좌표 찍기
  var mapContainer = document.getElementById('map'), // 지도를 표시할 div
          mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
          };

  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  //극장의 주소
  var theaterAddress = '${theater.tAddress}';

  // 주소로 좌표를 검색합니다
  geocoder.addressSearch(theaterAddress , function(result, status) {

    // 정상적으로 검색이 완료됐으면
    if (status === kakao.maps.services.Status.OK) {

      var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

      //좌표 확인용
      //alert(coords);

      // 결과값으로 받은 위치를 마커로 표시합니다
      var marker = new kakao.maps.Marker({
        map: map,
        position: coords
      });

      // 인포윈도우로 장소에 대한 설명을 표시합니다
      var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">메가박스 ${theater.tName}</div>'
      });
      infowindow.open(map, marker);

      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
      map.setCenter(coords);
    }
  });


  function collapse(element) {
    var before = document.getElementsByClassName("active")[0]               // 기존에 활성화된 버튼
    if (before && document.getElementsByClassName("active")[0] != element) {  // 자신 이외에 이미 활성화된 버튼이 있으면
      before.nextElementSibling.style.maxHeight = null;   // 기존에 펼쳐진 내용 접고
      before.classList.remove("active");                  // 버튼 비활성화
    }
    element.classList.toggle("active");         // 활성화 여부 toggle

    var content = element.nextElementSibling;
    if (content.style.maxHeight != 0) {         // 버튼 다음 요소가 펼쳐져 있으면
      content.style.maxHeight = null;         // 접기
    } else {
      content.style.maxHeight = content.scrollHeight + "px";  // 접혀있는 경우 펼치기
    }
  }

  // woojin 영화 목록
  // 상영시간 선택 함수
  function selectShowTime(showTime, screenIdx, movieIdx) {
    // 예매 페이지로 이동하는 로직
    console.log('선택된 상영시간:', showTime, '상영관:', screenIdx, '영화고유번호:' + movieIdx);
    // 실제 예매 페이지로 이동
    location.href = 'Controller?type=booking&throw_mIdx=' + movieIdx
  }

  // 날짜 선택 함수 (기존 inDate 함수 개선)
  function inDate(selectedDate) {
    // 선택된 날짜 버튼 스타일 변경
    const dateButtons = document.querySelectorAll('.date-item .btn');
    dateButtons.forEach(btn => btn.classList.remove('selected-date'));
    event.target.classList.add('selected-date');

    // 해당 날짜의 상영시간표를 다시 로드하려면 여기서 페이지 새로고침 또는 AJAX 호출
    console.log('선택된 날짜:', selectedDate);
    // 필요시 페이지 리로드: location.href = 'Controller?type=allTheater&date=' + selectedDate;
  }



</script>




</body>
</html>