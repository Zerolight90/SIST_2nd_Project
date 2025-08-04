<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="<c:url value="/css/reset.css"/>">
    <link rel="stylesheet" href="<c:url value="/css/join.css"/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="/images/favicon.png">
</head>

<body>

<div class="member">
    <img class="logo" src="../images/logo.png">

    <div class="field">
        <b>아이디<small>(*필수사항) <span id="id_check_msg" class="error-msg"></span></small></b>
        <span class="placehold-text"><input id="u_id" name="u_id" type="text"
                                            placeholder="영문/숫자 조합 4~12자여야 합니다" value="${param.u_id}"/></span>
    </div>

    <div class="field">
        <b>비밀번호<small>(*필수사항)</small></b>
        <input id="u_pw" name="u_pw" class="userpw" type="password"
               placeholder="영문, 숫자, 특수문자 조합 8~16자여야 합니다." value="${param.u_pw}"/>
        <span id="pw_check_msg" class="error-msg"></span>
    </div>
    <div class="field">
        <b>비밀번호 재확인<small>(*필수사항)</small></b>
        <input id="u_pw_confirm" name="u_pw_confirm" class="userpw-confirm" type="password"/>
        <span id="pw_confirm_check_msg" class="error-msg"></span>
    </div>


    <div class="field">
        <b>이름<small>(*필수사항)</small></b>
        <input type="text" id="u_name" name="u_name" value="${param.u_name}">
    </div>

    <div class="field birth">
        <b>생년월일<small>(*필수사항)</small></b>
        <div>
            <input type="number" placeholder="년(4자)">
            <select>
                <option value="">월</option>
                <option value="">1월</option>
                <option value="">2월</option>
                <option value="">3월</option>
                <option value="">4월</option>
                <option value="">5월</option>
                <option value="">6월</option>
                <option value="">7월</option>
                <option value="">8월</option>
                <option value="">9월</option>
                <option value="">10월</option>
                <option value="">11월</option>
                <option value="">12월</option>
            </select>
            <input type="number" placeholder="일">
        </div>
    </div>

    <div class="field gender">
        <b>성별</b>
        <div>
            <label><input type="radio" name="gender">남자</label>
            <label><input type="radio" name="gender">여자</label>
            <label><input type="radio" name="gender">선택안함</label>
        </div>
    </div>

    <div class="field">
        <b>본인 확인 이메일*<small>(*필수사항)</small></b>
        <input type="email" id="email" name="email" placeholder="필수입력">
        <input class="c_btn" type="button" value="인증번호 받기">
        <input class="c_num" id="email_auth_key"  type="text" placeholder="인증번호를 입력하세요">
    </div>

    <div class="field tel-number">
        <b>휴대전화<small>(*필수사항)</small></b>
        <select>
            <option value="">대한민국 +82</option>
        </select>
        <div>
            <input type="tel" placeholder="전화번호 입력">
        </div>

    </div>

    <input id="join_btn" type="submit" value="가입하기"/>

    <div class="member-footer">
        <div>
            <a href="#none">이용약관</a>
            <a href="#none">개인정보처리방침</a>
            <a href="#none">책임의 한계와 법적고지</a>
            <a href="#none">회원정보 고객센터</a>
        </div>
        <span><a href="#none">SIST CINEMA Corp.</a></span>
    </div>
</div>

<script>

    $(function (){

        $("#u_id").on("keyup", function (){
            let u_id = $(this).val().trim();
            let idCheckRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{4,12}$/;

            $("#u_id").removeClass("error");
            $("#id_check_msg").text("").css("color", "red");

            if (u_id.length === 0) {
                return;
            }

            if (!idCheckRegex.test(u_id)) {
                $("#u_id").addClass("error");
                $("#id_check_msg").text("아이디는 영문/숫자 조합 4~12자여야 합니다.");
                return;
            }

            $.ajax({
                url: "idCheck.jsp",
                type: "post",
                data: { u_id: u_id },
                dataType: 'json'
            }).done(function (result){
                if (result.isDuplicate) {
                    $("#u_id").addClass("error");
                    $("#id_check_msg").text("중복된 아이디입니다.");
                } else {
                    $("#id_check_msg").text("사용 가능한 아이디입니다.").css("color", "green");
                }
            }).fail(function (xhr, status, error) {
                console.error("ID Check AJAX Error:", status, error);
                $("#id_check_msg").text("아이디 확인 중 오류가 발생했습니다. 다시 시도해주세요.");
                $("#u_id").addClass("error");
            });
        });

        // 비밀번호 유효성 검사
        $("#u_pw").on("keyup", function() {
            let u_pw = $(this).val();
            // 영문, 숫자, 특수문자 중 2가지 이상 조합, 8~16자
            // (?=.*[a-zA-Z]) : 최소 하나의 영문자
            // (?=.*[0-9]) : 최소 하나의 숫자
            // (?=.*[!@#$%^&*]) : 최소 하나의 특수문자
            // .{8,16} : 8자에서 16자
            let pwCheckRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,16}$/; // 영문, 숫자, 특수문자 조합 8~16자 (예시)

            // 초기화
            $("#u_pw").removeClass("error");
            $("#pw_check_msg").text("");

            if (u_pw.length === 0) {
                // 비밀번호가 비어있을 때 재확인 필드도 초기화
                $("#u_pw_confirm").removeClass("error");
                $("#pw_confirm_check_msg").text("");
                return;
            }

            if (!pwCheckRegex.test(u_pw)) {
                $("#u_pw").addClass("error");
                $("#pw_check_msg").text("비밀번호는 영문, 숫자, 특수문자 조합 8~16자여야 합니다.");
            } else {
                $("#pw_check_msg").text("유효한 비밀번호입니다.").css("color", "green");
            }

            // 비밀번호가 변경될 때마다 재확인 필드도 다시 검사
            checkPasswordMatch();
        });

        // 비밀번호 재확인 검사
        $("#u_pw_confirm").on("keyup", function() {
            checkPasswordMatch();
        });

        // 비밀번호 일치 여부 확인 함수
        function checkPasswordMatch() {
            let u_pw = $("#u_pw").val();
            let u_pw_confirm = $("#u_pw_confirm").val();

            // 초기화
            $("#u_pw_confirm").removeClass("error");
            $("#pw_confirm_check_msg").text("");

            if (u_pw_confirm.length === 0) {
                return;
            }

            if (u_pw !== u_pw_confirm) {
                $("#u_pw_confirm").addClass("error");
                $("#pw_confirm_check_msg").text("비밀번호가 일치하지 않습니다.");
            } else {
                if ($("#pw_check_msg").text().includes("유효한 비밀번호입니다.")) { // 비밀번호도 유효할 경우에만
                    $("#pw_confirm_check_msg").text("비밀번호가 일치합니다.").css("color", "green");
                }
            }
        }
    });

</script>

</body>
</html>
