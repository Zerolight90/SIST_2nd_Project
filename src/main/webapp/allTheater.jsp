<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./css/sub/sub_page_style.css">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/tab.css">
  <link rel="stylesheet" href="./css/theater.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <link rel="icon" href="./images/favicon.png">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>

<body>

<header>
  <jsp:include page="common/sub_menu.jsp"/>
</header>

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
  <%--상단 이미지 + 지점명--%>
  <div class="theater-detail-page">
    <div class="img">
      <p>더부티크 목동 현대 백화점</p>
      <button type="button">선호극장</button>
    </div>
  </div>

  <%--컨텐츠 시작--%>
  <div class="inner-wrap">
    <div class="ec-base-tab typeLight m50">
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
                  강동구청역 도보 5분, 전 좌석 가죽시트로 쾌적하고 편안하게! 언제나 즐거운 우리동네 극장<br>
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
                <div class="sisul-img-info">
                  <p><i class="icon"></i>일반상영관</p>
                </div>
              </div>
              <!--층별안내-->
              <div class="theater-floor-info">
                <h3 class="small-tit m15">층별안내</h3>

                <div class="sisul-floor-info">
                  <ul class="floor-info">
                    <li>1층 : 매표소, 매점, 무인 발권기, 로비, 엘리베이터, 남·여 화장실, 남·여 장애인 화장실, 캡슐 토이, 투썸 플레이스</li>
                    <li>2층 : 1관·2관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</li>
                    <li>4층 : 3관·4관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</li>
                    <li>6층 : 5관~10관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</li>
                  </ul>
                </div>
              </div>



              <!--교통-->
              <div class="theater-traffic-info">
                <div class="event-box m70">
                  <h2 class="theater traffic">교통안내</h2>
                </div>
                <h3 class="small-tit m30">지도</h3>
                <p>도로명주소: 서울특별시 강동구 성내로 48 <button>주소 복사</button></p>

                <%--카카오맵--%>
                <div id="map" style="width:500px; height:400px; border:1px solid purple;">

                </div>
                <h3 class="small-tit m50">주차</h3>
                <div class="parking-info" style="width:1100px; height: 400px; border:1px solid gray; border-radius: 10px;">

                </div>
                <h3 class="small-tit m50">대중교통</h3>
                <div class="parking-info" style="width:1100px; height: 400px; border:1px solid gray; border-radius: 10px;">

                </div>
              </div>

              <!--이벤트-->
              <div class="theater-event-info">
                <div class="event-box m70"></div>
                <h2 class="theater event">이벤트</h2>
              </div>
              <div id="event_img" style="display:flex;">
                <ul>
                  <li>
                    <a href="#">
                      <img src="https://img.megabox.co.kr/SharedImg/event/2025/03/06/PVMGaYqtdK3P4P21GOpErZRPDr7HXdFv.jpg" alt="강동점 굿즈">
                    </a>
                  </li>
                </ul>
              </div>


              <!--공지사항-->
              <div class="theater-notice-info" style="border:1px solid red; width:1100px; height:400px;">
                <h2 class="theater notice m70">공지사항</h2>

                <div class="notice-tit">
                  <button type="button" class="collapsible" onclick="collapse(this);">
                    <div class="notice-tit-list">[강동] 전관 대관 행사 진행에 따른 고객 안내(7/26)</div>
                    <p class="notice-area">강동</p>
                    <p class="notice-date">2025.06.24</p>
                  </button>
                  <div class="content">
                    내용입니다~~~~~~~~
                  </div>
                  <button type="button" class="collapsible" onclick="collapse(this);">
                    <div class="notice-tit-list">[강동] 진행에 따른 고객 안내(7/26)</div>
                    <p class="notice-area">강동</p>
                    <p class="notice-date">2025.06.24</p>
                  </button>
                  <div class="content">
                    내용입니다~~~~~~~~ 2번쨰 내용입니다.
                  </div>
                </div>
              </div>
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
            <div>

            </div>


            <br/><br/><br/><br/><br/>

            <!--영화정보, 관란등급안내-->
            <!--영화 정보-->
            <div class="show-movie-list">
              <div class="show-movie">
                <div class="title">
                  <p class="movie-grade age-12">12</p>
                  <span class="movie-title">판타스틱4:새로운 출발</span>
                  <p class="information">
                    <span class="show-status">상영중</span>
                    <span class="show-total-time">/상영시간 114분</span>
                  </p>
                </div>

                <div class="show-theater-info">
                  <div class="theater-info">
                    <div class="theater-type">
                      <p class="theater-name">컴포트 101호 [Laser]</p>
                      <p class="chair">총 154석</p>
                    </div>
                    <div class="theater-time">
                      <div class="theater-type-area">2D</div>
                      <div class="theater-time-box">
                        <!-- div로 표현하는 방식 -->
                        <div class="time-btn"><span>17:15</span><em>102석</em></div>
                        <div class="time-btn"><span>19:40</span><em>68석</em></div>
                        <div class="time-btn"><span>22:05</span><em>105석</em></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="box-info mtb70">
              <ul class="floor-info">
                <li>지연입장에 의한 관람불편을 최소화하고자 본 영화는 약 10분 후 시작됩니다.</li>
                <li>쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</li>
              </ul>
            </div>
          </div>
        </div>

      </div>

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
                    <h3 class="show-li">2D</h3>
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
                        <td>조조 (06:00~)</td>
                        <td>9,000</td>
                        <td>8,000</td>
                      </tr>
                      <tr>
                        <td>일반 (11:01~)</td>
                        <td>13,000</td>
                        <td>10,000</td>
                      </tr>
                      <tr>
                        <td rowspan="2">금~일<br>공휴일</td>
                        <td>조조 (06:00~)</td>
                        <td>9,000</td>
                        <td>8,000</td>
                      </tr>
                      <tr>
                        <td>일반 (11:01~)</td>
                        <td>14,000</td>
                        <td>11,000</td>
                      </tr>
                      </tbody>
                    </table>
                  </div>

                  <div class="section">
                    <h3 class="show-li">3D</h3>
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
                        <td>조조 (06:00~)</td>
                        <td>11,000</td>
                        <td>10,000</td>
                      </tr>
                      <tr>
                        <td>일반 (11:01~)</td>
                        <td>15,000</td>
                        <td>12,000</td>
                      </tr>
                      <tr>
                        <td rowspan="2">금~일<br>공휴일</td>
                        <td>조조 (06:00~)</td>
                        <td>11,000</td>
                        <td>10,000</td>
                      </tr>
                      <tr>
                        <td>일반 (11:01~)</td>
                        <td>16,000</td>
                        <td>13,000</td>
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
                    <p class="mtb70">관람 가격 및 시간대 운영은 극장마다 상이할 수 있으며, 상기 가격은 메가박스 **점에 한하여 적용됩니다.</p>
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

<footer>
  <jsp:include page="common/Footer.jsp"/>
</footer>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7e9af1de8ac409c7ec1e76b2d2022b5e"></script>
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

  // 카카오 지도
  // 지금 브렌치는 선영이 작성하고 있는 내용입니다.
  var container = document.getElementById('map');
  var options = {
    center: new kakao.maps.LatLng(37.5284455288195, 127.125357402766), //위도, 경도
    level: 3
  };

  var map = new kakao.maps.Map(container, options);


  // 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다
  var points = [
    new kakao.maps.LatLng(37.5284455288195, 127.125357402766)
  ];

  // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
  var bounds = new kakao.maps.LatLngBounds();

  var i, marker;
  for (i = 0; i < points.length; i++) {
    // 마커를 생성
    marker = new kakao.maps.Marker({ position : points[i] });
    marker.setMap(map); //마커가 지도위에 표시되도록 함

    // LatLngBounds 객체에 좌표를 추가합니다
    bounds.extend(points[i]);
  }





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
</script>

</body>
</html>