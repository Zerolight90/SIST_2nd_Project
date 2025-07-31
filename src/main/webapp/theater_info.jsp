<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
    <link rel="stylesheet" href="./css/theater.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  </head>
  <body>
  <article>
    <!--영화관 상세정보 영역-->
    <div id="theaterDetails">
      <div class="inner-wrap">
        <!--지역, 영화관명-->
        <div>

        </div>

        <!--첫번째텝 -->

        <!--텝제목 -->
        <div class="theater-info-text mt40" style="outline:solid 1px blue" >
          <p class="big">
            강동구청역 도보 5분, 전 좌석 가죽시트로 쾌적하고 편안하게! 언제나 즐거운 우리동네 극장<br>
          </p>
          <p></p>
        </div>
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
            <p class="floor-info">
              <li>1층 : 매표소, 매점, 무인 발권기, 로비, 엘리베이터, 남·여 화장실, 남·여 장애인 화장실, 캡슐 토이, 투썸 플레이스</li>
              <li>2층 : 1관·2관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</li>
              <li>4층 : 3관·4관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</li>
              <li>6층 : 5관~10관, 로비, 엘리베이터, 음료 자판기, 남·여 화장실</li>
            </p>
          </div>
        </div>



        <!--교통-->
        <div class="theater-traffic-info">
          <div class="event-box m70">
            <h2 class="theater traffic">교통안내</h2>
          </div>
          <h3 class="small-tit m30">지도</h3>
          <p><li>도로명주소: 서울특별시 강동구 성내로 48 <button>주소 복사</button></li> </p>
          <div id="map" style="width:500px; height:400px; border:1px solid purple;"></div>
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
  </article>

  <script>
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
