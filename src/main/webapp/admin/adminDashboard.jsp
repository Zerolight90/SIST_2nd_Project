<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body style="margin: auto">
<!-- 관리자 화면에 처음 들어오는 보이는 상단영역 -->
<div class="dashHead bold">
  <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">admin 관리자님</p></div>
  <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
    <a href="">SIST</a>
    <a href="">로그아웃</a>
  </div>
</div>

<div class="dashBody">
  <div class="dashLeft">
    <jsp:include page="/admin/admin.jsp"/>
  </div>
  <div class="admin-container">
    <div>
      <h2>대시보드</h2>
    </div>

  <div style="display: flex">
    <div style="width: 500px; border: 2px solid #ebebeb; border-radius: 10px">
      <div style="border-bottom: 2px solid #ebebeb">
        <p style="margin-left: 20px">인기 영화 TOP 10 예매 비율</p>
      </div>
      <div>
        <canvas id="movieChart" style="width: 500px; height: 500px"></canvas>
      </div>
    </div>
    <div>
      <div style="margin-left: 20px; width: 500px; border: 2px solid #ebebeb; border-radius: 10px">
        <div style="border-bottom: 2px solid #ebebeb">
          <p style="margin-left: 20px">월별 이용자 수 추이</p>
        </div>
        <div>
          <canvas id="userChart" style="width: 500px; height: 500px"></canvas>
        </div>
      </div>
    </div>
  </div>

    <div>
      <div style="margin-top: 20px; width: 500px; border: 2px solid #ebebeb; border-radius: 10px">
        <div style="border-bottom: 2px solid #ebebeb">
          <p style="margin-left: 20px">극장별 총 매출</p>
        </div>
        <div>
          <canvas id="payChart" style="width: 500px; height: 500px"></canvas>
        </div>
      </div>
    </div>

  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

<script>
  Chart.register(ChartDataLabels);

  const ctx = document.getElementById('movieChart');

  new Chart(ctx, {
    type: 'pie',
    data: {
      labels: ['어벤져스', '슈퍼맨', '28년 후', 'SIST', '마라톤', '워낭소리'],
      datasets: [{
        label: '예매 수',
        data: [12, 19, 3, 5, 2, 3],
        borderWidth: 1
      }]
    },
    options: {
      responsive: false,
      // 파이 차트에서는 scales(축) 옵션이 필요 없습니다.
      plugins: {
        // 범례(legend) 위치 등 설정
        legend: {
          position: 'top',
        },
        // 데이터 레이블(백분율)에 대한 설정
        datalabels: {
          // formatter 함수는 올바르게 작성하셨습니다.
          formatter: (value, ctx) => {
            let sum = 0;
            let dataArr = ctx.chart.data.datasets[0].data;
            dataArr.map(data => {
              sum += data;
            });
            let percentage = (value * 100 / sum).toFixed(2) + "%";
            return percentage;
          },
          color: '#fff', // 글자색
          font: {
            weight: 'bold',
            size: 14,
          }
        }
      }
    }
  });

  const utx = document.getElementById('userChart');
  new Chart(utx, {
    type: 'line',
    data: {
      labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
      datasets: [{
        label: '월별 이용자 수',
        data: [12000, 19000, 30000, 50000, 20000, 30000, 12354, 60459, 30405, 20485, 10593, 43002],
        borderWidth: 1
      }]
    },
    options: {
      responsive: false,
      // 파이 차트에서는 scales(축) 옵션이 필요 없습니다.
      plugins: {
        // 범례(legend) 위치 등 설정
        legend: {
          position: 'top',
        }
      }
    }
  });

  const ptx = document.getElementById('payChart');
  new Chart(ptx, {
    type: 'bar',
    data: {
      labels: ['강남', '강북', '서초', '방배'],
      datasets: [{
        label: '극장 매출액',
        data: [12000, 19000, 30000, 50000],
        borderWidth: 1
      }]
    },
    options: {
      responsive: false,
      // 파이 차트에서는 scales(축) 옵션이 필요 없습니다.
      plugins: {
        // 범례(legend) 위치 등 설정
        legend: {
          position: 'top',
        }
      }
    }
  });
</script>

</body>
</html>
