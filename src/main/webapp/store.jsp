<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./CSS/style.css">
  <link rel="stylesheet" href="./CSS/reset.css">
  <link rel="stylesheet" href="./CSS/store.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <link rel="icon" href="./images/favicon.png">
</head>

<body>

<header>
  <jsp:include page="JSP/menu.jsp"/>
</header>

<article>

  <div class="storeTop">
    <div class="storeTopBox">
      <div class="location">
        <span>Home</span>
        &nbsp;>&nbsp;
        <a href="Controller?type=store">스토어</a>
      </div>
    </div>
  </div>

  <div id="contents">
    <div class="storeTopBox">
      <h2 style="padding: 10px">스토어</h2>
    </div>
  </div>

  <div class="ec-base-tab typeLight">
    <ul class="menu">
      <li class="selected"><a href="#none">새로운 상품</a></li>
      <li><a href="#none">메가티켓</a></li>
      <li><a href="#none">팝콘 / 음료 / 굿즈</a></li>
      <li><a href="#none">포인트몰</a></li>
    </ul>
  </div>
  <!-- 비동기식 페이지 전환 : 라인형-->
  <div class="ec-base-tab typeLight eTab">
    <div id="tabCont1_1" class="tabCont" style="display:block;">
      <div style="width: 1100px; margin-top: 10px; display: flex">
        <a href="">
          <div>
            <p style="font-weight: bold; font-size: 24px; color: #3d008c">
              소중한 분들과 함께
            </p>
            <p style="font-weight: bold; font-size: 24px; color: #329eb1">
              즐거운 관람 되세요~
            </p>
          </div>
          <div style="margin-top: 15px">
            <p>
              러브콤보패키지
            </p>
            <p>
              2인관람권 + 러브콤보 [팝콘(L)1 + 탄산음료(R)2]
            </p>
          </div>
          <div style="margin-top: 15px">
            <p>
              34,000원
            </p>
          </div>
        </a>
        <p class="img">
          <img src="./images/loveCombo.png" alt=""/>
        </p>
      </div>

      <div style="margin-top: 10px; display: flex; justify-content: space-between; align-items: center;">
        <h3>메가티켓</h3>

        <div>
          <a href="" title="더보기">더보기 ></a>
        </div>
      </div>

      <div>
        <ul>
          <li>
            <a href="">
              <div>
                <img src="./images/normalTicket.png" alt=""/>
              </div>
              <div>
                <div></div>
                <div></div>
              </div>
            </a>
          </li>
        </ul>
      </div>

      <div style="margin-top: 10px; display: flex; justify-content: space-between; align-items: center;">
        <h3>팝콘 / 음료 / 굿즈</h3>

        <div>
          <a href="" title="더보기">더보기 ></a>
        </div>
      </div>

      <div>

      </div>

      <div style="margin-top: 10px; display: flex; justify-content: space-between; align-items: center;">
        <h3>포인트몰</h3>

        <div>
          <a href="" title="더보기">더보기 ></a>
        </div>
      </div>

    </div>

    <div id="tabCont1_2" class="tabCont" style="display:none;">
      탭 버튼2 내용영역입니다.
    </div>

    <div id="tabCont1_3" class="tabCont" style="display:none;">
      탭 버튼3 내용영역입니다.
    </div>

    <div id="tabCont1_4" class="tabCont" style="display:none;">
      탭 버튼4 내용영역입니다.
    </div>
  </div>

</article>

<footer>
  <jsp:include page="JSP/Footer.jsp"/>
</footer>

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
</script>

</body>
</html>