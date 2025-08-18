<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <title>매출 분석</title>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <style>
    .search-form { display: flex; flex-wrap: wrap; gap: 10px; padding: 15px; border: 1px solid #ddd; border-radius: 5px; background-color: #f8f9fa; }
    .search-form label { font-weight: bold; }
    .search-form div { display: flex; align-items: center; gap: 5px; }
    .search-form input[type="date"], .search-form select { height: 36px; padding: 0 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
    .search-form .btn-group { margin-left: auto; }
    .chart-container-wrapper { display: flex; flex-wrap: wrap; gap: 20px; margin-top: 20px; }
    .chart-box { flex: 1; min-width: 400px; border: 2px solid #ebebeb; border-radius: 10px; padding: 20px; }
    .chart-title { border-bottom: 2px solid #ebebeb; margin-bottom: 20px; }
    .chart-title h3 { margin: 0; padding-bottom: 10px; }
  </style>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
        <label for="theaterGroup">극장 그룹:</label>
        <select id="theaterGroup" name="theaterGroup">
          <option value="" <c:if test="${empty param.theaterGroup}">selected</c:if>>전체 그룹</option>
          <option value="1" <c:if test="${param.theaterGroup == '1'}">selected</c:if>>매출 TOP 5 극장들</option>
          <option value="2" <c:if test="${param.theaterGroup == '2'}">selected</c:if>>나머지 극장들</option>
        </select>
      </div>

      <div>
        <label for="movieGenre">영화 장르:</label>
        <select id="movieGenre" name="movieGenre">
          <option value="">전체</option>
          <c:forEach var="genre" items="${allGenres}">
            <option value="${genre}" <c:if test="${param.movieGenre == genre}">selected</c:if>>${genre}</option>
          </c:forEach>
        </select>
      </div>

      <div>
        <label for="timeOfDay">시간대:</label>
        <select id="timeOfDay" name="timeOfDay">
          <option value="">전체</option>
          <option value="06-11" <c:if test="${param.timeOfDay == '06-11'}">selected</c:if>>조조</option>
          <option value="12-17" <c:if test="${param.timeOfDay == '12-17'}">selected</c:if>>일반</option>
          <option value="18-24" <c:if test="${param.timeOfDay == '18-24'}">selected</c:if>>심야</option>
        </select>
      </div>

      <div>
        <label for="paymentType">상품 종류:</label>
        <select id="paymentType" name="paymentType">
          <option value="">전체</option>
          <option value="0" <c:if test="${param.paymentType == '0'}">selected</c:if>>영화 예매</option>
          <option value="1" <c:if test="${param.paymentType == '1'}">selected</c:if>>스토어 구매</option>
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

    <div class="chart-container-wrapper">
      <div class="chart-box">
        <div class="chart-title"><h3>검색 결과 - 극장별 총 매출</h3></div>
        <div><canvas id="theaterChart" style="width: 100%; height: 400px;"></canvas></div>
      </div>
      <div class="chart-box">
        <div class="chart-title"><h3>검색 결과 - 영화별 매출 TOP 10</h3></div>
        <div><canvas id="movieChart" style="width: 100%; height: 400px;"></canvas></div>
      </div>
    </div>
  </div>
</div>

<script>
  // JSTL로 받은 데이터를 JavaScript 배열로 변환
  const theaterLabels = [<c:forEach var="item" items="${theaterRevenueList}" varStatus="status">'${item.theaterName}'<c:if test="${!status.last}">,</c:if></c:forEach>];
  const theaterSales = [<c:forEach var="item" items="${theaterRevenueList}" varStatus="status">${item.totalSales}<c:if test="${!status.last}">,</c:if></c:forEach>];
  const movieLabels = [
    <c:forEach var="item" items="${movieRevenueList}" varStatus="status">
    "${fn:replace(item.theaterName, '"', '\\"')}"
    <c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];
  const movieSales = [<c:forEach var="item" items="${movieRevenueList}" varStatus="status">${item.totalSales}<c:if test="${!status.last}">,</c:if></c:forEach>];

  // [수정] 미리 정의된 색상표 사용 (가장 안정적인 방식)
  var colorPalette = [
    'rgba(255, 99, 132, 0.6)', 'rgba(54, 162, 235, 0.6)', 'rgba(255, 206, 86, 0.6)',
    'rgba(75, 192, 192, 0.6)', 'rgba(153, 102, 255, 0.6)', 'rgba(255, 159, 64, 0.6)',
    'rgba(46, 204, 113, 0.6)', 'rgba(231, 76, 60, 0.6)', 'rgba(52, 152, 219, 0.6)',
    'rgba(142, 68, 173, 0.6)'
  ];

  // [수정] 데이터 개수만큼 색상 배열을 만드는 함수
  function getChartColors(dataLength) {
    var backgroundColors = [];
    var borderColors = [];
    for (var i = 0; i < dataLength; i++) {
      // 색상표를 순환하면서 색상을 가져옴
      var color = colorPalette[i % colorPalette.length];
      backgroundColors.push(color);
      borderColors.push(color.replace('0.6', '1'));
    }
    return {
      bg: backgroundColors,
      border: borderColors
    };
  }

  // 각 차트에 사용할 색상 세트 생성
  var theaterColors = getChartColors(theaterLabels.length);
  var movieColors = getChartColors(movieLabels.length);

  // 차트 옵션 (수정 없음)
  var verticalChartOptions = {
    responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true } }, plugins: { legend: { display: false } }
  };
  var horizontalChartOptions = {
    indexAxis: 'y', responsive: true, maintainAspectRatio: false, scales: { x: { beginAtZero: true } }, plugins: { legend: { display: false } }
  };

  // 차트 생성
  new Chart(document.getElementById('theaterChart'), {
    type: 'bar',
    data: {
      labels: theaterLabels,
      datasets: [{
        label: '극장 매출액',
        data: theaterSales,
        backgroundColor: theaterColors.bg,
        borderColor: theaterColors.border,
        borderWidth: 1
      }]
    },
    options: verticalChartOptions
  });

  new Chart(document.getElementById('movieChart'), {
    type: 'bar',
    data: {
      labels: movieLabels,
      datasets: [{
        label: '영화 매출액 TOP 10',
        data: movieSales,
        backgroundColor: movieColors.bg,
        borderColor: movieColors.border,
        borderWidth: 1
      }]
    },
    options: horizontalChartOptions
  });
</script>

</body>
</html>