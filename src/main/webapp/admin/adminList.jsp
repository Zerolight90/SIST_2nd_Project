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

    #adminCerModal {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: white;
      border: 1px solid #ccc;
      z-index: 1000;
      box-shadow: 0 4px 15px rgba(0,0,0,0.2);
      border-radius: 8px;
      overflow: hidden;
      width: 500px;
    }
    .modalTitle {
      background-color: #20c997;
      color: white;
      padding: 15px 20px;
      font-size: 18px;
      font-weight: bold;
    }
    .modalTitle h2 { margin: 0; }
    .body { padding: 25px 20px; }
    .divs { display: flex; align-items: center; margin-bottom: 15px; }
    .divs label { width: 130px; font-weight: bold; text-align: right; padding-right: 15px; flex-shrink: 0; }
    .divs .input { width: 100%; height: 36px; padding: 0 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
    .divs .input.editable { background-color: #fff; }
    .footer { padding: 20px; text-align: center; border-top: 1px solid #eee; background-color: #f8f9fa; }
    .footer .btn { padding: 10px 30px; border: none; border-radius: 4px; font-size: 16px; font-weight: bold; cursor: pointer; margin: 0 5px; }
    .footer .btnMain { background-color: #007bff; color: white; }
    .footer .btnSub { background-color: #6c757d; color: white; }
    .btn-edit {
      background-color: #17a2b8;
      color: white;
      padding: 6px 12px;
      border-radius: 5px;
      font-size: 13px;
      cursor: pointer;
      border: none;
    }
    .btn-edit:hover {
      background-color: #138496;
    }

    .ui-dialog .ui-dialog-titlebar {
      display: none;
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
      <h2>관리자 목록</h2>
      <p class="btn-add" style="height: 20px; margin-top: 35px">관리자 추가</p>
    </div>

    <!-- 테이블 상단 바 영역 -->
    <div class="control-bar">
      <div class="total-count">
        전체 <strong>${requestScope.adminListCount}</strong>건
      </div>
      <form class="search-form" action="#" method="get">
        <select name="admin_status">
          <option value="">관리자 상태 선택</option>
          <option value="active">활성</option>
          <option value="dormant">정지</option>
        </select>
        <select name="admin_level">
          <option value="">관리자 등급 선택</option>
          <option value="manager">Manager</option>
          <option value="staff">Staff</option>
        </select>
        <select name="search_field">
          <option value="">검색 대상 선택</option>
          <option value="id">아이디</option>
          <%--<option value="level">등급</option>
          <option value="status">상태</option>--%>
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
        <th>아이디</th>
        <th>등급</th>
        <th>상태</th>
        <th>관리</th>
      </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
          <tr>
            <td>${vo.adminIdx}</td>
            <td>${vo.adminId}</td>
            <td>${vo.adminLevel}</td>

            <c:if test="${vo.adminstatus == 0}">
              <td><span class="status-badge status-dormant">정지</span></td>
            </c:if>
            <c:if test="${vo.adminstatus == 1}">
              <td><span class="status-badge status-active">활성</span></td>
            </c:if>
            <td>
              <button type="button" class="btn-edit"
                      data-admin="${vo.adminIdx}"
                      data-idx="${vo.tIdx}"
                      data-id="${vo.adminId}"
                      data-pw="${vo.adminPassword}"
                      data-level="${vo.adminLevel}"
                      data-status="${vo.adminstatus}"
                      onclick="cerModal(this)">수정
              </button>
            </td>
          </tr>
        </c:forEach>
        <%--<tr>
          <td>1</td>
          <td>leedo</td>
          <td>SUPER</td>
          <td>활성</td>
        </tr>--%>
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
          <li class="nav-arrow"><a href="Controller?type=adminList&cPage=${p.nowPage-p.pagePerBlock}">&lt;</a></li>
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
            <li><a href="Controller?type=adminList&cPage=${vs.index}">${vs.index}</a></li>
          </c:if>
        </c:forEach>


        <c:if test="${p.endPage < p.totalPage}">
          <li><a href="Controller?type=adminList&cPage=${p.nowPage+p.pagePerBlock}">&gt;</a></li> <%--&gt; :: >>--%>
        </c:if>
        <c:if test="${p.endPage >= p.totalPage}">
          <li class="nav-arrow disable">&gt;</li>
        </c:if>
      </ol>
    </nav>
  </div>
</div>

<div id="adminAdderModal" style="display:none;"></div>

<div id="adminCerModal">
  <c:set var="vo" value="${requestScope.ar}"/>
  <div class="modalTitle"><h2>관리자 수정</h2></div>
  <form action="Controller?type=adminUpdate" method="post" id="adminUpdate">
    <div class="body">
      <div class="divs">
        <label for="adminIdx">관리자 고유번호:</label>
        <input type="text" id="adminIdx" name="adminIdx" class="input" value="" readonly>
      </div>
      <div class="divs">
        <label for="tIdx">영화관 고유번호:</label>
        <input type="text" id="tIdx" name="tIdx" class="input editable" value="">
      </div>
      <div class="divs">
        <label for="adminId">로그인 ID:</label>
        <input type="text" id="adminId" name="adminId" class="input editable" value="">
      </div>
      <div class="divs">
        <label for="adminPw">패스워드 PW:</label>
        <input type="password" id="adminPassword" name="adminPassword" class="input editable" value="">
      </div>
      <div class="divs">
        <label for="adminLevel">관리자 등급:</label>
        <select id="adminLevel" name="adminLevel" style="margin-top: 4px">
          <option value="Super">Super</option>
          <option value="Manager">Manager</option>
          <option value="Staff">Staff</option>
        </select>
      </div>
      <div class="divs">
        <label for="adminstatus">관리자 상태:</label>
        <select id="adminstatus" name="adminstatus" style="margin-top: 4px">
          <option value="0">정지</option>
          <option value="1">활성</option>
        </select>
      </div>
    </div>
  </form>

  <div class="footer">
    <button type="button" class="btn btnMain">저장</button>
    <button type="button" class="btn btnSub">취소</button>
  </div>
  </form>
</div>

<script>
  $(".btn-search").on('click', function () {
    let formdata = $(".search-form").serialize();

    $.ajax({
      url: "Controller?type=adminListSearch",
      type: "GET",
      data: formdata,
      dataType: "html",
      success: function (response) {
        $(".member-table tbody").html(response);
      },
      error: function () {
        alert("검색하는 중 오류가 발생했습니다")
      }
    })
  })

  // 초기화 버튼을 눌렀을 때 select 태그 등 지정된 값 전부 초기화
  $('.btn-reset').on('click', function() {
    $('.search-form')[0].reset();
    // location.reload(); 또는 전체 목록 출력?
  });

  // 관리자 생성 다얄로그 창의 속성 지정
  $("#adminAdderModal").dialog({
    autoOpen: false,
    modal: true,
    resizable: false,
    width: 480,
    dialogClass: 'no-titlebar',
    appendTo: ".admin-container",
    close: function() {
      $(this).empty(); // 다음 모달이 열릴 때 혹시 값이 남아있으면 안 되므로 모달이 닫히면 값 비우기
    }
  });

  $(".btn-add").on('click', function () {
    let urlToLoad = "Controller?type=adminAdder";

    $("#adminAdderModal").load(urlToLoad, function(response, status, xhr) {
      if (status == "error") {
        $(this).html("관리자 생성창을 불러오는 데 실패했습니다.");
      }
      $("#adminAdderModal").dialog('open');
    });
  });

  function cerModal(str) {
    let adminIdx = $(str).data(('admin'));
    let tIdx = $(str).data('idx');
    let adminId = $(str).data('id');
    let adminPassword = $(str).data('pw');
    let adminLevel = $(str).data('level');
    let adminstatus = $(str).data('status');

    $("#adminCerModal").find("#adminIdx").val(adminIdx);
    $("#tIdx").val(tIdx);
    $("#adminCerModal").find("#adminId").val(adminId);
    $("#adminCerModal").find("#adminPassword").val(adminPassword);
    $("#adminCerModal").find("#adminLevel").val(adminLevel);
    $("#adminCerModal").find("#adminstatus").val(adminstatus);

    // 4. 데이터가 채워진 모달 창을 보여줍니다.
    $("#adminCerModal").show();
  }

  $("#adminCerModal .btnMain").on('click', function () {
    if ("${sessionScope.vo.adminLevel}" == "Super"){
      $("#adminUpdate").submit();
    } else {
      alert("Super 관리자가 아닙니다!")
    }
  })

  $("#adminCerModal .btnSub").on('click', function () {
    $("#adminCerModal").hide();
  })
</script>

</body>
</html>
