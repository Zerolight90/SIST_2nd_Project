<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원탈퇴 안내</title>
  <link rel="stylesheet" href="../css/mypage/memberDelete.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<section class="member-delete-wrap">
  <h1>회원탈퇴</h1>
  <div class="notice">
    <p><strong> 쌍용박스 회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</strong></p>
    <ol>
      <li><strong>30일간 회원 재가입이 불가능합니다.</strong><br/>회원 탈퇴 후, 30일 경과 후 재가입할 수 있습니다.</li>
      <li><strong>다음에 경우에 회원 탈퇴가 제한됩니다.</strong>
        <ul>
          <li>영화예매 내역이 있는 경우</li>
          <li>모바일오더 주문건이 있는 경우</li>
          <li>기명식 기프트카드 잔액이 있을 경우</li>
          <li>기명식 기프트카드가 카드정지 상태인 경우</li>
          <li>기명식 기프트카드 환불신청이 진행중인 경우</li>
        </ul>
      </li>
      <li><strong>탈퇴 후 삭제 내역</strong><br/>
        (회원 탈퇴하시면 회원정보와 개인 보유 포인트 등 정보가 삭제되며 데이터는 복구되지 않습니다.)<br/>
        - 쌍용박스 멤버십 포인트 및 적립/차감 내역<br/>
        - 관람권 및 쿠폰<br/>
        - 영화 관람 내역<br/>
        - 간편 로그인 연동 정보
      </li>
      <li><strong>고객님께서 불편하셨던 점, 아쉬웠던 점을 알려주시면 앞으로 더 나은 모습으로 찾아 뵙겠습니다.</strong></li>
    </ol>
  </div>

  <form id="deleteForm">
    <fieldset>
      <legend>탈퇴 사유 (선택)</legend>
      <label><input type="radio" name="reason" value="service_issue"> 서비스 장애가 잦아서</label><br/>
      <label><input type="radio" name="reason" value="low_benefit"> 이벤트 및 무료서비스 혜택이 적어서</label><br/>
      <label><input type="radio" name="reason" value="support_bad"> 불만 및 불편사항에 대한 고객응대가 나빠서</label><br/>
      <label><input type="radio" name="reason" value="facility_price"> 영화관람시 시설 및 가격등의 불만 때문에</label><br/>
      <label><input type="radio" name="reason" value="low_usage"> 이용빈도가 낮고 개인정보 유출이 우려되어</label><br/>
      <label><input type="radio" name="reason" value="rejoin"> 탈퇴 후 재가입을 위해</label><br/>
      <label><input type="radio" name="reason" value="other"> 기타</label><br/>
    </fieldset>

    <div class="pw-check">
      <label for="passwd">비밀번호 확인 (필수): </label>
      <input type="password" id="passwd" name="passwd" maxlength="50" required />
    </div>

    <div class="actions">
      <button type="button" id="btnCancel">취소</button>
      <button type="button" id="btnDelete">탈퇴하기</button>
    </div>
  </form>
</section>

<script>
  $(function(){
    // 취소 버튼: 메인(예: 예매내역)로 되돌리기
    $("#btnCancel").on("click", function(){
      // mainContent는 부모 페이지에서 선언된 영역입니다; 부모에서 load 호출
      if(window.parent && window.parent.$ && window.parent.$("#mainContent").length){
        window.parent.$("#mainContent").load("${cp}/Controller?type=myReservation");
      } else {
        history.back();
      }
    });

    // 탈퇴 버튼: 간단한 클라이언트 검증 후 Ajax 제출
    $("#btnDelete").on("click", function(){
      var pw = $("#passwd").val();
      if(!pw){
        alert("비밀번호를 입력해 주세요.");
        return;
      }
      if(!confirm("정말로 탈퇴하시겠습니까? 탈퇴 시 복구가 불가능합니다.")){
        return;
      }
      var data = {
        passwd: pw,
        reason: $("input:checked").val() || ""
      };
      $.ajax({
        url: "${cp}/memberRemoveAction.jsp",
        type: "POST",
        data: data,
        success: function(res){
          // 서버에서 JSON 응답(예: {result:1, msg:"탈퇴완료"})을 반환한다고 가정
          try {
            var obj = (typeof res === "object") ? res : JSON.parse(res);
            if(obj.result == 1){
              alert("탈퇴가 완료되었습니다.");
              // 세션 만료 및 메인 리다이렉트 권장
              if(window.parent && window.parent.location){
                window.parent.location.href = "${cp}/Controller?type=home";
              } else {
                location.href = "${cp}/Controller?type=home";
              }
            } else {
              alert(obj.msg || "탈퇴에 실패했습니다. 비밀번호를 확인해주세요.");
            }
          } catch(e){
            alert("서버 응답 처리 중 오류가 발생했습니다.");
          }
        },
        error: function(xhr){
          alert("서버 통신 오류가 발생했습니다.");
        }
      });
    });
  });
</script>
</body>
</html>
