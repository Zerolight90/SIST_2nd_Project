<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
  .userModal {
    font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
    font-size: 14px;
    color: #333;
    width: 520px;
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
    width: 250px;
    height: 36px;
    padding: 0 10px;
    border: 1px solid #ddd;
    background-color: #f5f5f5;
    border-radius: 4px;
  }

  .divs .input.editable {
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
    <h2>상영 시간표 생성</h2>
  </div>

  <div class="footer">
    <button type="button" class="btn btnMain" id="apiUpdate">영화 업데이트</button>
    <div id="updateStatus" style="margin-top: 20px; font-weight: bold;"></div>
  </div>

  <div class="body">
    <div class="divs">
      <label for="userId">몇 일 후:</label>
      <input type="text" id="userId" class="input editable" value="">
    </div>
    <div class="divs">
      <label for="userName">생성 일수:</label>
      <input type="text" id="userName" class="input editable" value="">
    </div>
  </div>

  <div>
    <ul>
      <li>상영 시간표는 현재 예매율 순위에 따라 자동 생성됩니다</li>
      <li>상영 시간대는 9:00, 11:30, 14:00, 16:30, 19:00, 21:30분으로 고정됩니다</li>
      <li>하루에 최대 90개의 영화가 상영됩니다</li>
    </ul>
  </div>

  <div class="footer">
    <button type="button" class="btn btnMain">생성</button>
    <button type="button" class="btn btnSub">취소</button>
  </div>
  
  <script>
    $(function () {
      $("#apiUpdate").on('click', function () {
        // 버튼을 비활성화하고 로딩 메시지를 표시하여 중복 클릭 방지
        $(this).prop('disabled', true).text('영화 목록 업데이트 진행 중...');
        $('#updateStatus').css('color', 'blue').text('TMDB 서버로부터 데이터를 가져와 DB에 저장하는 중입니다. 잠시만 기다려주세요...');

        $.ajax({
          url: "Controller?type=apiUpdate",
          type: "POST",
          dataType: "json"
        }) .done(function(response) {
          // 성공 시, Action에서 보낸 메시지를 표시
          $('#updateStatus').css('color', 'green').text('성공: ' + response.message);

          // 1초 후 페이지를 새로고침하여 추가된 목록을 확인
          setTimeout(function() {
            location.reload();
          }, 1000);
        })
        .fail(function() {
          // 실패 시
          $('#updateStatus').css('color', 'red').text('오류: 업데이트에 실패했습니다. 서버 로그를 확인하세요.');
        })
        .always(function() {
          // 성공/실패와 관계없이 버튼을 다시 활성화
          $('#apiUpdate').prop('disabled', false).text('TMDB 데이터 동기화');
        });
      })
      
      $(".btnMain").on('click', function () {

      })

      $(".btnSub").on('click', function () {
        $("#adminTimeModal").dialog('close');
      })
    });
  </script>
  
</div>
