<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="./css/theater.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->

  <style>
    .box-info{
      border: 1px solid gray;
      border-radius: 5px;
    }
  </style>
</head>
<body>
<article>
  <div id="theaterPriceInfo">
    <div class="inner-wrap">
      <div class="event-box">
        <h2 class="theater price-info-tit">상영시간표</h2>
      </div>

      <!--달력-->
      <div>
        <input type="text" id="reg_date" name="reg_date"/>날짜
      </div>

      <!---->


      <br/><br/><br/><br/><br/>

      <!--영화정보, 관란등급안내-->
      <!--영화 정보-->
      <div class="show-movie-list">
        <div class="show-movie">
          <div class="title">
            <p class="movie-grade age-12"></p>
            <p class="movie-title">판타스틱4:새로운 출발</p>
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

      <div class="box-info">
        <ul>
          <li>지연입장에 의한 관람불편을 최소화하고자 본 영화는 약 10분 후 시작됩니다.</li>
          <li>쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</li>
        </ul>
      </div>
    </div>
  </div>
</article>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
  $(function(){
    $( "#reg_date" ).datepicker({
      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
      monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
      showMonthAfterYear: true,
      yearSuffix: "년",
      dateFormat: "yy-mm-dd"
    });

    $(".btn").button();
  });
</script>
</body>
</html>
