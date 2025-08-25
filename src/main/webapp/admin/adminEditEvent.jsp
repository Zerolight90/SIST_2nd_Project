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

    #boardTitle{
      width: 360px;
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

    .t_bold{
      font-weight:bold; color: #007bff;
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
    <a href="Controller?type=adminLogOut">로그아웃</a>
  </div>
</div>

<div class="dashBody">
  <div class="dashLeft">
    <jsp:include page="./admin.jsp"/>
  </div>

  <c:set var ="vo" value="${requestScope.vo}" scope="page"/>
  <c:if test="${vo!=null}">
  <div class="admin-container">
    <!-- 1. 페이지 제목 -->
    <div class="page-title">
      <h2>이벤트</h2>
    </div>

    <form action="Controller?type=adminEditEvent" method="post"
          encType="multipart/form-data">
      <input type="hidden" name="boardType" value="adminEditEvent"/>
      <input type="hidden" name="boardIdx" value="${param.boardIdx}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
      <!-- 3. 공지사항 테이블 -->
      <table class="board-table">
        <caption>이벤트 게시글 수정</caption>
        <tbody>
        <!-- 예시 데이터 행 (실제로는 DB에서 반복문으로 생성) -->
        <tr>
          <th class="w100"><label for="boardTitle">제목</label></th>
          <td>
            <input type="text" id="boardTitle" name="boardTitle" value="${vo.boardTitle}"/>
          </td>
        </tr>
        <tr>
          <th class="w100">지점명</th>
          <td>
            <%--지점명 들어갈 자리--%>
            <span>${vo.tvo.tName}</span>
          </td>
        </tr>
        <tr>
          <th class="w100"><label for="board_reg_date">게시기간</label></th>
          <td>
            <%--에디터가 들어갈 자리--%>
              <input type="text" id="start_reg_date" name="boardStartRegDate" value="${vo.boardStartRegDate}"/>
              ~
              <input type="text" id="end_reg_date" name="boardEndRegDate" value="${vo.boardEndRegDate}"/>
          </td>
        </tr>
        <tr>
          <th class="w100">구분</th>
          <%--공지/이벤트 구분--%>
          <td>
            <span>${vo.boardType}</span>
            <form class="subType-form" action="Controller" method="post">
              <select name="sub_boardType">
                <option value="" ${empty vo.sub_boardType ? 'selected' : ''}>카테고리</option>
                <option value="movie" ${vo.sub_boardType == 'movie' ? 'selected' : ''}>영화</option>
                <option value="theater" ${vo.sub_boardType == 'theater' ? 'selected' : ''}>극장</option>
                <option value="stageGreeting" ${vo.sub_boardType == 'stageGreeting' ? 'selected' : ''}>시사회/무대인사</option>
              </select>
                <%--<select name="sub_boardType" id="subBoardType">
                <option value="" selected>카테고리</option>
                <option value="movie">영화</option>
                <option value="theater">극장</option>
                <option value="stageGreeting">시사회/무대인사</option>
              </select>--%>
            </form>
          </td>
        </tr>
        <tr>
          <th>썸네일 이미지:</th>
          <td>
              <%--첨부파일이 있는 경우--%>
            <input type="file" id="thumb_file" name="thumb_file"/>
            <c:if test="${vo.thumbnail_url != null}">
              <p class="t_bold">(${vo.thumbnail_url})</p>
            </c:if>
          </td>
            <%--보안상의 이유로 file에는 value를 넣어줄 수 없다. 바깥쪽에 스크립틀릿으로 if문으로 비교하자--%>
        </tr>
        <tr>
          <th class="w100"><label for="board_content">내용</label></th>
          <td>
            <%--에디터가 들어갈 자리--%>
            <textarea rows="12" cols="50" id="board_content" name="boardContent">${vo.boardContent}</textarea>
          </td>
        </tr>
        <tr>
          <th>첨부파일:</th>
          <td>
            <%--첨부파일이 있는 경우--%>
            <input type="file" id="file" name="file"/>
            <c:if test="${vo.file_name != null}">
              <p class="t_bold">(${vo.file_name})</p>
            </c:if>
          </td>
          <%--보안상의 이유로 file에는 value를 넣어줄 수 없다. 바깥쪽에 스크립틀릿으로 if문으로 비교하자--%>
        </tr>
        </tbody>
      <tfoot>
      <tr>
        <td colspan="2">
          <button type="button" id="save_btn" value="저장" onclick="sendData()">저장</button>
          <button type="button" id="cancel_btn" value="취소" onclick="goBack()">취소</button>
          <button type="button" id="list_btn" value="목록" onclick="goList()">목록</button>
        </td>
      </tr>
      </tfoot>
    </table>
    </form>
  </div>
  </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="../js/summernote-lite.js"></script> <%--자바스크립트 파일 추가--%>
<script src="../js/lang/summernote-ko-KR.js"></script> <%--언어추가(한글)--%>
<script>

  $(function () {
    /*게시기간 달력*/
    $( "#start_reg_date" ).datepicker({
      //여러개의 속성을 넣어야 하기 때문에
      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ], /*dayNamesMin 속성명(KEY), []:값(VALUE)문자들의 배열*/ /* key value 와 같은 형식 : json */
      monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ], /*monthNames 월표기하는 속성명*/ /*문자표기시 "" '' 둘 다 상관없다*/
      showMonthAfterYear: true,
      yearSuffix: "년",
      dateFormat: "yy-mm-dd"
    });

    $( "#end_reg_date" ).datepicker({
      //여러개의 속성을 넣어야 하기 때문에
      dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ], /*dayNamesMin 속성명(KEY), []:값(VALUE)문자들의 배열*/ /* key value 와 같은 형식 : json */
      monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ], /*monthNames 월표기하는 속성명*/ /*문자표기시 "" '' 둘 다 상관없다*/
      showMonthAfterYear: true,
      yearSuffix: "년",
      dateFormat: "yy-mm-dd"
    });

    //게시글 작성
    $("#board_content").summernote({
      lang: "ko-KR",
      height: 300,
      callbacks: {
        onImageUpload: function (files, editor) {
          //에디터에 이미지를 추가될 때 수행하는 곳
          //이미지를 여러 개 추가할 수 있으므로 files는 배열이다.
          //console.log("테스트");
          for(let i=0; i<files.length; i++)
            sendImg(files[i], editor);
        }
      }
    });
  });

  //게시글 등록
  function sendData(){
    //유효성 검사
    //제목
    let title = $("#boardTitle").val();
    if(title.trim().length < 1){
      alert("제목을 입력하세요!");
      $("#boardTitle").val("");
      $("#boardTitle").focus();
      return;
    }

    //시작일
    let startRegdate = $("#start_reg_date").val();
    if(startRegdate.trim().length < 1){
      alert("시작일을 입력하세요.");
      $("#start_reg_date").val("");
      $("#start_reg_date").focus();
      return;
    }

    //종료일
    let endRegdate = $("#end_reg_date").val();
    if(endRegdate.trim().length < 1){
      alert("종료일을 입력하세요.");
      $("#end_reg_date").val("");
      $("#end_reg_date").focus();
      return;
    }

    //게시글 내용
    //텍스트로 변환 후 길이 확인(에디터로 인해 html구조로 코드가 생성되어 비어보이지만 빈값으로 처리가 안됨)
    let contentHtml = $('#board_content').summernote('code');  // Summernote HTML 코드 가져오기

    if (isEmptySummernoteContent(contentHtml)) {
      alert("내용을 입력해주세요.");
      //기존 배운 방식은 textarea나 input요소에만 영향을 주므로,
      //summernote editer를 쓰는 경우, 아래와 같이 summernote로 하면 된다.
      $('#board_content').summernote('code', '');
      $("#board_content").summernote('focus');

      return;
    }
    document.forms[0].submit();
  }

  //Summernote html 비어있는지 확인
  function isEmptySummernoteContent(html) {
    let tempDiv = document.createElement("div");
    tempDiv.innerHTML = html;
    let text = tempDiv.innerText || tempDiv.textContent;

    return text.trim().length === 0; //길이를 0으로 저장하라
  }

  //수정버튼 누르기 전 보고있던 화면으로 이동
  function goBack(){
    //forward되어서 ${param.boardIdx}를 쓸 수 있음
    location.href="Controller?type=adminViewEvent&boardIdx=${param.boardIdx}&cPage=${param.cPage}";
  }

  //목록으로 이동
  function goList(){
    location.href="Controller?type=adminEventList&cPage=${param.cPage}";
  }

  function sendImg(file, editor) {
    //서버로 비동기식 통신을 수행하기 위해 준비한다.
    //이미지를 서버로 보내기 위해 폼객체를 생성하자
    let frm = new FormData();

    //서버로 보낼 이미지 파일을 폼객체에 파라미터로 지정
    frm.append("upload", file);


    //비동기식 통신
    $.ajax({
      url: "Controller?type=adminSaveImg",
      data: frm,
      type: "post",
      contentType: false,
      processData: false,
      dataType: "json"

    }).done(function (res) {
      //요청에 성공했을 때 수행하는 곳
      //분명 서버의 saveImg.jsp에서 응답하는 json이
      //res로 들어온다. 그 json에 img_url이라는 이름으로
      //이미지의 경로를 보내도록 되어있다.
      //그것을 받아 editor에 img태그를 넣어주면 된다.
      $("#board_content").summernote("editor.insertImage", res.img_url);
      //console.log("img_url:::::::::::::::"+ res.img_url);
    });

  }
</script>
</body>
</html>
