<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="../css/sub/sub_page_style.css">
  <link rel="stylesheet" href="../css/reset.css">
  <link rel="stylesheet" href="../css/store.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <link rel="icon" href="../images/store/favicon.png">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>

<body>

<header>
  <jsp:include page="../common/sub_menu.jsp"/>
</header>

<article>

  <div class="storeTop">
    <div class="storeTopBox">
      <div class="location">
        <a href="Controller?type=index">Home</a>
        &nbsp;>&nbsp;
        <a href="Controller?type=store">스토어</a>
        &nbsp;>&nbsp;
        <a href="">스토어 상세</a>
      </div>
    </div>
  </div>

  <div id="contents" style="width: 1100px; margin: auto;">
    <div>
      <h2 style="padding-top: 20px; font-size: 24px">${requestScope.vo.prodName}</h2>
    </div>
    <div>
      <p style="padding-top: 5px; padding-left: 5px; font-size: 16px">${requestScope.vo.prodInfo}</p>
    </div>
    <div style="height: 315px; border-top: 1px solid #999999; border-bottom: 1px solid #999999; display: flex; margin-top: 10px">
      <div style="width: 440px; display: inline-block; border-right: 1px solid #999999">
        <p>
          <img src="../images/store/${requestScope.vo.prodImg}" alt="" style="margin-top: 17px; margin-left: 70px"/>
        </p>
      </div>

      <div style="font-size: 14px; padding-top: 20px; width: 600px; display: inline-block; padding-bottom: 15px; padding-left: 15px">
        <div class="dsp" id="theater" style="display: flex">
          <p style="width: 100px"><span>사용극장</span></p>
          <div style="padding-left: 26px">
            <a href="">사용가능 극장</a>
            <p>※ 일부 특별관(더 부티크 스위트, Dolby Cinema, Dolby Vios+Atmos, MX4D 등) 및
              특별석(발코니, 커플석, 로얄석 등)은 차액지불과 상관없이 이용 불가합니다.</p>
          </div>
        </div>
        <div class="dsp" id="expireDate" style="margin-top: 10px; display: flex">
          <p style="width: 80px"><span>유효기간</span></p>
          <div>
            <p>구매일로부터 24개월 이내 사용 가능</p>
            <p>예매 가능 유효기간은 구매일로부터 2년입니다.</p>
          </div>
        </div>
        <div class="dsp" id="sellNum" style="margin-top: 10px; display: flex">
          <p style="width: 80px"><span>판매수량</span></p>
          <div>
            <p>1회 8개 구매가능</p>
          </div>
        </div>
        <div class="dsp" id="refund" style="margin-top: 10px; display: flex">
          <p style="width: 80px"><span>구매 후 취소</span></p>
          <div>
            <p>구매일로부터 10일 이내 취소 가능하며, 부분취소는 불가능합니다.</p>
          </div>
        </div>
        <div id="price" style="width: 600px; margin-top: 10px; display: flex; border-top: 1px solid #ebebeb; border-bottom: 1px solid #ebebeb">
          <p style="text-align: center; line-height: 40px;"><span>수량 / 금액</span></p>
          <div style="text-align: center; line-height: 40px; margin-left: 30px">
            <button id="minus" type="button">-</button>
            <input type="text" id="num" value="1" style="width: 25px; text-align: center" disabled/>
            <button id="plus" type="button">+</button>
          </div>
          <div style="width: 70px; margin-left: 350px; display: flex; font-size: 25px">
            <p id="totalPrice"><fmt:formatNumber value="${requestScope.vo.prodPrice}" type="number" pattern="#,###"/></p>
            <span>원</span>
          </div>
        </div>
        <div class="dsp" id="payment" style="margin-top: 10px; display: flex; justify-content: space-evenly;">
          <a href="" style="border-radius: 5px; text-align: center; line-height: 40px; display: inline-block; width: 230px; height: 40px; border: 1px solid #3d008c">선물</a>
          <form action="Controller?type=paymentStore" name="buyForm" method="post" style="display:inline-block">
            <input type="hidden" name="prodIdx" value="${requestScope.vo.prodIdx}">
            <input type="hidden" name="prodName" value="${requestScope.vo.prodName}">
            <input type="hidden" name="prodImg" value="${requestScope.vo.prodImg}">
            <input type="hidden" name="amount" id="formAmount" value="${requestScope.vo.prodPrice}">
            <input type="hidden" name="quantity" id="formQuantity" value="1">

            <button type="submit" id="buyBtn" style="border-radius: 5px; color: #ebebeb; text-align: center; line-height: 40px; display: inline-block; width: 230px; height: 40px; background-color: #3d008c; border: 1px solid #3d008c; cursor:pointer;">구매</button>
          </form>
        </div>
      </div>



    </div>

    <a href="" class="close" style="line-height: 39px; height: 39px; margin-top: 30px; border: 1px solid #ebebeb; border-radius: 5px; display: flex">
      <p style="margin-left: 15px; font-size: 15px">구매 후 취소</p>
      <span style="margin-left: 980px">▽</span>
    </a>
    <ul id="cond" style="margin: 20px; display: none">
      <li>본 상품은 구매일로부터 10일 이내에 취소 가능합니다.</li>
      <li>유효기간은 본 상품의 유효기간 내에서 연장 신청이 가능하며, 1회 연장 시 3개월(92일) 단위로 연장됩니다.</li>
      <li>구매일로부터 5년까지 유효기간 연장이 가능합니다.</li>
      <li>최초 유효기간 만료 후에는 결제금액의 90%에 대해 환불 요청 가능하며, 환불 처리에 7일 이상의 시간이 소요될 수 있습니다. (접수처 : 1544-0070)</li>
      <li>구매 취소 및 환불 요청은 미사용 상품에 한해 가능하며, 사용한 상품에 대해서는 불가합니다.</li>
      <li>본 상품은 현금으로 환불이 불가합니다.</li>
    </ul>

    <a href="" class="close2" style="line-height: 39px; height: 39px; margin-top: 30px; margin-bottom: 30px; border: 1px solid #ebebeb; border-radius: 5px; display: flex">
      <p style="margin-left: 15px; font-size: 15px">상품이용 안내</p>
      <span style="margin-left: 970px">▽</span>
    </a>
    <ul id="cond2" style="margin: 20px; display: none">
      <li>본 권은 구매 시 계정으로 자동 등록되며, 등록된 계정에서만 사용 가능합니다.<br/>
        (단! 선물 받은 PIN번호는 계정 내 스토어 교환권 등록 후 사용 가능합니다.)</li>
      <li>본 권의 예매 가능한 유효기간은 구매일로부터 2년입니다.</li>
      <li>가격 정책에 따라 티켓금액이 변동 될 수 있으며 이에 대한 차액 환불이 불가합니다. (조조/심야/청소년/우대 등)</li>
      <li>본 권은 카카오 알림톡을 통해 전송 됩니다. (카카오톡 미설치 또는 미수신 고객은 MMS로 발송)</li>
      <li>본 권은 메가박스 홈페이지, 어플에서만 예매 가능합니다. (현장 매표소, 무인발권기 예매 불가)</li>
      <li>어플 및 홈페이지 예매방법 : 지점 > 영화명 > 시간 > 인원 > 쿠폰/관람권/기타 > 스토어 교환권으로 전송 받은 PIN번호 16자리 입력 > 결제</li>
      <li>메가박스 홈페이지 스토어 구매내역에서 PIN 번호 확인이 가능합니다.</li>
      <li>일부 극장 [아트나인점], 특별관 [더 부티크 스위트, Dolby Cinema 등], 특별석 [로얄석, 커플석, 발코니 등] 및 특별콘텐트 예매가 불가합니다.<br/>
        (차액 지불 여부 상관없이 예매 불가)</li>
      <li>본 권으로 영화 관람 시 메가박스 규정에 의해 일정의 포인트가 적립됩니다.</li>
    </ul>

  </div>

</article>

<script>
  // 1. 모든 탭 버튼(li)과 내용 영역(div)을 가져옵니다.
  let tabs = document.querySelectorAll('.menu li');
  let tabContents = document.querySelectorAll('.tabCont');

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

  /*function open() {
    // .css()의 첫번째 인자와, 비교할 값을 문자열로 수정
    if ($("#cond").css('display') == 'none'){
      // .css()의 인자들을 모두 문자열로 수정
      $("#cond").css('display', 'block');
    } else {
      $("#cond").css('display', 'none');
    }
  }*/

  $(function () {
    // '.close'라는 클래스를 가진 a 태그를 클릭했을 때
    $('a.close').on('click', function(e) {
      // 1. a 태그의 기본 동작(페이지 이동)을 막습니다.
      e.preventDefault();

      // 2. #cond 요소를 토글(toggle)합니다.
      //    (보이는 상태면 숨기고, 숨겨진 상태면 보여줍니다.)
      $('#cond').toggle();
    });

    $('a.close2').on('click', function(e) {
      // 1. a 태그의 기본 동작(페이지 이동)을 막습니다.
      e.preventDefault();

      // 2. #cond 요소를 토글(toggle)합니다.
      //    (보이는 상태면 숨기고, 숨겨진 상태면 보여줍니다.)
      $('#cond2').toggle();
    });

    // 수량의 + 버튼을 눌렀을 때 현재 수량값을 얻어내고 수량값이 문자열이므로
    // 정수로 형변환 시킨 후 1을 더한 값을 변수로 선언해 그 값을 수량값에 넣어준다
    // 그 후 수량에 따른 가격을 계산하는 함수를 호출한다
    $("#plus").on('click', function () {
      let num = $("#num").val();
      let int = parseInt(num);
      let newVal = int + 1;
      $("#num").val(newVal);

      updatePrice();
    })

    // 수량의 - 버튼을 눌렀을 때 현재 수량값을 얻어내고 수량값이 문자열이므로
    // 정수로 형변환 시킨 후 1을 뺀 값을 변수로 선언해 그 값을 수량값에 넣어준다
    // 이 때 수량값이 0 이하가 되지 않아야 하므로 수량값이 2 이상일 때만 이를 수행시킨다
    // 그 후 수량에 따른 가격을 계산하는 함수를 호출한다
    $("#minus").on('click', function () {

      if ($("#num").val() >= 2) {
        let num = $("#num").val();
        let int = parseInt(num);
        let newVal = int - 1;
        $("#num").val(newVal);

        updatePrice();
      }
    })
  });
  // 수량값과 가격값을 얻어내 문자열이므로 먼저 정수로 형변환시킨 뒤
  // 값을 서로 곱해서 총 가격값을 얻어내서 해당하는 칸에 대입시켜준다
  function updatePrice() {
    let num = parseInt($("#num").val());
    let price = ${requestScope.vo.prodPrice};
    let rnum = price * num;

    // 폼에 있는 hidden input 값 업데이트
    $("#totalPrice").text(rnum.toLocaleString());
    $("#formAmount").val(rnum);
    $("#formQuantity").val(num);
  }
</script>

<footer>
  <jsp:include page="../common/Footer.jsp"/>
</footer>
</body>
</html>