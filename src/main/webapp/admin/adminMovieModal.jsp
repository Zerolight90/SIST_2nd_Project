<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
  .userModal {
    font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
    font-size: 14px;
    color: #333;
    width: 1000px;
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
  }

  .modalTitle {
    background-color: #20c997;
    color: white;
    padding: 15px 20px;
    font-size: 18px;
    font-weight: bold;
  }

  .modalTitle h2 {
    margin: 0;
  }

  .body {
    padding: 25px 20px;
    background-color: #fff;
  }

  .divs {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
  }

  .divs label {
    width: 120px;
    font-weight: bold;
    padding-right: 15px;
    text-align: right;
    flex-shrink: 0;
  }

  .divs .input {
    width: 370px;
    height: 36px;
    padding: 0 10px;
    border: 1px solid #ddd;
    background-color: #f5f5f5;
    border-radius: 4px;
  }

  .divs .input.editable {
    background-color: #fff;
  }

  .divs2 {
    align-items: center;
    margin-bottom: 15px;
  }

  .divs2 label {
    width: 60px;
    font-weight: bold;
    padding-right: 15px;
    text-align: right;
    flex-shrink: 0;
  }

  .divs2 .input {
    width: 99px;
    height: 24px;
    padding: 0 10px;
    border: 1px solid #ddd;
    background-color: #f5f5f5;
    border-radius: 4px;
  }

  .divs2 .input.editable {
    background-color: #fff;
  }

  .footer {
    padding: 20px;
    text-align: center;
    border-top: 1px solid #eee;
    background-color: #f8f9fa;
  }

  .footer .btn {
    padding: 10px 30px;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin: 0 5px;
  }

  .footer .btnMain {
    background-color: #007bff;
    color: white;
  }

  .btn {
    padding: 10px 30px;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin: 0 5px;
  }

  .btnMain {
    background-color: #007bff;
    color: white;
  }

  .footer .btnSub {
    background-color: #6c757d;
    color: white;
  }

  .modalTitle {
    background-color: #20c997;
    color: white;
    padding: 15px 20px;
    font-size: 18px;
    font-weight: bold;
  }
  .modalTitle h2 { margin: 0; }
  .body3 { padding: 25px 20px; }
  .divs3 { display: flex; align-items: center; margin-bottom: 15px; }
  .divs3 label { width: 140px; font-weight: bold; text-align: right; padding-right: 15px; flex-shrink: 0; }
  .divs3 .input { width: 100%; height: 36px; padding: 0 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
  .divs3 .input.editable { background-color: #fff; }
  .footer3 { padding: 20px; text-align: center; border-top: 1px solid #eee; background-color: #f8f9fa; }
  .footer3 .btn { padding: 10px 30px; border: none; border-radius: 4px; font-size: 16px; font-weight: bold; cursor: pointer; margin: 0 5px; }
  .footer3 .btnMain { background-color: #007bff; color: white; }
  .footer3 .btnSub { background-color: #6c757d; color: white; }
  .no-titlebar .ui-dialog-titlebar {
    display: none;
  }
</style>

<div class="userModal">
  <div class="modalTitle">
    <h2>영화 상세 정보</h2>
  </div>

  <form action="Controller?type=adminMoviesUpdate" method="post" id="frm" style="display: flex">
    <div>
      <div class="divs" style="margin: 30px; display: block">
        <img src="${requestScope.vo.poster}" style="width: 370px; margin-bottom: 15px">
        <label for="userId">포스터 이미지 URL:</label><br/>
        <input type="text" id="userId" name="poster" class="input" value="${requestScope.vo.poster}" readonly style="margin-top: 10px">
        <label for="userId" style="position: relative; top: 10px">상세 포스터 이미지 URL:</label><br/>
        <input type="text" id="userId" name="poster" class="input" value="${requestScope.vo.background}" readonly style="margin-top: 20px">
      </div>
      <div></div>
    </div>

    <div class="body">
      <div class="divs">
        <label for="userId">영화 제목:</label>
        <input type="text" id="userId" name="name" class="input" value="${requestScope.vo.name}" readonly>
      </div>
      <div style="display: block; margin-left: 55px; width: 505px">
        <div style="display: flex">
          <div class="divs2">
            <label for="userId" style="position: relative; bottom: 7px">상영 상태:</label>
            
            <c:if test="${requestScope.vo.status == '상영중'}">
              <input type="checkbox" id="userId" class="input editable status" value="${requestScope.vo.status}" checked style="margin-left: 14px">
            </c:if>
            <c:if test="${requestScope.vo.status != '상영중'}">
              <input type="checkbox" id="userId" class="input editable status" value="${requestScope.vo.status}" style="margin-left: 14px">
            </c:if>

            <input type="hidden" class="statusCheck" name="statusCheck" value="">

            <%--<input type="checkbox" id="userId" class="input editable" value="${requestScope.vo.status}" style="margin-left: 14px">--%>
          </div>
          <div class="divs2" style="margin-left: 83px">
            <label for="userId">  예매율:</label>
            <input type="text" id="userId" class="input" value="${requestScope.movie.bookingRate}&nbsp;%" readonly>
          </div>
        </div>
        <div style="display: flex">
          <div class="divs2">
            <label for="userId">누적 관객수:</label>
            <input type="text" id="userId" class="input" value="${requestScope.vo.audNum}&nbsp;명" readonly>
          </div>
          <div class="divs2" style="margin-left: 67px">
            <label for="userId">좋아요 수:</label>
            <input type="text" id="userId" class="input" value="${requestScope.like}&nbsp;개" readonly>
          </div>
        </div>
      </div>
      <div class="divs">
        <label for="userName">영화 장르:</label>
        <input type="text" id="userName" name="gen" class="input editable" value="${requestScope.vo.gen}">
      </div>
      <div class="divs">
        <label for="userLoginId">상영 시간:</label>
        <input type="text" id="userLoginId" class="input" value="${requestScope.vo.runtime}&nbsp;분" readonly>
      </div>
      <div class="divs">
        <label for="userEmail">관람 등급:</label>

<%--        <c:choose>--%>
<%--          <c:when test="${requestScope.vo.age eq 'ALL'}">--%>
<%--            <input type="text" id="userEmail" name="age" class="input editable" value="전체 이용가">--%>
<%--          </c:when>--%>
<%--          <c:when test="${requestScope.vo.age == 12}">--%>
<%--            <input type="text" id="userEmail" name="age" class="input editable" value="12세 이용가">--%>
<%--          </c:when>--%>
<%--          <c:when test="${requestScope.vo.age == 15}">--%>
<%--            <input type="text" id="userEmail" name="age" class="input editable" value="15세 이용가">--%>
<%--          </c:when>--%>
<%--          <c:when test="${requestScope.vo.age == 19}">--%>
<%--            <input type="text" id="userEmail" name="age" class="input editable" value="19세 이용가">--%>
<%--          </c:when>--%>
<%--          <c:otherwise>--%>
<%--            <input type="text" id="userEmail" name="age" class="input editable" value="정보 없음">--%>
<%--          </c:otherwise>--%>
<%--        </c:choose>--%>

        <input type="text" id="userEmail" name="age" class="input editable" value="${requestScope.vo.age}">
      </div>
      <div class="divs">
        <label for="userPhone">개봉일:</label>
        <input type="text" id="userPhone" name="date" class="input editable" value="${requestScope.vo.date}">
      </div>
      <div class="divs">
        <label for="userPoint">감독:</label>
        <input type="text" id="userPoint" name="dir" class="input editable" value="${requestScope.vo.dir}">
      </div>
      <div class="divs">
        <label for="userLevel">주요 배우:</label>
        <input type="text" id="userLevel" class="input" value="${requestScope.vo.actor}" style="height: 90px" readonly>
      </div>
      <div class="divs">
        <label for="userDate">시놉시스:</label>
        <textarea id="userDate" name="synop" class="input" style="height: 100px; word-wrap: break-word; padding: 7px 10px" readonly>${requestScope.vo.synop}</textarea>
      </div>
      <div class="divs">
        <label for="trailer">영화 예고편 URL:</label>
        <input type="text" id="trailer" name="trailer" class="input" style="height: 36px" readonly value="${requestScope.vo.trailer}">
      </div>
      <div>
        <button type="button" class="btn btnMain" id="timeTable" style="margin-left: 347px;">상영 시간표 생성</button>
      </div>
    </div>
  </form>

  <div id="createTimetableModal" style="display: none">
    <div class="modalTitle"><h2>상영 시간표 생성</h2></div>
    <form action="Controller?type=createTimeTable" method="post" id="createTimetableForm">
      <input type="hidden" name="mIdx" value="${requestScope.vo.mIdx}">
      <div class="body3">
        <div class="divs3">
          <label for="tIdx">어드민 관리 영화관:</label>
          <input type="text" id="tIdx" name="tIdx" class="input editable" value="${sessionScope.vo.tIdx}" readonly>
        </div>
        <div class="divs3">
          <label for="sIdx">상영관:</label>
          <input type="text" name="sIdx" id="sIdx" class="input editable" value="" required>
        </div>
        <div class="divs3">
          <label for="startTime">상영 시작시간:</label>
          <select id="startTime" name="startTime">
            <option value="09:00:00">9:00</option>
            <option value="11:30:00">11:30</option>
            <option value="14:00:00">14:00</option>
            <option value="16:30:00">16:30</option>
            <option value="19:00:00">19:00</option>
            <option value="21:30:00">21:30</option>
          </select>
        </div>
        <div class="divs3">
          <label for="inDatepicker">상영일:</label>
          <input type="text" name="inDatepicker" id="inDatepicker" class="input editable" value="" required>
        </div>
      </div>
      <div class="footer3">
        <button type="button" class="btn btnMain create">생성</button>
        <button type="button" class="btn btnSub cancel">취소</button>
      </div>
    </form>
  </div>

  <div class="footer">
    <button type="button" class="btn btnMain">저장</button>
    <button type="button" class="btn btnSub">취소</button>
  </div>

  <script>
    $(function () {
      // Datepicker에 적용할 옵션
      let option = {
        monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
        monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
        dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
        weekHeader: "주",
        dateFormat: "yy-mm-dd",
        showMonthAfterYear: true,
        yearSuffix: "년",
        showOtherMonths: true,
        selectOtherMonths: true
      };
      $("#inDatepicker").datepicker(option);

      $("#createTimetableModal").dialog({
        autoOpen: false,
        modal: true,
        width: 550,
        resizable: false,
        open: function() {
          $(this).find("#inDatepicker").datepicker(option);
        }
      })

      $(".footer .btnMain").on('click', function () {
        if ($(".status").is(":checked")){
          $(".statusCheck").val("상영중");
        } else {
          $(".statusCheck").val("상영종료");
        }
        console.log("최종 status 값:", $(".statusCheck").val());
        $("#frm").submit();
      })

      $(".footer .btnSub").on('click', function () {
        $("#adminMoviesModal").dialog('close');
      })
      $(".cancel").on('click', function () {
        $("#createTimetableModal").dialog('close');
      })

      $("#timeTable").on('click', function () {
        $("#createTimetableModal").dialog('open');
      })
      
      $(".create").on('click', function () {
        $("#createTimetableForm").submit();
      })
    });
  </script>

</div>
