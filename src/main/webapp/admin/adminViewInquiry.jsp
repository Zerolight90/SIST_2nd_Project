<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
  <link rel="stylesheet" href="../css/admin.css">
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
      </table>
       <%-- <button type="button" onclick="goList()" value="목록">목록</button>--%>
      </form>

      <%--답변이 없을 시--%>
    <c:if test="${vo.bvo == null}">
      <button id="showFormBtn">답변하기</button>

      <div id="answerFormContainer" class="m50" style="display: none;">
        <form id="answered-form" action="Controller?type=adminWriteInquiry&ajax=Y" method="post" enctype="multipart/form-data" class="board-table">
          <h2>답변 작성</h2>
          <table class="answer-table">
            <tr>
              <th class="w100">제목</th>
              <td><input type="text" id="answerTitle" name="title" value="[답변] ${vo.boardTitle}" style="width:100%;"></td>
            </tr>
            <tr>
              <th class="w100">지점명</th>
              <td><input type="text" id="answerTitle" name="theater" value="${vo.tvo.tName}" style="width:100%;"></td>
            </tr>
            <tr>
              <th class="w100">내용</th>
              <td><textarea name="content" rows="5" cols="50" placeholder="답변 내용을 입력하세요." style="width:100%;"></textarea></td>
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
          <input type="hidden" name="parent_boardIdx" value="${vo.boardIdx}">
          <%--<input type="hidden" name="type" value="${vo.}"/>--%>
          <div style="text-align:right; margin-top:10px;">
            <button type="button" id="submitAnswerBtn">답변 등록</button>
            <button type="button" id="cancelBtn">취소</button>
          </div>
        </form>
      </div>
    </c:if>

      <%--답변이 달려 있다면--%>
    <c:if test="${vo.bvo != null}">
      <div class="page-title">
        <h2>답변</h2>
      </div>
      <div id="showAnswerForm">
        <table class="adSaveInquiry">
          <tr>
            <th class="w100">제목</th>
            <td>[답변] ${vo.boardTitle}</td>
          </tr>
          <tr>
            <th class="w100">지점명</th>
            <td>${vo.tvo.tName}</td>
          </tr>
          <tr>
            <th class="w100">내용</th>
            <td>${vo.bvo.boardContent}</td>
          </tr>
          <c:if test="${vo.file_name ne null and vo.file_name.length() > 4}">
          <tr>
            <th class="w100">첨부파일:</th>
            <td>
              <input type="file" id="file" name="file"/>
            </td>
          </tr>
          </c:if>
        </table>
        <div style="text-align:right; margin-top:10px;">
          <button type="button" id="showEditFormBtn">수정하기</button>
        </div>
      </div>

    </c:if>


  <%--숨겨진 폼 만들기--%>
    <form name="ff" method="post">
      <input type="hidden" name="type"/>
      <input type="hidden" name="f_name"/>
      <input type="hidden" name="boardIdx" value="${vo.boardIdx}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
    </form>



    </c:if>
  </div>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>


  $(document).ready(function() {
    // '답변하기' 버튼 클릭 이벤트
    $('#showFormBtn').on('click', function() {
      // 폼을 보이게 하고 '답변하기' 버튼은 숨깁니다.
      $('#answerFormContainer').show();
      $(this).hide();
    });

    // '답변등록' 버튼 클릭 이벤트
    $('#submitAnswerBtn').on('click', function() {
      /*let frm = document.getElementById("answer-form-container")*/

      $.ajax({
        url: "Controller?type=adminWriteInquiry",
        data: new FormData(document.getElementById("answered-form")), /*frm,*/
        type: "POST",
        contentType: false,
        processData: false,
        dataType: "html"
      }).done(function(res) {
        alert(res.answerContent);
        //성공했을 때
        if (res.success) {
          alert("답변이 성공적으로 등록되었습니다.");
          //폼 숨기기
          $('#answerFormContainer').hide();

          // 답변 작성 폼이 있던 위치에 새로운 HTML을 추가합니다.
          // 이 예제에서는 부모 컨테이너에 새로운 내용을 추가하는 방식입니다.
          $('.answer-table').html(res);

          // 3. 버튼 상태 변경
          // '답변하기' 버튼을 숨깁니다.
          $('#showFormBtn').hide();

          // 동적으로 추가된 '수정하기' 버튼을 보이게 합니다.
          // 이미 보여질 것이므로, show() 코드는 필요 없을 수도 있습니다.
          // $('#showEditFormBtn').show();




/*


          $('#showFormBtn').hide();
          $('#showEditFormBtn').show();
          $('#showAnswerForm').show();
*/

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