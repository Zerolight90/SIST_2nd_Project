<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="../css/theaterRegistration.css">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">

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
    <div class="page-title">
      <h2>극장 등록</h2>
    </div>

    <form action="Controller?type=adminTheaterRegistration" method="post">
      <input type="hidden" name="tIdx" value="${tvo.tIdx}"/>

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
            <select name="tRegion" id="region">
              <option value="">지역을 선택하세요</option>
              <option value="서울">서울</option>
              <option value="경기">경기</option>
              <option value="인천">인천</option>
              <option value="부산">부산</option>
              <option value="대구">대구</option>
              <option value="대전">대전</option>
              <option value="광주">광주</option>
              <option value="울산">울산</option>
              <option value="강원">강원</option>
              <option value="충북">충북</option>
              <option value="충남">충남</option>
              <option value="전북">전북</option>
              <option value="전남">전남</option>
              <option value="경북">경북</option>
              <option value="경남">경남</option>
              <option value="제주">제주</option>
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
                <input type="checkbox" id="basicScreen" name="tFacilities" value="일반상영관" <c:if test="${fn:contains(infovo.tFacilities, '일반상영관')}">checked</c:if>>
                <label for="basicScreen" class="icon ico-theater">일반상영관</label><%--fn:contains ::: 포함되는 문자열 찾기--%>
              </li>
              <li>
                <input type="checkbox" id="disabledSeat" name="tFacilities" value="장애인석" <c:if test="${fn:contains(infovo.tFacilities, '장애인석')}">checked</c:if>>
                <label for="disabledSeat" class="icon ico-disabled">장애인석</label>
              </li>
              <li>
                <input type="checkbox" id="boutique" name="tFacilities" value="부티크" <c:if test="${fn:contains(infovo.tFacilities, '부티크')}">checked</c:if>>
                <label for="boutique" class="icon ico-boutique">부티크</label>
              </li>
              <li>
                <input type="checkbox" id="sweetRoom" name="tFacilities" value="스위트룸" <c:if test="${fn:contains(infovo.tFacilities, '스위트룸')}">checked</c:if>>
                <label for="sweetRoom" class="icon ico-sweet">스위트룸</label>
              </li>
              <li>
                <input type="checkbox" id="comfort" name="tFacilities" value="컴포트" <c:if test="${fn:contains(infovo.tFacilities, '컴포트')}">checked</c:if>>
                <label for="comfort" class="icon ico-comfort">컴포트</label>
              </li>
              <li>
                <input type="checkbox" id="special" name="tFacilities" value="스페셜" <c:if test="${fn:contains(infovo.tFacilities, '스페셜')}">checked</c:if>>
                <label for="special" class="icon ico-special">스페셜</label>
              </li>
              <li>
                <input type="checkbox" id="couple" name="tFacilities" value="커플석" <c:if test="${fn:contains(infovo.tFacilities, '커플석')}">checked</c:if>>
                <label for="couple" class="icon ico-couple">커플석</label>
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
              <textarea id="floor1Textarea" name="floor1Textarea" style="display: none;" rows="5" cols="50" placeholder="1층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor2Check" onclick="toggleTextarea('floor2')"/>
              <label for="floor2Check">2층</label>
              <textarea id="floor2Textarea" name="floor2Textarea" style="display: none;" rows="5" cols="50" placeholder="2층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor3Check" onclick="toggleTextarea('floor3')"/>
              <label for="floor3Check">3층</label>
              <textarea id="floor3Textarea" name="floor3Textarea" style="display: none;" rows="5" cols="50" placeholder="3층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor4Check" onclick="toggleTextarea('floor4')"/>
              <label for="floor4Check">4층</label>
              <textarea id="floor4Textarea" name="floor4Textarea" style="display: none;" rows="5" cols="50" placeholder="4층 시설 정보를 입력하세요."></textarea>
            </div>

            <div class="floor-group">
              <input type="checkbox" id="floor5Check" onclick="toggleTextarea('floor5')"/>
              <label for="floor5Check">5층</label>
              <textarea id="floor5Textarea" name="floor5Textarea" style="display: none;" rows="5" cols="50" placeholder="5층 시설 정보를 입력하세요."></textarea>
            </div>
          </td>
        </tr>
        <tr>
          <th>주차 안내</th>
          <td>
            <textarea id="tParkingInfo" name="tParkingInfo" rows="3" cols="50" placeholder="예: 기계식 주차장 운영 중으로 혼잡한 경우 주차장 입차가 불가능하거나 입출차 시간이 30분 이상 소요될 수 있습니다."></textarea>
          </td>
        </tr>
        <tr>
          <th>주차 확인</th>
          <td>
            <textarea id="tParkingChk" name="tParkingChk" rows="3" cols="50" placeholder="예: 티켓 하단의 주차확인 바코드로 무인 정산하세요.&#10;지하 2층, 3층 엘리베이터 홀 또는 출차게이트에서 무인 정산할 수 있습니다."></textarea>
          </td>
        </tr>
        <tr>
          <th>주차 요금</th>
          <td>
            <textarea id="tParkingPrice" name="tParkingPrice" rows="3" cols="50" placeholder="예: 당일 영화 관람 시 입차시간 기준으로 3시간 무료입니다."></textarea>
          </td>
        </tr>
        <tr>
          <th>버스</th>
          <td>
            <textarea name="tBusRouteToTheater" rows="3" cols="50" placeholder="예: 간선버스: 721 (능동사거리역)"></textarea>
          </td>
        </tr>
        <tr>
          <th>지하철</th>
          <td>
            <textarea name="tSubwayRouteToTheater" rows="3" cols="50" placeholder="예: 5호선, 7호선 군자역 7번 출구 이용"></textarea>
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
