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

  <div class="tabMenu">
  <nav class="tabs">
    <ul>
      <li class="active"><a href="#" data-tab="content-1">새로운 상품</a></li>
      <li><a href="#" data-tab="content-2">패키지/티켓</a></li>
      <li><a href="#" data-tab="content-3">팝콘/음료/굿즈</a></li>
      <li><a href="#" data-tab="content-4">포인트몰 <span class="new-badge">NEW</span></a></li>
    </ul>
  </nav>
  </div>

  <div class="tab-content">
    <div id="content-1" class="content-panel active">
      <h2>새로운 상품</h2>
      <p>새로운 상품 목록이 여기에 표시됩니다.</p>
    </div>
    <div id="content-2" class="content-panel">
      <h2>패키지/티켓</h2>
      <p>패키지 및 티켓 정보가 여기에 표시됩니다.</p>
    </div>
    <div id="content-3" class="content-panel">
      <h2>팝콘/음료/굿즈</h2>
      <p>다양한 콤보와 굿즈를 만나보세요.</p>
    </div>
    <div id="content-4" class="content-panel">
      <h2>포인트몰</h2>
      <p>포인트로 구매할 수 있는 상품 목록입니다.</p>
    </div>
  </div>

</article>

<footer>
  <jsp:include page="JSP/Footer.jsp"/>
</footer>

<script>
  // 모든 탭(li)과 콘텐츠 패널(div)을 가져옵니다.
  const tabs = document.querySelectorAll('.tabs ul li');
  const contentPanels = document.querySelectorAll('.tab-content .content-panel');

  // 각 탭에 클릭 이벤트 리스너를 추가합니다.
  tabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
      // a 태그의 기본 동작(페이지 이동)을 막습니다.
      e.preventDefault();

      // 모든 탭에서 'active' 클래스를 제거합니다.
      tabs.forEach(item => item.classList.remove('active'));

      // 클릭된 탭에만 'active' 클래스를 추가합니다.
      tab.classList.add('active');

      // 모든 콘텐츠 패널에서 'active' 클래스를 제거하여 숨깁니다.
      contentPanels.forEach(panel => panel.classList.remove('active'));

      // 클릭된 탭의 a 태그에서 data-tab 속성 값을 가져옵니다. (예: "content-1")
      const targetContentId = tab.querySelector('a').getAttribute('data-tab');

      // 해당 id를 가진 콘텐츠 패널을 찾아 'active' 클래스를 추가하여 보여줍니다.
      const targetPanel = document.getElementById(targetContentId);
      if (targetPanel) {
        targetPanel.classList.add('active');
      }
    });
  });
</script>

</body>
</html>