<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
  response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP 1.1
  response.setHeader("Pragma","no-cache"); // HTTP 1.0
  response.setDateHeader ("Expires", 0); // Proxies
%>
<c:if test="${empty sessionScope.vo}">
  <c:redirect url="Controller?type=index"/>
</c:if>

<html>
<head>
  <title>Title</title>
  <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <style>
    /* 기본 폰트 및 여백 초기화 */
    body {
      font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
      color: #333;
      margin: 20px;
      background-color: #f9f9f9;
    }

    /* 전체 컨테이너 */
    .admin-container {
      width: 1200px;
      margin: 0 auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    /* 1. 페이지 제목 */
    .page-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
      padding-bottom: 15px;
      border-bottom: 2px solid #333;
    }

    /* 2. 상단 컨트롤 바 (게시물 수 + 검색 영역) */
    .control-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 10px;
      background-color: #f5f7fa;
      border-radius: 5px;
      margin-bottom: 20px;
    }

    .total-count {
      font-size: 14px;
      font-weight: bold;
    }
    .total-count strong {
      color: #e53935;
    }

    .search-form {
      display: flex;
      align-items: center;
      gap: 8px; /* 요소 사이 간격 */
      padding-top: 15px;
    }

    /* 검색 폼 요소 공통 스타일 */
    .search-form select,
    .search-form input[type="text"] {
      height: 36px;
      padding: 0 5px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
    }
    .search-form input[type="text"] {
      width: 250px;
    }

    .search-form .btn {
      height: 36px;
      padding: 0 15px;
      border: none;
      border-radius: 4px;
      color: #fff;
      font-weight: bold;
      cursor: pointer;
      font-size: 14px;
    }

    .search-form .btn-search {
      background-color: #337ab7;
    }
    .search-form .btn-reset {
      background-color: #777;
    }

    /* 3. 회원 목록 테이블 */
    .member-table {
      width: 100%;
      border-collapse: collapse;
      text-align: center;
      font-size: 14px;
    }

    .member-table th, .member-table td {
      padding: 12px 10px;
      border-bottom: 1px solid #eee;
    }

    .member-table thead {
      background-color: #f8f9fa;
      font-weight: bold;
      border-top: 2px solid #ddd;
      border-bottom: 1px solid #ddd;
    }

    .member-table tbody tr:hover {
      background-color: #f5f5f5;
    }

    /* 상태 뱃지 스타일 */
    .status-badge {
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 12px;
      font-weight: bold;
      color: #fff;
    }
    .status-active {
      background-color: #4caf50; /* 활성 */
    }
    .status-dormant {
      background-color: #f44336; /* 탈퇴 */
    }

    .btn-add {
      background-color: #007bff;
      color: white;
      padding: 8px 20px;
      border-radius: 5px;
      font-weight: bold;
      font-size: 14px;
      cursor: pointer;
      text-decoration: none;
      border: none;
    }
    .btn-add:hover {
      background-color: #0056b3;
    }

    /* 4. 페이징 */
    .pagination {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 15px;
      gap: 6px;
    }

    .pagination .nav-arrow a,
    .pagination .nav-arrow strong,
    .pagination .nav-arrow {
      display: inline-block;
      width: 34px;
      height: 34px;
      line-height: 34px;
      text-align: center;
      border: 1px solid #ddd;
      border-radius: 4px;
      text-decoration: none;
      color: #333;
      font-size: 14px;
    }

    .pagination .nav-arrow a:hover {
      background-color: #f0f0f0;
    }

    .pagination .current-page {
      background-color: #337ab7;
      color: #fff;
      border-color: #337ab7;
      font-weight: bold;
    }

    .pagination .nav-arrow {
      font-weight: bold;
    }

    .board-table caption{
      text-indent: -9999px;
      height: 0;
    }

    nav li {
      list-style: none;
    }

    nav ul, nav ol {
      list-style: none;
      padding-left: 0; /* 들여쓰기까지 없애고 싶다면 */
    }

    .disable {
      background-color:lightgray;
    }

  </style>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body style="margin: auto">
<!-- 관리자 화면에 처음 들어오는 보이는 상단영역 -->
<div class="dashHead bold">
  <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">${sessionScope.vo.adminId} 관리자님</p></div>
  <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
    <a href="">SIST</a>
    <a href="Controller?type=adminLogOut">로그아웃</a>
  </div>
</div>

<div class="dashBody">
  <div class="dashLeft">
    <jsp:include page="/admin/admin.jsp"/>
  </div>
  <div class="admin-container">
    <!-- 페이지 타이틀 -->
    <div class="page-title" style="display: flex; justify-content: space-between">
      <h2>상영 시간표 목록</h2>
      <%--<a href="#" class="btn-add" style="height: 20px; margin-top: 35px">상영 시간표 생성</a>--%>
    </div>

    <!-- 테이블 상단 바 영역 -->
    <div class="control-bar">
      <div class="total-count">
        전체 <strong>${requestScope.timeTableCount}</strong>건
      </div>
      <form class="search-form" action="#" method="get">
        <p class="total-count">상영일 : </p>
        <p><input type="text" id="datepicker" name="datepicker" style="width: 130px"></p>
        <select name="theater_status">
          <option value="theater">극장 선택</option>
          <option value="gn">강남점</option>
          <option value="gb">강북점</option>
        </select>
        <select name="screen_level">
          <option value="">상영관 선택</option>
          <option value="1">1관</option>
          <option value="2">2관 (3D)</option>
          <option value="3">3관 (4D)</option>
          <option value="4">4관</option>
          <option value="5">5관</option>
        </select>
        <input type="text" name="search_keyword" placeholder="검색어를 입력해주세요.">
        <button type="button" class="btn btn-search">검색</button>
        <button type="button" class="btn btn-reset">초기화</button>
      </form>
    </div>

    <!-- 테이블 영역 -->
    <table class="member-table">
      <thead>
      <tr>
        <th>번호</th>
        <th>극장</th>
        <th>상영관</th>
        <th>영화제목</th>
        <th>상영일</th>
        <th>시작 시간</th>
        <th>종료 시간</th>
        <th>잔여 좌석 / 총 좌석</th>
      </tr>
      </thead>
      <tbody>
      <c:set var="vo2" value="${requestScope.ar2}"/>
      <c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
        <tr>
          <td>${vo.timeTableIdx}</td>
          <td>${vo.tName}</td>
          <td>${vo.sName}</td>
          <td>${vo.name}</td>
          <td>${vo.date}</td>
          <td>${vo.startTime}</td>
          <td>${vo.endTime}</td>
          <td>${vo.sCount - vo.reservationCount} / ${vo.sCount}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>

    <!-- 페이징 영역 -->
    <nav>
      <ol class="pagination">
        <c:set var="p" value="${requestScope.page}" scope="page"/>
        <c:if test="${p.startPage < p.pagePerBlock}">
          <li class = "nav-arrow disable">&lt;</li> <%--&lt; :: <<--%>
        </c:if>
        <c:if test="${p.startPage >= p.pagePerBlock}">
          <li class="nav-arrow"><a href="Controller?type=playingInfo&cPage=${p.nowPage-p.pagePerBlock}">&lt;</a></li>
        </c:if>

        <%--숫자를 찍음--%>
        <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
          <c:if test="${p.nowPage == vs.index}">
            <%--<li class="now">1</li>--%>
            <%--now가 계속 찍히면 안된다. --%>
            <%--<li <% if(p.getNowPage() == i){ %>class="now"<% }%>><%=i%></li>--%>
            <li class="now"><strong class="current-page">${vs.index}</strong></li>
          </c:if>
          <%--현재 페이지 외의 버튼들--%>
          <c:if test="${p.nowPage != vs.index}">
            <li><a href="Controller?type=playingInfo&cPage=${vs.index}">${vs.index}</a></li>
          </c:if>
        </c:forEach>


        <c:if test="${p.endPage < p.totalPage}">
          <li><a href="Controller?type=playingInfo&cPage=${p.nowPage+p.pagePerBlock}">&gt;</a></li> <%--&gt; :: >>--%>
        </c:if>
        <c:if test="${p.endPage >= p.totalPage}">
          <li class="nav-arrow disable">&gt;</li>
        </c:if>
      </ol>
    </nav>
  </div>
</div>

<div id="adminTimeModal" style="display:none;"></div>

<script>
  $( function() {
    // Datepicker에 적용할 옵션
    let option = {
      monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
      monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
      weekHeader: "주",
      dateFormat: "yy-mm-dd",
      showMonthAfterYear: true,
      yearSuffix: "년",
      showOtherMonths: true,
      selectOtherMonths: true
    };

    $("#datepicker").datepicker(option);
  } );

  $(".btn-search").on('click', function () {
    let formdata = $(".search-form").serialize();

    $.ajax({
      url: "Controller?type=timetableSearch",
      type: "GET",
      data: formdata,
      dataType: "html",
      success: function (response) {
        // 오류가 없다면 tbody의 내용을 새로운 내용으로 교체
        $(".member-table tbody").html(response);
      },
      error: function() {
        alert("검색 중 오류가 발생했습니다.");
      }
    });

    $('.btn-reset').on('click', function() {
      $('.search-form')[0].reset();
      // location.reload(); 또는 전체 목록 출력?
    });
  });
</script>

</body>
</html>
