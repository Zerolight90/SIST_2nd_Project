<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="../css/summernote-lite.css"/>
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


    /* 3. 회원 목록 테이블 */
    .board-table {
      width: 100%;
      border-collapse: collapse;
      text-align: center;
      font-size: 14px;
    }

    .board-table th {
      padding: 12px 10px;
      border-bottom: 1px solid #eee;
    }

    .board-table thead {
      background-color: #f8f9fa;
      font-weight: bold;
      border-top: 2px solid #ddd;
      border-bottom: 1px solid #ddd;
    }

    .board-table td {
      padding: 12px 0px 10px 40px;
      border-bottom: 1px solid #eee;
      text-align: left;
    }

    input[type="text"]{
      height: 30px;
    }

    button[type="button"]{
      width: 84px;
      height: 30px;
    }

    .board-table tfoot>tr>td{
      text-align: right;
    }

    .w100{
      width:100px;
    }

    .board-table caption{
      text-indent: -9999px;
      height: 0;
    }
  </style>
</head>
<body style="margin: auto">
<!-- 관리자 화면에 처음 들어오는 보이는 상단영역 -->
<div class="dashHead bold">
  <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">admin 관리자님</p></div>
  <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
    <a href="">SIST</a>
    <a href="Controller?type=index">로그아웃</a>
  </div>
</div>

<div class="dashBody">
  <div class="dashLeft">
    <jsp:include page="./admin.jsp"/>
  </div>
  <div class="admin-container">
    <!-- 페이지 타이틀 -->
    <div class="page-title">
      <h2>공지사항</h2>
    </div>

    <c:if test="${requestScope.vo ne null}">
      <c:set var="vo" value="${requestScope.vo}"/>
      <form method="post">
        <!-- 3. 공지사항 테이블 -->
        <table class="board-table">
          <caption>공지사항 상세보기</caption>
          <tbody>
          <tr>
            <th class="w100"><label for="boardTitle">제목</label></th>
            <td>
              ${vo.boardTitle}
            </td>
          </tr>
          <tr>
            <th class="w100">지점명</th>
            <td>
              <%--지점명 들어갈 자리--%>
              <span>강동점</span>
            </td>
          </tr>
          <tr>
            <th class="w100"><label for="board_reg_date">게시기간</label></th>
            <td>
              ${vo.boardStartRegDate} <span> ~ <span> ${vo.boardEndRegDate}
            </td>
          </tr>
          <tr>
            <th class="w100">구분</th>
            <%--공지/이벤트 구분--%>
            <td>
              <span>공지</span>
            </td>
          </tr>
          <tr>
            <th class="w100"><label for="board_content">내용</label></th>
            <td>
              ${vo.boardContent}
            </td>
          </tr>
          <c:if test="${vo.file_name ne null and vo.file_name.length() > 4}">
            <tr>
              <th>첨부파일</th>
              <td>
                <a href="javascript:down('${vo.file_name}')">
                    ${vo.file_name}
                </a>
              </td>
            </tr>
          </c:if>

          </tbody>
        <tfoot>
        <tr>
          <td colspan="2">
            <button type="button" onclick="goEdit()" value="수정">수정</button>
            <button type="button" onclick="goDel()" value="삭제">삭제</button>
            <button type="button" onclick="goList()" value="목록">목록</button>
          </td>
        </tr>
        </tfoot>
      </table>
      </form>

    <%--숨겨진 폼 만들기--%>
    <form name="ff" method="post">
      <input type="hidden" name="type"/>
      <input type="hidden" name="f_name"/>
      <input type="hidden" name="boardIdx" value="${vo.boardIdx}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
    </form>

    <%--삭제 시 보여주는 팝업창--%>
    <div id="del_dialog" title="삭제">
      <form action="Controller" method="post">
        <p>정말로 삭제하시겠습니까?</p>
        <%--ff에서 했던, 아래 세개는 화면에 보여지지 않는다.--%>
        <input type="hidden" name="type" value="adminBoardDel" /> <%--Controller?type=adminBoardDel과 같음--%>
        <input type="hidden" name="boardIdx" value="${vo.boardIdx}"/>
        <input type="hidden" name="cPage" value="${param.cPage}"/>
        <button type="button" onclick="del(this.form)">삭제</button> <%--form이 여러개 있는데, this.form이라고 하면, 해당 form만 해당된다.--%>
        <button type="button" onclick="cancel()">취소</button>
      </form>
    </div>

  </div>
</div>
</c:if>

<%--<c:if test="${requestScope.vo eq null}">
  <c:redirect url="Controller">
    <c:param name="type" value="adminBoardList"/>
    <c:param name="cPage" value="${param.cPage}"/>
  </c:redirect>
</c:if>--%>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="../js/summernote-lite.js"></script> <%--자바스크립트 파일 추가--%>
<script src="../js/lang/summernote-ko-KR.js"></script> <%--언어추가(한글)--%>
<script>

  $(function () {
    let option = {
      modal: true,
      autoOpen: false,
      resizable: false,
    };
    $("#del_dialog").dialog(option);
  });

  //목록으로 이동
  function goList(){
    location.href = "Controller?type=adminBoardList&cPage=${param.cPage}";
  }

  //게시글 수정하기
  //현재 문서 안의 ff를 찾음
  function goEdit(){
    document.ff.action = "Controller";
    document.ff.type.value = "adminEditBoard";
    document.ff.submit();
  }

  //게시글 삭제하기(상태값 업데이트)
  //boardIdx값이 ff폼에 hidden으로 만들어야 한다.
  function goDel(){
    //다이얼로그 보여주기
    $("#del_dialog").dialog("open");
  }

  function del(frm){
    frm.submit();
  }

  function cancel(){
    //다이얼로그 닫기
    $("#del_dialog").dialog("close");
  }

  //파일 다운로드
  function down(fname) {
    document.ff.action = "admin/download.jsp";
    document.ff.f_name.value = fname;
    document.ff.submit();
  }

</script>
</body>
</html>
