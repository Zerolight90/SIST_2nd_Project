<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="../css/summernote-lite.css"/>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="../css/board.css">
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
    <jsp:include page="./admin.jsp"/>
  </div>
  <div class="admin-container">
    <!-- 1. 페이지 제목 -->
    <div class="page-title">
      <h2>1:1문의</h2>
    </div>

    <c:if test="${requestScope.vo ne null}">
      <c:set var="vo" value="${requestScope.vo}"/>
      <form method="post">
        <!-- 3. 공지사항 테이블 -->
        <table class="board-table">
          <caption>1:1문의 상세보기</caption>
          <tbody>
          <tr>
            <th class="w100"><label for="boardTitle">제목</label></th>
            <td>
              ${vo.boardTitle}
            </td>
          </tr>
          <tr>
            <th class="w100">UserID</th>
            <td>
              <%--지점명 들어갈 자리--%>
              <span>${vo.mvo.id}</span>
            </td>
          </tr>
          <tr>
            <th class="w100">회원이름</th>
            <td>
                <%--지점명 들어갈 자리--%>
              <span>${vo.mvo.name}</span>
            </td>
          </tr>
          <tr>
            <th class="w100"><label for="board_reg_date">등록일</label></th>
            <td>
              ${vo.boardRegDate}
            </td>
          </tr>
          <tr>
            <th class="w100">구분</th>
            <%--공지/이벤트 구분--%>
            <td>
              <span>${vo.boardType}</span>
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

          </td>
        </tr>
        </tfoot>
      </table>
       <%-- <button type="button" onclick="goList()" value="목록">목록</button>--%>
      </form>

    <form action="Controller?type=adminWriteBoard" method="post"
          encType="multipart/form-data">
      <input type="hidden" name="boardType" value="공지사항"/>
      <!-- 3. 공지사항 테이블 -->
      <table class="board-table">
        <caption>공지사항 글쓰기</caption>
        <tbody>
        <!-- 예시 데이터 행 (실제로는 DB에서 반복문으로 생성) -->
        <tr>
          <th class="w100"><label for="boardTitle">제목</label></th>
          <td>
            <input type="text" id="boardTitle" name="title"/>
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
              <%--에디터가 들어갈 자리--%>
            <input type="text" id="start_reg_date" name="boardRegDate"/>
            ~
            <input type="text" id="end_reg_date" name="boardEndRegDate"/>
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
              <%--에디터가 들어갈 자리--%>
            <textarea rows="12" cols="50" id="board_content" name="content"></textarea>
          </td>
        </tr>
        <tr>
          <th>첨부파일:</th>
          <td>
            <input type="file" id="file" name="file"/>
          </td>
            <%--보안상의 이유로 file에는 value를 넣어줄 수 없다. 바깥쪽에 스크립틀릿으로 if문으로 비교하자--%>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td colspan="2">
            <button type="button" id="save_btn" onclick="sendData()">등록</button>
            <button type="button" id="cancel_btn" onclick="goList()">취소</button>
          </td>
        </tr>
        </tfoot>
      </table>
    </form>

      <div id="answerFormContainer" style="display: none;">
        <form id="answered-form" class="board-table" encType="multipart/form-data">
          <h2>답변 작성</h2>
          <table>
            <tr>
              <th class="w100">제목</th>
              <td><input type="text" id="answerTitle" name="answerTitle" value="[답변] ${vo.boardTitle}" style="width:100%;"></td>
            </tr>
            <tr>
              <th class="w100">내용</th>
              <td><textarea name="answerContent" rows="5" cols="50" placeholder="답변 내용을 입력하세요." style="width:100%;"></textarea></td>
            </tr>
            <tr>
              <th class="w100">첨부파일:</th>
              <td>
                <input type="file" id="file" name="file"/>
              </td>
            </tr>
          </table>
          <input type="hidden" name="boardIdx" value="${vo.boardIdx}">
          <input type="hidden" name="boardType" value="${vo.boardType}">
          <input type="hidden" name="type"/>
          <div style="text-align:right; margin-top:10px;">
            <button type="button" id="submitAnswerBtn">답변 등록</button>
            <button type="button" id="cancelBtn">취소</button>
          </div>
        </form>
      </div>

      <div id="result-area"></div>



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

    <button id="showFormBtn">답변하기</button>
    <div id="formContainer"> <div style="color:red; width:300px;"></div></div>

  </div>
</div>
</c:if>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="../js/summernote-lite.js"></script> <%--자바스크립트 파일 추가--%>
<script src="../js/lang/summernote-ko-KR.js"></script> <%--언어추가(한글)--%>
<script>


  $(document).ready(function() {
    // '답변하기' 버튼 클릭 이벤트
    $('#showFormBtn').on('click', function() {
      // 폼을 보이게 하고 '답변하기' 버튼은 숨깁니다.
      $('#answerFormContainer').show();
      $(this).hide();
    });

    // '취소' 버튼 클릭 이벤트
    $('#cancelBtn').on('click', function() {
      // 폼을 숨기고 '답변하기' 버튼을 다시 보이게 합니다.
      $('#answerFormContainer').hide();
      $('#showFormBtn').show();
      // 폼 입력 필드 초기화
      $('#answered-form')[0].reset();
      // 결과 영역 비우기
      $('#result-area').empty();
    });

    // '답변 등록' 버튼 클릭 이벤트
    $('#submitAnswerBtn').on('click', function() {
      let form = document.getElementById("answered-form");
      let formData = new FormData(form);

      $.ajax({
        url: "Controller?type=adminWriteInquiry", // 답변을 처리할 서버 URL
        data: formData,
        type: "post",
        contentType: false,
        processData: false,
        dataType: "json"
      }).done(function(res) {
        if (res.success) {
          alert("답변이 성공적으로 등록되었습니다.");
          // 성공 시 폼 숨기기
          $('#answerFormContainer').hide();
          $('#showFormBtn').show();

          // 서버에서 받은 답변 내용을 화면에 뿌려주기
          // 예를 들어, 서버에서 답변 내용을 JSON으로 보내줬다고 가정
          if (res.answerContent) {
            $('#result-area').html(`<p><strong>답변 내용:</strong> ${res.answerContent}</p>`);
          }

          // 폼 입력 필드 초기화
          $('#answered-form')[0].reset();

        } else {
          alert("답변 등록 실패: " + res.message);
        }
      }).fail(function(xhr, status, error) {
        console.error("AJAX 요청 실패:", status, error);
        alert("답변 등록 중 오류가 발생했습니다.");
      });
    });
  });

  $(function () {
    let option = {
      modal: true,
      autoOpen: false,
      resizable: false,
    };
    $("#del_dialog").dialog(option);
  });

  //답변
  /*function goAnswered(){
    let frm = document.getElementById("answer-form-container")

    $.ajax({
      url: "Controller?type=adminWriteInquiry",
      data: frm,
      type: "post",
      contentType: false,
      processData: false,
      dataType: "json"

    }).done(function (res) {

    });
  }*/

  //목록으로 이동
  function goList(){
    location.href = "Controller?type=adminInquiryList&cPage=${param.cPage}";
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
