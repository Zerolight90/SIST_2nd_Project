<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    width: 100px;
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

  .footer .btnSub {
    background-color: #6c757d;
    color: white;
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
        <input type="text" id="userId" name="poster" class="input" value="${requestScope.vo.poster}" style="margin-top: 10px">
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
            <input type="text" id="userId" class="input" value="" readonly>
          </div>
        </div>
        <div style="display: flex">
          <div class="divs2">
            <label for="userId">누적 관객수:</label>
            <input type="text" id="userId" class="input" value="" readonly>
          </div>
          <div class="divs2" style="margin-left: 67px">
            <label for="userId">좋아요 수:</label>
            <input type="text" id="userId" class="input" value="" readonly>
          </div>
        </div>
      </div>
      <div class="divs">
        <label for="userName">영화 장르:</label>
        <input type="text" id="userName" name="gen" class="input editable" value="${requestScope.vo.gen}">
      </div>
      <div class="divs">
        <label for="userLoginId">상영 시간:</label>
        <input type="text" id="userLoginId" class="input" value="${requestScope.vo.runtime}" readonly>
      </div>
      <div class="divs">
        <label for="userEmail">관람 등급:</label>
        <input type="email" id="userEmail" name="age" class="input editable" value="${requestScope.vo.age}">
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
        <input type="text" id="userDate" name="synop" class="input" style="height: 100px" value="${requestScope.vo.synop}">
      </div>
    </div>
  </form>

  <div class="footer">
    <button type="button" class="btn btnMain">저장</button>
    <button type="button" class="btn btnSub">취소</button>
  </div>

  <script>
    $(function () {
      $(".btnMain").on('click', function () {
        if ($(".status").is(":checked")){
          $(".statusCheck").val("상영중");
        } else {
          $(".statusCheck").val("상영종료");
        }
        console.log("최종 status 값:", $(".statusCheck").val());
        $("#frm").submit();
      })

      $(".btnSub").on('click', function () {
        $("#adminMoviesModal").dialog('close');
      })


    });
  </script>

</div>
