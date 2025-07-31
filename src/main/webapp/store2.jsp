<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./css/sub/sub_page_style.css">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/store.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <link rel="icon" href="./images/favicon.png">
</head>
<body>

  <header>
    <jsp:include page="jsp/menu.jsp"/>
  </header>

  <article>

    <div class="storeTop">
      <div class="storeTopBox">
        <div class="location">
          <span>Home</span>
          &nbsp;>&nbsp;
          <a href="Controller?type=store">스토어</a>
          &nbsp;>&nbsp;
          <a href="Controller?type=store">스토어 상세</a>
        </div>
      </div>
    </div>

    <div id="contents" style="width: 1100px; height: 440px; margin: auto;">
      <div>
        <h2 style="padding: 10px">일반 관람권</h2>
      </div>
      <div>
        <p style="padding: 10px">일반 관람권</p>
      </div>
      <div style="height: 330px; border-top: 1px solid #999999; border-bottom: 1px solid #999999; display: flex">
        <div style="width: 440px; display: inline-block; border-right: 1px solid #999999">
          <p>
            <img src="./images/normalTicket.png" alt=""/>
          </p>
        </div>

        <div style="width: 600px; height: 284px; display: inline-block; padding-bottom: 15px; padding-left: 15px">
          <div class="dsp" id="theater" style="display: flex">
            <p style="width: 80px"><span>사용극장</span></p>
            <div style="padding-left: 32px">
              <a href="">사용가능 극장</a>
              <p>※ 일부 특별관(더 부티크 스위트, Dolby Cinema, Dolby Vios+Atmos, MX4D 등) 및
                특별석(발코니, 커플석, 로얄석 등)은 차액지불과 상관없이 이용 불가합니다.</p>
            </div>
          </div>
          <div class="dsp" id="expireDate" style="display: flex">
            <p style="width: 80px"><span>유효기간</span></p>
            <div>
              <p>구매일로부터 24개월 이내 사용 가능</p>
              <p>예매 가능 유효기간은 구매일로부터 2년입니다.</p>
            </div>
          </div>
          <div class="dsp" id="sellNum" style="display: flex">
            <p style="width: 80px"><span>판매수량</span></p>
            <div>
              <p>1회 8개 구매가능</p>
            </div>
          </div>
          <div class="dsp" id="refund" style="display: flex">
            <p style="width: 80px"><span>구매 후 취소</span></p>
            <div>
              <p>구매일로부터 10일 이내 취소 가능하며, 부분취소는 불가능합니다.</p>
            </div>
          </div>
          <div id="price" style="display: flex; border-top: 1px solid #ebebeb; border-bottom: 1px solid #ebebeb">
            <p style="text-align: center; line-height: 40px;"><span>수량 / 금액</span></p>
            <div style="text-align: center; line-height: 40px; margin-left: 30px">
              <button type="button">-</button>
              <input type="text" value="1" style="width: 25px; text-align: center"/>
              <button type="button">+</button>
            </div>
            <div style="width: 70px; margin-left: 350px; display: flex; font-size: 25px">
              <p>14,700</p>
              <span>원</span>
            </div>
          </div>
          <div class="dsp" id="payment" style="display: flex; justify-content: space-evenly;">
            <a href="" style="border-radius: 5px; text-align: center; line-height: 40px; display: inline-block; width: 230px; height: 40px; border: 1px solid #3d008c">선물</a>
            <a href="" style="border-radius: 5px; color: #ebebeb; text-align: center; line-height: 40px; display: inline-block; width: 230px; height: 40px; background-color: #3d008c; border: 1px solid #3d008c">구매</a>
          </div>
        </div>



      </div>

    </div>

  </article>

  <footer>
    <jsp:include page="jsp/Footer.jsp"/>
  </footer>

</body>
</html>
