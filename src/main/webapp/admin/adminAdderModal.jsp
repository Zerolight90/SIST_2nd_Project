<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .userModal {
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        font-size: 14px;
        color: #333;
        width: 480px;
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
        <h2>관리자 추가</h2>
    </div>

    <div class="body">
        <div class="divs">
            <label for="userId">관리자 고유번호:</label>
            <input type="text" id="userId" class="input" value="" readonly>
        </div>
        <div class="divs">
            <label for="userName">로그인 ID:</label>
            <input type="text" id="userName" class="input editable" value="">
        </div>
        <div class="divs">
            <label for="userLoginId">패스워드 PW:</label>
            <input type="text" id="userLoginId" class="input" value="" readonly>
        </div>
        <div class="divs">
            <label for="userEmail">관리자 등급:</label>
            <input type="email" id="userEmail" class="input editable" value="">
        </div>
        <div class="divs">
            <label for="userPhone">관리자 상태:</label>
            <input type="text" id="userPhone" class="input editable" value="">
        </div>
    </div>

    <div class="footer">
        <button type="button" class="btn btnMain">저장</button>
        <button type="button" class="btn btnSub">취소</button>
    </div>
</div>
