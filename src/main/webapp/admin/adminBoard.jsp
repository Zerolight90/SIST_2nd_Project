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

    #title{
      width: 800px;
    }

    .board-table td {
      padding: 12px 0px 10px 121px;
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
  </style>

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
      <h2>공지사항</h2>
    </div>

    <!-- 3. 공지사항 테이블 -->
    <table class="board-table">
      <tbody>
      <!-- 예시 데이터 행 (실제로는 DB에서 반복문으로 생성) -->
      <tr>
        <th class="w100">제목</th>
        <td class>
          <input type="text" id="title"/>
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
        <th class="w100">게시기간</th>
        <td>
          <%--에디터가 들어갈 자리--%>
            <input type="text" id="start_reg_date" name="start_reg_date"/>
            ~
            <input type="text" id="end_reg_date" name="end_reg_date"/>
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
        <th class="w100">내용</th>
        <td>
          <%--에디터가 들어갈 자리--%>
          <textarea rows="12" cols="50" id="content"></textarea>
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
          <button type="button" id="save_btn">등록</button>
          <button type="button" id="cancel_btn">취소</button>
        </td>
      </tr>
      </tfoot>
    </table>

  </div>
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
    $("#content").summernote({
      lang: "ko-KR",
      height: 300,
      callbacks: {
        onImageUpload: function (files, editor) {
          //에디터에 이미지를 추가될 때 수행하는 곳
          //이미지를 여러 개 추가할 수 있으므로 files는 배열이다.
          for(let i=0; i<files.length; i++)
            sendImg(files[i], editor);
        }
      }
    });

    $(".btn").button();
  });


  function sendImg(file, editor) {
    //서버로 비동기식 통신을 수행하기 위해 준비한다.
    //이미지를 서버로 보내기 위해 폼객체를 생성하자
    let frm = new FormData();

    //서버로 보낼 이미지 파일을 폼객체에 파라미터로 지정
    frm.append("upload", file);


    //비동기식 통신
    $.ajax({
      url: "Controller?type=saveImg",
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
      $("#content").summernote("editor.insertImage", res.img_url);
      console.log(res.img_url);
    });

  }
</script>
</body>
</html>
