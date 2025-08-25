<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <link rel="icon" href="../images/favicon.png">
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
      </div>
    </div>
  </div>

  <div id="contents">
    <div class="storeTopBox">
      <h2 style="padding: 10px">스토어</h2>
    </div>
  </div>

  <div class="ec-base-tab typeLight">
    <ul class="menu" style="font-size: 16px;">
      <li class="selected"><a href="#none">새로운 상품</a></li>
      <li><a href="#none">메가티켓</a></li>
      <li><a href="#none">팝콘 / 음료 / 굿즈</a></li>
      <%--<li><a href="#none">포인트몰</a></li>--%>
    </ul>
  </div>
  <!-- 비동기식 페이지 전환 : 라인형-->
  <div class="ec-base-tab typeLight eTab">
    <div id="tabCont1_1" class="tabCont" style="display:block; margin-bottom: 50px">
      <div style="width: 1100px; margin-top: 10px; display: flex">
        <a href="" style="margin-top: 30px">
          <div>
            <p style="font-weight: bold; font-size: 24px; color: #3d008c">
              소중한 분들과 함께
            </p>
            <p style="font-weight: bold; font-size: 24px; color: #329eb1">
              즐거운 관람 되세요~
            </p>
          </div>
          <div style="margin-top: 45px; font-size: 16px">
            <p>
              러브콤보패키지
            </p>
            <p>
              2인관람권 + 러브콤보 [팝콘(L)1 + 탄산음료(R)2]
            </p>
          </div>
          <div style="margin-top: 15px; font-size: 16px; display: flex">
            <p style="width: 100px; font-weight: bold; font-size: 20px; color: #3d008c">34,000<span>원</span></p>
            <p style="width: 70px; text-decoration: line-through; margin-left: 5px">41,900<span>원</span></p>
          </div>
        </a>
        <p class="img" style="margin-left: 10px">
          <img src="../images/loveComboPackage.png" alt=""/>
        </p>
      </div>

      <div style="margin-top: 10px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
        <h3 style="font-weight: bold; font-size: 24px; color: #3d008c">메가티켓</h3>

        <div>
          <a href="" title="더보기" id="ticket">더보기 ></a>
        </div>
      </div>

      <div>
        <ul style="display: flex">

          <c:forEach var="vo" items="${requestScope.tar}" varStatus="status" begin="0" end="3">
            <li style="width: 243px; height: 433px; margin-right: 25px; margin-left: 10px; border: 1px solid #ebebeb; border-radius: 10px">
              <a href="Controller?type=detailStore&prodIdx=${vo.prodIdx}">
                <div class="prodTop">
                  <img src="../images/${vo.prodImg}" alt="" style="width: 243px; height: 243px; border-radius: 10px; background-color: #ebebeb"/>
                </div>
                <div class="prodBottom">
                  <div style="padding-top: 15px">
                    <p class="storeCardText" style="margin-left: 20px; margin-bottom: 10px; height: 39px; font-size: 16px; font-weight: bold">${vo.prodName}</p>
                    <p class="storeCardText" style="margin-left: 20px;">${vo.prodInfo}</p>
                    <p class="storeCardText" style="width: 200px; border-bottom: 2px solid #ebebeb; padding-top: 20px; margin-left: 20px"></p>
                  </div>
                  <div class="price" style="margin-left: 20px; margin-top: 6px; font-size: 20px">
                      <%--<p style="text-decoration: line-through">${vo.prodPrice}원</p>--%>
                    <p style="font-weight: bold; margin-top: 20px; color: #3d008c">
                      <span><fmt:formatNumber value="${vo.prodPrice}" type="number" pattern="#,###"/></span>
                      <span>원</span>
                    </p>
                  </div>
                </div>
              </a>
            </li>
          </c:forEach>

        </ul>
      </div>

      <div style="margin-top: 50px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
        <h3 style="font-weight: bold; font-size: 24px; color: #3d008c">팝콘 / 음료 / 굿즈</h3>

        <div>
          <a href="" title="더보기" id="goods">더보기 ></a>
        </div>
      </div>

      <div>
        <ul style="display: flex; width: 1100px; flex-wrap: wrap">

          <c:forEach var="vo" items="${requestScope.sar}" varStatus="status" begin="0" end="3">
            <li style="width: 240px; height: 433px; margin-right: 25px; margin-left: 10px; margin-bottom: 20px; border: 1px solid #ebebeb; border-radius: 10px">
              <a href="Controller?type=detailStore&prodIdx=${vo.prodIdx}">
                <div class="prodTop">
                  <img src="../images/${vo.prodImg}" alt="" style="width: 240px; height: 243px; border-radius: 10px; background-color: #ebebeb"/>
                </div>
                <div class="prodBottom">
                  <div style="padding-top: 15px">
                    <p class="storeCardText" style="margin-left: 20px; margin-bottom: 10px; height: 39px; font-size: 16px; font-weight: bold">${vo.prodName}</p>
                    <p class="storeCardText" style="margin-left: 20px;">${vo.prodInfo}</p>
                    <p class="storeCardText" style="width: 200px; border-bottom: 2px solid #ebebeb; padding-top: 20px; margin-left: 20px"></p>
                  </div>
                  <div class="price" style="margin-left: 20px; margin-top: 6px; font-size: 20px">
                    <p style="font-weight: bold; margin-top: 20px; color: #3d008c">
                      <span><fmt:formatNumber value="${vo.prodPrice}" type="number" pattern="#,###"/></span>
                      <span>원</span>
                    </p>
                  </div>
                </div>
              </a>
            </li>
          </c:forEach>

        </ul>
      </div>

      <%--<div style="margin-top: 50px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
        <h3>포인트몰</h3>

        <div>
          <a href="" title="더보기">더보기 ></a>
        </div>
      </div>--%>

      <%--<div>
        <ul>
          <li style="width: 243px; height: 433px; border: 1px solid #ebebeb; border-radius: 10px">
            <a href="">
              <div class="prodTop">
                <img src="../images/normalTicket.png" alt="" style="width: 243px; height: 243px; border-radius: 10px; background-color: #ebebeb"/>
              </div>
              <div class="prodBottom">
                <div style="padding-top: 15px">
                  <p class="storeCardText" style="margin-left: 20px; margin-bottom: 10px; height: 39px; font-size: 16px; font-weight: bold">일반 관람권</p>
                  <p class="storeCardText" style="margin-left: 20px;">일반 관람권</p>
                  <p class="storeCardText" style="width: 200px; border-bottom: 2px solid #ebebeb; padding-top: 20px; margin-left: 20px"></p>
                </div>
                <div class="price" style="margin-left: 20px; margin-top: 6px; font-size: 20px">
                  <p style="text-decoration: line-through">15,000원</p>
                  <p style="font-weight: bold; color: #3d008c">
                    <span>14,000</span>
                    <span>원</span>
                  </p>
                </div>
              </div>
            </a>
          </li>
        </ul>
      </div>--%>

    </div>

    <div id="tabCont1_2" class="tabCont" style="display:none; width: 1100px">
      <div>
        <ul style="display: flex">

          <c:forEach var="vo" items="${requestScope.tar}" varStatus="status">
            <li style="width: 243px; height: 433px; margin-right: 25px; margin-left: 10px; border: 1px solid #ebebeb; border-radius: 10px">
              <a href="Controller?type=detailStore&prodIdx=${vo.prodIdx}">
                <div class="prodTop">
                  <img src="../images/${vo.prodImg}" alt="" style="width: 243px; height: 243px; border-radius: 10px; background-color: #ebebeb"/>
                </div>
                <div class="prodBottom">
                  <div style="padding-top: 15px">
                    <p class="storeCardText" style="margin-left: 20px; margin-bottom: 10px; height: 39px; font-size: 16px; font-weight: bold">${vo.prodName}</p>
                    <p class="storeCardText" style="margin-left: 20px;">${vo.prodInfo}</p>
                    <p class="storeCardText" style="width: 200px; border-bottom: 2px solid #ebebeb; padding-top: 20px; margin-left: 20px"></p>
                  </div>
                  <div class="price" style="margin-left: 20px; margin-top: 6px; font-size: 20px">
                      <%--<p style="text-decoration: line-through">${vo.prodPrice}원</p>--%>
                    <p style="font-weight: bold; margin-top: 20px; color: #3d008c">
                      <span><fmt:formatNumber value="${vo.prodPrice}" type="number" pattern="#,###"/></span>
                      <span>원</span>
                    </p>
                  </div>
                </div>
              </a>
            </li>
          </c:forEach>

        </ul>
      </div>
    </div>

    <div id="tabCont1_3" class="tabCont" style="display:none; width: 1100px">
      <div>
        <ul style="display: flex; flex-wrap: wrap">

          <c:forEach var="vo" items="${requestScope.sar}" varStatus="status">
          <li style="width: 240px; height: 433px; margin-right: 25px; margin-left: 10px; margin-bottom: 20px; border: 1px solid #ebebeb; border-radius: 10px">
            <a href="Controller?type=detailStore&prodIdx=${vo.prodIdx}">
              <div class="prodTop">
                <img src="../images/${vo.prodImg}" alt="" style="width: 240px; height: 243px; border-radius: 10px; background-color: #ebebeb"/>
              </div>
              <div class="prodBottom">
                <div style="padding-top: 15px">
                  <p class="storeCardText" style="margin-left: 20px; margin-bottom: 10px; height: 39px; font-size: 16px; font-weight: bold">${vo.prodName}</p>
                  <p class="storeCardText" style="margin-left: 20px;">${vo.prodInfo}</p>
                  <p class="storeCardText" style="width: 200px; border-bottom: 2px solid #ebebeb; padding-top: 20px; margin-left: 20px"></p>
                </div>
                <div class="price" style="margin-left: 20px; margin-top: 6px; font-size: 20px">
                  <p style="font-weight: bold; margin-top: 20px; color: #3d008c">
                    <span><fmt:formatNumber value="${vo.prodPrice}" type="number" pattern="#,###"/></span>
                    <span>원</span>
                  </p>
                </div>
              </div>
            </a>
          </li>
          </c:forEach>

        </ul>
      </div>
    </div>

    <%--<div id="tabCont1_4" class="tabCont" style="display:none; width: 1100px">
      <div>
        <ul>
          <li style="width: 243px; height: 433px; border: 1px solid #ebebeb; border-radius: 10px">
            <a href="">
              <div class="prodTop">
                <img src="../images/normalTicket.png" alt="" style="width: 243px; height: 243px; border-radius: 10px; background-color: #ebebeb"/>
              </div>
              <div class="prodBottom">
                <div style="padding-top: 15px">
                  <p class="storeCardText" style="margin-left: 20px; margin-bottom: 10px; height: 39px; font-size: 16px; font-weight: bold">일반 관람권</p>
                  <p class="storeCardText" style="margin-left: 20px;">일반 관람권</p>
                  <p class="storeCardText" style="width: 200px; border-bottom: 2px solid #ebebeb; padding-top: 20px; margin-left: 20px"></p>
                </div>
                <div class="price" style="margin-left: 20px; margin-top: 6px; font-size: 20px">
                  <p style="text-decoration: line-through">15,000원</p>
                  <p style="font-weight: bold; color: #3d008c">
                    <span>14,000</span>
                    <span>원</span>
                  </p>
                </div>
              </div>
            </a>
          </li>
        </ul>
      </div>
    </div>--%>
  </div>

</article>

<footer>
  <jsp:include page="../common/Footer.jsp"/>
</footer>

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

  document.getElementById("ticket").addEventListener("click", function(e) {
    e.preventDefault();
  tabs[1].click();
    window.scrollTo(0, 0);
  });
  document.getElementById("goods").addEventListener("click", function(e) {
    e.preventDefault();
    tabs[2].click();
    window.scrollTo(0, 0);
  });
</script>

</body>
</html>