<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <title>Title</title>
  <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
  <link rel="stylesheet" href="../css/admin.css">
  <link rel="stylesheet" href="../css/theaterRegistration.css">
  <link rel="stylesheet" href="../css/summernote-lite.css"/>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">


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
  <div class="admin-container">
    <div class="page-title">
      <h2>극장 정보 확인</h2>
    </div>

    <form>
      <input type="hidden" name="tIdx" value="${infovo.tvo.tIdx}"/>

      <p>극장 기본 정보</p>
      <table class="board-table">
        <caption>극장 정보 확인</caption>
        <tbody>
        <tr>
          <th class="w100"><label for="tName">지점명</label></th>
          <td>${infovo.tvo.tName}</td>
        </tr>
        <tr>
          <th class="w100"><label for="tInfo">지점 설명</label></th>
          <td>${infovo.tvo.tInfo}</td>
        </tr>
        <tr>
          <th class="w100">지역</th>
          <td>
            ${infovo.tvo.tRegion}
          </td>
        </tr>
        <tr>
          <th class="w100"><label for="tAddress">주소</label></th>
          <td>
            ${infovo.tvo.tAddress}
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
              <c:set var="facilitiesList" value="${fn:split(infovo.tFacilities, ',')}" />
              <c:forEach var="item" items="${facilitiesList}">
                <li>
                  <c:choose>
                    <c:when test="${item eq '일반상영관'}">
                      <span class="icon ico-theater"></span>
                    </c:when>
                    <c:when test="${item eq '장애인석'}">
                      <span class="icon ico-disabled"></span>
                    </c:when>
                    <c:when test="${item eq '부티크'}">
                      <span class="icon ico-boutique"></span>
                    </c:when>
                    <c:when test="${item eq '스위트룸'}">
                      <span class="icon ico-sweet"></span>
                    </c:when>
                    <c:when test="${item eq '컴포트'}">
                      <span class="icon ico-comfort"></span>
                    </c:when>
                    <c:when test="${item eq '스페셜'}">
                      <span class="icon ico-special"></span>
                    </c:when>
                    <c:when test="${item eq '커플석'}">
                      <span class="icon ico-couple"></span>
                    </c:when>
                    <c:otherwise>
                      <span class="icon ico-default"></span>
                    </c:otherwise>
                  </c:choose>
                  <span class="facility-item">${item}</span>
                </li>
              </c:forEach>
            </ul>
          </td>
        </tr>
        <tr>
          <th class="w100">층별 안내</th>
          <td>
            <c:set var="floorList" value="${fn:split(infovo.tFloorInfo, '
')}" />
            <c:forEach var="floor" items="${floorList}">
              <div class="floor-info-text">${floor}</div>
            </c:forEach>
          </td>
        </tr>
        <tr>
          <th>주차 안내</th>
          <td>
            <c:set var="parkingInfo" value="${infovo.tParkingInfo}" />
            <c:if test="${not empty parkingInfo}">
              <c:out value="${fn:replace(parkingInfo, 'LF', '<br/>')}" escapeXml="false" />
            </c:if>
          </td>
        </tr>
        <tr>
          <th>주차 확인</th>
          <td>
            ${infovo.tParkingChk}
          </td>
        </tr>
        <tr>
          <th>주차 요금</th>
          <td>
            ${infovo.tParkingPrice}
          </td>
        </tr>
        <tr>
          <th>버스</th>
          <td>
            ${infovo.tBusRouteToTheater}
          </td>
        </tr>
        <tr>
          <th>지하철</th>
          <td>
            ${infovo.tSubwayRouteToTheater}
          </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td colspan="2">
            <button type="button" id="edit_btn" onclick="goEditTheater()" value="수정">수정</button>
            <button type="button" id="cancel_btn" onclick="goList()" value="목록">목록</button>
          </td>
        </tr>
        </tfoot>
      </table>
    </form>

    <%--숨겨진 폼 만들기--%>
    <form name="ff" method="get">
      <input type="hidden" name="type"/>
      <input type="hidden" name="tIdx" value="${param.tIdx}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
    </form>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

<script>

  function goEditTheater(){
    document.ff.action = "Controller";
    document.ff.type.value = "adminTheaterEdit";
    document.ff.submit();
  }

  //목록 클릭 시 목록으로 이동
  function goList(){
    location.href="Controller?type=adminTheaterList&cPage=${param.cPage}";
  }

</script>
</body>
</html>
