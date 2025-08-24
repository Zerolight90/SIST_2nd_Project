<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
  <link rel="stylesheet" href="../css/summernote-lite.css"/> <%--css파일 연결하기--%>
  <link rel="stylesheet" href="../css/admin.css">
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

    .btn {
      height: 36px;
      padding: 0 15px;
      border: none;
      border-radius: 4px;
      color: #fff;
      font-weight: bold;
      cursor: pointer;
      font-size: 14px;
      text-align: right;
    }

    .search-form .btn-search {
      background-color: #337ab7;
    }

    .search-form .btn-reset {
      background-color: #777;
    }

    .writeBoard {
      background-color: #777;
      margin-top: 20px;
    }

    /* 3. 회원 목록 테이블 */
    .board-table {
      width: 100%;
      border-collapse: collapse;
      text-align: center;
      font-size: 14px;
    }

    .board-table th, .board-table td {
      padding: 12px 10px;
      border-bottom: 1px solid #eee;
    }

    .board-table thead {
      background-color: #f8f9fa;
      font-weight: bold;
      border-top: 2px solid #ddd;
      border-bottom: 1px solid #ddd;
    }

    .board-table tbody tr:hover {
      background-color: #f5f5f5;
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

    li {
      list-style: none;
    }

    ul, ol {
      list-style: none;
      padding-left: 0; /* 들여쓰기까지 없애고 싶다면 */
    }

    .disable {
      background-color:lightgray;
    }

  </style>
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
    <jsp:include page="./admin.jsp"/>
  </div>
  <div class="admin-container">
    <!-- 1. 페이지 제목 -->
    <div class="page-title">
      <h2>이벤트</h2>
    </div>

    <!-- 2. 상단 컨트롤 바 -->
    <div class="control-bar">
      <div class="total-count">
        전체 <strong>${totalCount}</strong>건
      </div>
      <form class="search-form" action="Controller" method="get">
        <input type="hidden" name="type" value="adminEventList">
        <select name="search_field">
          <option value="all">지역 선택</option>
          <option value="name">대상</option>
          <option value="id">로그 정보</option>
          <option value="email">관리자 ID</option>
        </select>
        <select name="search_field">
          <option value="all">극장선택</option>
          <option value="name">대상</option>
          <option value="id">로그 정보</option>
          <option value="email">관리자 ID</option>
        </select>
        <%--검색기능--%>
        <input type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력해주세요." value="${param.searchKeyword}">
        <button type="button" class="btn btn-search" onclick="searchTitle()">검색</button>
        <button type="button" class="btn btn-reset" onclick="resetSearch()">초기화</button>
      </form>
    </div>

    <!-- 3. 공지사항 테이블 -->
    <table class="board-table">
      <thead>
      <tr>
        <th>번호</th>
        <th>구분</th>
        <th>서브카테고리</th>
        <th>제목</th>
        <th>게시기간</th>
        <th>삭제여부</th>
      </tr>
      </thead>
      <tbody>
      <!-- DB에서 반복문으로 생성 -->
      <c:set var="p" value="${requestScope.page}" scope="page"/>
      <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs1">
        <tr>
          <c:set var="num" value="${p.totalCount - ((p.nowPage-1)*p.numPerPage+ vs1.index)}"/>
          <td>${num}</td>
          <td>${vo.boardType}</td>
          <td>${vo.sub_boardType}</td>
          <td>
            <a href="Controller?type=adminViewEvent&boardIdx=${vo.boardIdx}&cPage=${nowPage}"><%--listAction에서 nowPage이름으로 request 만들어야 한다.--%>
                ${vo.boardTitle}
            </a>
          </td>
          <td>${vo.boardStartRegDate} ~ ${vo.boardEndRegDate}</td>
            <%--삭제여부 확인하기용--%>
          <td>
            <c:if test="${vo.boardStatus eq '0'}"> 삭제안된 글</c:if>
            <c:if test="${vo.boardStatus eq '1'}"> 삭제된글</c:if>
          </td>

        </tr>
      </c:forEach>
      </tbody>

    </table>

    <!-- 검색 결과 없음 모달 -->
    <div id="noResultDialog" title="알림" style="display: none;">
      <p>검색된 결과가 없습니다.</p>
    </div>

    <input type="button" value="글쓰기" class="btn writeBoard"
           onclick="javascript:location.href='Controller?type=adminWriteEvent'"/>

    <nav>
      <ol class="pagination">
        <c:set var="p" value="${requestScope.page}" scope="page"/>
        <c:if test="${p.startPage < p.pagePerBlock}">
          <li class = "nav-arrow disable">&lt;</li> <%--&lt; :: <<--%>
        </c:if>
        <c:if test="${p.startPage >= p.pagePerBlock}">
          <li class="nav-arrow"><a href="Controller?type=adminEventList&cPage=${p.nowPage-p.pagePerBlock}">&lt;</a></li>
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
            <li><a href="Controller?type=adminEventList&cPage=${vs.index}">${vs.index}</a></li>
          </c:if>
        </c:forEach>


        <c:if test="${p.endPage < p.totalPage}">
          <li><a href="Controller?type=adminEventList&cPage=${p.nowPage+p.pagePerBlock}">&gt;</a></li> <%--&gt; :: >>--%>
        </c:if>
        <c:if test="${p.endPage >= p.totalPage}">
          <li class="nav-arrow disable">&gt;</li>
        </c:if>
      </ol>
    </nav>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>

  //제목 서치
  function searchTitle() {

    let keyword = $("#searchKeyword").val().trim();

    if (keyword < 1) {
      alert("검색어를 입력해주세요.");
      $("#searchKeyword").focus();
      return;
    }

    //확인
    console.log("보낼 keyword:", keyword);
    document.forms[0].submit();
  }

  //초기화 버튼 클릭 시
  function resetSearch() {

    $("#searchKeyword").val("");
    $("#searchKeyword").focus();
  }

  $(function () {
    $("#noResultDialog").dialog({
      modal: true,
      autoOpen: false,
      resizable: false,
    });

    // 검색 결과 없을 때만 열기
    let noResult = "${empty requestScope.ar}";
    if (noResult === "true") {
      $("#noResultDialog").dialog("open");
    }
  });


</script>
</body>
</html>
