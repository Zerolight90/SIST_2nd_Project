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

    /* board-table td 내의 입력 필드와 텍스트 영역에 대한 스타일 */
    .board-table td input[type="text"] {
      width: 500px; /* 입력 필드와 텍스트 영역의 너비를 500px로 설정 */
      box-sizing: border-box; /* 패딩과 테두리를 너비에 포함시켜 레이아웃이 깨지지 않게 함 */
    }

    /* 모든 textarea에 스타일을 적용 */
    textarea {
      width: 909px;
      height: 145px;
      box-sizing: border-box; /* 패딩과 테두리를 너비와 높이에 포함 */
    }

    /*층별 안내*/
    .floor-group textarea{
      width: 909px;
      height: 50px;
      box-sizing: border-box; /* 패딩과 테두리를 너비와 높이에 포함 */
    }

    /* 제목 스타일 */
    p {
      font-size: 20px;
      font-weight: bold;
      color: #4a4a4a;
      margin-top: 30px;
      margin-bottom: 15px;
      border-bottom: 2px solid #ddd;
      padding-bottom: 8px;
    }

      /* 지역 셀렉트 박스 스타일 */
    #region {
           appearance: none;
           background-color: #fff;
           border: 1px solid #ccc;
           border-radius: 4px;
           padding: 8px 10px;
           width: 300px;
           height: 35px;
           font-size: 14px;
           color: #333;
           cursor: pointer;

           /* 드롭다운 화살표는 기본값 사용하거나, 필요 시 커스텀 */
           background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill="%23888" d="M8 10L4 6H12z"/></svg>');
           background-repeat: no-repeat;
           background-position: right 10px center;
           background-size: 16px;
         }


    .facilities-list {
      list-style: none; /* 리스트의 점 제거 */
      padding: 0;
      margin: 0;
      display: flex; /* Flexbox를 사용하여 항목들을 가로로 나열 */
      flex-wrap: wrap; /* 창 크기가 줄어들면 자동으로 다음 줄로 넘어감 */
    }

    .facilities-list li {
      margin-right: 20px; /* 각 항목 사이의 간격 */
      white-space: nowrap; /* 줄바꿈 방지 */
    }

    .facilities-list li input[type="checkbox"] {
      /* 체크박스 스타일 (필요 시 커스터마이징) */
      vertical-align: middle;
    }

    .facilities-list li label {
      /* 라벨 스타일 */
      vertical-align: middle;
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
    <div class="page-title">
      <h2>극장 등록</h2>
    </div>

    <form action="Controller?type=adminTheaterRegistration" method="post" encType="multipart/form-data">
      <input type="hidden" name="boardType" value="이벤트"/>

      <p>극장 기본 정보</p>
      <table class="board-table">
        <caption>극장 등록하기</caption>
        <tbody>
        <tr>
          <th class="w100"><label for="tName">지점명</label></th>
          <td><input type="text" id="tName" name="tName"/></td>
        </tr>
        <tr>
          <th class="w100"><label for="tInfo">지점 설명</label></th>
          <td><input type="text" id="tInfo" name="tInfo"/></td>
        </tr>
        <tr>
          <th class="w100">지역</th>
          <td>
            <select name="region" id="region">
              <option value="">지역을 선택하세요</option>
              <option value="seoul">서울</option>
              <option value="incheon">인천</option>
              <option value="busan">부산</option>
              <option value="daegu">대구</option>
              <option value="daejeon">대전</option>
              <option value="gwangju">광주</option>
              <option value="ulsan">울산</option>
              <option value="gyeonggi">경기</option>
              <option value="gangwon">강원</option>
              <option value="chungbuk">충북</option>
              <option value="chungnam">충남</option>
              <option value="jeonbuk">전북</option>
              <option value="jeonnam">전남</option>
              <option value="gyeongbuk">경북</option>
              <option value="gyeongnam">경남</option>
              <option value="jeju">제주</option>
            </select>
          </td>
        </tr>
        <tr>
          <th class="w100"><label for="tAddress">주소</label></th>
          <td>
            <input type="text" id="tAddress" name="tAddress" readonly/>
            <button type="button" id="addressSearch" onclick="findAddr()">주소 찾기</button>
          </td>
        </tr>
        </tbody>
      </table>

      <p>극장 상세 정보 안내</p>
      <table class="board-table">
        <tbody>
        <tr>
          <th class="w100">보유시설</th>
          <td>
            <ul class="facilities-list">
              <li>
                <input type="checkbox" id="basicScreen" name="facilities" value="일반상영관"/>
                <label for="basicScreen">일반상영관</label>
              </li>
              <li>
                <input type="checkbox" id="disabledSeat" name="facilities" value="장애인석"/>
                <label for="disabledSeat">장애인석</label>
              </li>
              <li>
                <input type="checkbox" id="snackBar" name="facilities" value="스낵바"/>
                <label for="snackBar">스낵바</label>
              </li>
              <li>
                <input type="checkbox" id="sweetRoom" name="facilities" value="스위트룸"/>
                <label for="sweetRoom">스위트룸</label>
              </li>
              <li>
                <input type="checkbox" id="4dx" name="facilities" value="4DX"/>
                <label for="4dx">4DX</label>
              </li>
            </ul>
          </td>
        </tr>
        <tr>
          <th class="w100">층별 안내</th>
          <td>
            <div class="floor-group">
              <input type="checkbox" id="floor1Check" onclick="toggleTextarea('floor1')"/>
              <label for="floor1Check">1층</label>
              <textarea id="floor1Textarea" name="floor1_info" style="display: none;" rows="5" cols="50" placeholder="1층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor2Check" onclick="toggleTextarea('floor2')"/>
              <label for="floor2Check">2층</label>
              <textarea id="floor2Textarea" name="floor2_info" style="display: none;" rows="5" cols="50" placeholder="2층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor3Check" onclick="toggleTextarea('floor3')"/>
              <label for="floor3Check">3층</label>
              <textarea id="floor3Textarea" name="floor3_info" style="display: none;" rows="5" cols="50" placeholder="3층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor4Check" onclick="toggleTextarea('floor4')"/>
              <label for="floor4Check">4층</label>
              <textarea id="floor4Textarea" name="floor4_info" style="display: none;" rows="5" cols="50" placeholder="4층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor5Check" onclick="toggleTextarea('floor5')"/>
              <label for="floor5Check">5층</label>
              <textarea id="floor5Textarea" name="floor5_info" style="display: none;" rows="5" cols="50" placeholder="5층 시설 정보를 입력하세요."></textarea>
            </div>
          </td>
        </tr>
        <tr>
          <th>주차 안내</th>
          <td>
            <textarea id="parkingInfo" name="parking_info" rows="3" cols="50" placeholder="예: 기계식 주차장 운영 중으로 혼잡한 경우 주차장 입차가 불가능하거나 입출차 시간이 30분 이상 소요될 수 있습니다."></textarea>
          </td>
        </tr>
        <tr>
          <th>주차 확인</th>
          <td>
            <textarea id="parkingValidation" name="parking_validation" rows="3" cols="50" placeholder="예: 티켓 하단의 주차확인 바코드로 무인 정산하세요.&#10;지하 2층, 3층 엘리베이터 홀 또는 출차게이트에서 무인 정산할 수 있습니다."></textarea>
          </td>
        </tr>
        <tr>
          <th>주차 요금</th>
          <td>
            <textarea id="parkingFee" name="parking_fee" rows="3" cols="50" placeholder="예: 당일 영화 관람 시 입차시간 기준으로 3시간 무료입니다."></textarea>
          </td>
        </tr>
        <tr>
          <th>버스</th>
          <td>
            <textarea name="bus_info" rows="3" cols="50" placeholder="예: 간선버스: 721 (능동사거리역)"></textarea>
          </td>
        </tr>
        <tr>
          <th>지하철</th>
          <td>
            <textarea name="subway_info" rows="3" cols="50" placeholder="예: 5호선, 7호선 군자역 7번 출구 이용"></textarea>
          </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td colspan="2">
            <button type="submit" id="save_btn">등록</button>
            <button type="button" id="cancel_btn" onclick="goList()">취소</button>
          </td>
        </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="../js/summernote-lite.js"></script> <%--자바스크립트 파일 추가--%>
<script src="../js/lang/summernote-ko-KR.js"></script> <%--언어추가(한글)--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



<script>

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

    document.forms[0].submit();
  }

  //취소 클릭 시 목록으로 이동
  function goList(){
    location.href="Controller?type=adminTheaterList";
  }

  function toggleTextarea(floorId) {
    let checkbox = document.getElementById(floorId + 'Check');
    let textarea = document.getElementById(floorId + 'Textarea');

    if (checkbox.checked) {
      textarea.style.display = 'block';
    } else {
      textarea.style.display = 'none';
      textarea.value = ''; // 체크 해제 시 입력 내용 삭제
    }
  }

  //주소찾는 함수 정의
  function findAddr(){
    new daum.Postcode({
      oncomplete: function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
        // 예제를 참고하여 다양한 활용법을 확인해 보세요.
        var addr='';

        if(data.userSelectedType==='R'){ //도로명 주소를 선택한 경우
          addr = data.roadAddress;
        }else { //지번 주소를 선택한 경우
          addr = data.jibunAddress;
        }
        //주소를 넣는다.
        $("#tAddress").val(addr);
      }
    }).open();
  }


</script>
</body>
</html>
