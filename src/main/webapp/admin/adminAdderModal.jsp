<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

    .modalBody {
        padding: 25px 20px;
        background-color: #fff;
    }

    .modalDivs {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }

    .modalDivs label {
        width: 120px;
        font-weight: bold;
        padding-right: 15px;
        text-align: right;
        flex-shrink: 0;
    }

    .modalDivs .input {
        width: 250px;
        height: 36px;
        padding: 0 10px;
        border: 1px solid #ddd;
        background-color: #f5f5f5;
        border-radius: 4px;
    }

    .modalDivs .input.editable {
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

    <form action="Controller?type=adminInsert" method="post" id="adminInsert">
        <div class="modalBody">
            <div class="modalDivs">
                <label for="adminIdx">영화관 고유번호:</label>
                <input type="text" id="tIdx" name="tIdx" class="input editable" value="">
            </div>
            <div class="modalDivs">
                <label for="adminId">로그인 ID:</label>
                <input type="text" id="adminId" name="adminId" class="input editable" value="">
            </div>
            <div class="modalDivs">
                <label for="adminPw">패스워드 PW:</label>
                <input type="password" id="adminPassword" name="adminPassword" class="input editable" value="">
            </div>
            <div class="modalDivs">
                <label for="adminLevel">관리자 등급:</label>
                <select id="adminLevel" name="adminLevel" style="margin-top: 4px">
                    <option value="Super">Super</option>
                    <option value="Manager">Manager</option>
                    <option value="Staff">Staff</option>
                </select>
            </div>
        </div>
    </form>

    <div class="footer">
        <button type="button" class="btn btnMain">저장</button>
        <button type="button" class="btn btnSub">취소</button>
    </div>
</div>

<script>
    $(".btnMain").on('click', function () {
        if ("${sessionScope.vo.adminLevel}" == "Super"){
            $("#adminInsert").submit();
        } else {
            alert("Super 관리자가 아닙니다!")
        }
    })
    /*$(".btnMain").on('click', function () {
        $("#adminInsert").submit();
    })*/

    $(".btnSub").on('click', function () {
        $("#adminAdderModal").dialog('close');
    })
</script>
