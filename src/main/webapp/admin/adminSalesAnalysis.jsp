<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>매출 분석</title>
  <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <style>
    /* 기존 스타일은 그대로 유지하거나 필요에 따라 수정 */
    .search-form {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      padding: 15px;
      border: 1px solid #ddd;
      border-radius: 5px;
      background-color: #f8f9fa;
    }

    .search-form label {
      font-weight: bold;
    }

    .search-form div {
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .search-form input[type="date"], .search-form input[type="text"], .search-form select {
      height: 36px;
      padding: 0 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
    }

    .search-form .btn-group {
      margin-left: auto;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body style="margin: auto">
<div class="dashHead bold">
  <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">admin 관리자님</p></div>
  <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
    <a href="">SIST</a>
    <a href="Controller?type=index">로그아웃</a>
  </div>
</div>

<div class="dashBody">
  <div class="dashLeft">
    <jsp:include page="/admin/admin.jsp"/>
  </div>
  <div class="admin-container">
    <div class="page-title">
      <h2>매출 분석</h2>
    </div>

    <form class="search-form" action="Controller" method="get">
      <input type="hidden" name="type" value="salesanalysis">
      <div>
        <label for="startDate">기간:</label>
        <input type="date" id="startDate" name="startDate" value="${param.startDate}">
        <span>~</span>
        <input type="date" id="endDate" name="endDate" value="${param.endDate}">
      </div>
      <div>
        <label for="theaterSelect">극장명:</label>
        <select id="theaterSelect" name="theaterNames" multiple="multiple" style="width:150px">
          <option value="">모든 극장</option>
          <c:forEach var="theater" items="${allTheaters}">
            <option value="${theater}"
                    <c:if test="${paramValues.theaterNames != null && Arrays.asList(paramValues.theaterNames).contains(theater)}">selected</c:if>>
                ${theater}
            </option>
          </c:forEach>
        </select>
      </div>
      <div>
        <label for="movieGenre">영화 장르:</label>
        <select id="movieGenre" name="movieGenre">
          <option value="">전체</option>
          <option value="드라마" <c:if test="${param.movieGenre == '드라마'}">selected</c:if>>드라마</option>
          <option value="액션" <c:if test="${param.movieGenre == '액션'}">selected</c:if>>액션</option>
          <option value="코미디" <c:if test="${param.movieGenre == '코미디'}">selected</c:if>>코미디</option>
          <option value="SF" <c:if test="${param.movieGenre == 'SF'}">selected</c:if>>SF</option>
          <option value="공포" <c:if test="${param.movieGenre == '공포'}">selected</c:if>>공포</option>
          <option value="애니메이션" <c:if test="${param.movieGenre == '애니메이션'}">selected</c:if>>애니메이션</option>
          <option value="음악" <c:if test="${param.movieGenre == '음악'}">selected</c:if>>음악</option>
          <option value="다큐멘터리" <c:if test="${param.movieGenre == '다큐멘터리'}">selected</c:if>>다큐멘터리</option>
          <option value="미스터리" <c:if test="${param.movieGenre == '미스터리'}">selected</c:if>>미스터리</option>
        </select>
      </div>
      <div>
        <label for="timeOfDay">시간대:</label>
        <select id="timeOfDay" name="timeOfDay">
          <option value="">전체</option>
          <option value="06-11" <c:if test="${param.timeOfDay == '06-11'}">selected</c:if>>조조 (6시~11시)</option>
          <option value="12-17" <c:if test="${param.timeOfDay == '12-17'}">selected</c:if>>일반 (12시~17시)</option>
          <option value="18-24" <c:if test="${param.timeOfDay == '18-24'}">selected</c:if>>심야 (18시~24시)</option>
        </select>
      </div>
      <div>
        <label for="paymentType">결제 유형:</label>
        <select id="paymentType" name="paymentType">
          <option value="">전체</option>
          <option value="0" <c:if test="${param.paymentType == '0'}">selected</c:if>>매점 상품</option>
          <option value="1" <c:if test="${param.paymentType == '1'}">selected</c:if>>영화 예매</option>
        </select>
      </div>
      <div>
        <label for="memberType">회원 유형:</label>
        <select id="memberType" name="memberType">
          <option value="">전체</option>
          <option value="member" <c:if test="${param.memberType == 'member'}">selected</c:if>>회원</option>
          <option value="nmember" <c:if test="${param.memberType == 'nmember'}">selected</c:if>>비회원</option>
        </select>
      </div>
      <div class="btn-group">
        <button type="submit" class="btn btn-search">검색</button>
        <button type="button" class="btn btn-reset" onclick="window.location.href='Controller?type=salesanalysis'">초기화</button>
      </div>
    </form>

    <div style="margin-top: 20px; width: 100%; border: 2px solid #ebebeb; border-radius: 10px; padding: 20px;">
      <div style="border-bottom: 2px solid #ebebeb; margin-bottom: 20px;">
        <h3 style="margin: 0; padding-bottom: 10px;">검색 결과 - 극장별 총 매출</h3>
      </div>
      <div>
        <canvas id="payChart" style="width: 100%; height: 500px;"></canvas>
      </div>
    </div>
  </div>
</div>

<script>
  // 모든 극장명 선택/해제 기능
  document.addEventListener('DOMContentLoaded', function() {
    const selectBox = document.getElementById('theaterSelect');
    const allOption = selectBox.options[0];

    // "모든 극장" 옵션을 클릭했을 때
    allOption.addEventListener('mousedown', function(event) {
      if (allOption.selected) {
        // 이미 선택되어 있다면 선택 해제
        allOption.selected = false;
      } else {
        // 선택되어 있지 않다면 선택하고 다른 옵션 모두 해제
        allOption.selected = true;
        for (let i = 1; i < selectBox.options.length; i++) {
          selectBox.options[i].selected = false;
        }
      }
      event.preventDefault(); // 기본 동작(선택 토글) 방지
    });

    // 다른 옵션을 클릭했을 때
    for (let i = 1; i < selectBox.options.length; i++) {
      selectBox.options[i].addEventListener('mousedown', function(event) {
        if (allOption.selected) {
          allOption.selected = false; // "모든 극장" 옵션 해제
        }
        // event.preventDefault()를 사용하지 않아 기본 다중 선택 동작 유지
      });
    }
  });

  // JSTL로 받은 데이터를 JavaScript 배열로 변환
  const theaterLabels = [];
  const salesData = [];
  <c:forEach var="revenue" items="${requestScope.revenueList}">
  theaterLabels.push('${revenue.theaterName}');
  salesData.push(${revenue.totalSales});
  </c:forEach>

  // 차트 생성
  const ptx = document.getElementById('payChart');
  new Chart(ptx, {
    type: 'bar',
    data: {
      labels: theaterLabels,
      datasets: [{
        label: '극장 매출액',
        data: salesData,
        borderWidth: 1,
        backgroundColor: 'rgba(54, 162, 235, 0.5)',
        borderColor: 'rgba(54, 162, 235, 1)'
      }]
    },
    options: {
      responsive: false,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script>

</body>
</html>