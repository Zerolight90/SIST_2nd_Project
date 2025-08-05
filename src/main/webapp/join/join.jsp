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


    <form id="joinForm" action="/Controller?type=join" method="post">
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
            <input class="year" type="number" name="u_year" placeholder="년(4자)">
            <select class="month" name="u_month">
                <option value="">월</option>
                <option value="01">1월</option>
                <option value="02">2월</option>
                <option value="03">3월</option>
                <option value="04">4월</option>
                <option value="05">5월</option>
                <option value="06">6월</option>
                <option value="07">7월</option>
                <option value="08">8월</option>
                <option value="09">9월</option>
                <option value="10">10월</option>
                <option value="11">11월</option>
                <option value="12">12월</option>
            </select>
            <input class="day" type="number"  name="u_day" placeholder="일">
        </div>
    </div>

    <div class="field gender">
        <b>성별</b>
        <div>
            <label><input type="radio" name="u_gender">남자</label>
            <label><input type="radio" name="u_gender">여자</label>
            <label><input type="radio" name="u_gender">선택안함</label>
        </div>
    </div>

    <div class="field">
        <b>본인 확인 이메일*<small>(*필수사항)</small></b>
        <input type="email" id="email" name="u_email" placeholder="필수입력">
        <input class="c_btn" type="button" value="인증번호 받기" style="cursor: pointer">
        <input class="c_num" id="email_auth_key"  type="text" placeholder="인증번호를 입력하세요">
        <span id="email_auth_msg" class="error-msg"></span>
    </div>

    <div class="field tel-number">
        <b>휴대전화<small>(*필수사항)</small></b>
        <select>
            <option value="">대한민국 +82</option>
        </select>
        <div>
            <input type="tel" name="u_phone" placeholder="전화번호 입력">
        </div>

    </div>

    <input id="join_btn" type="submit" value="가입하기" style="cursor: pointer"/>
    </form>

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
        // 폼 제출 이벤트 핸들러 (유효성 검사)

        $("#joinForm").submit(function(event) {


            if ($("#u_id").val().trim() === "" || $("#id_check_msg").text().includes("중복된 아이디입니다.") || !$("#id_check_msg").text().includes("사용 가능한 아이디입니다.")) {
                alert("아이디를 올바르게 입력해주세요.");
                $("#u_id").focus();
                return false;
            }

            if ($("#u_pw").val().trim() === "" || !$("#pw_check_msg").text().includes("유효한 비밀번호입니다.")) {
                alert("비밀번호를 올바르게 입력해주세요.");
                $("#u_pw").focus();
                return false;
            }

            if ($("#u_pw_confirm").val().trim() === "" || !$("#pw_confirm_check_msg").text().includes("비밀번호가 일치합니다.")) {
                alert("비밀번호 재확인을 올바르게 입력해주세요.");
                $("#u_pw_confirm").focus();
                return false;

            }

            if ($("#u_name").val().trim() === "") {
                alert("이름을 입력해주세요.");
                $("#u_name").focus();
                return false;
            }

            // 생년월일 (년, 월, 일) 필수 입력 검사

            let birthYear = $('.year').val();
            let birthMonth = $('.month').val();
            let birthDay = $('.day').val();

            if (birthYear === "" || birthMonth === "" || birthDay === "") {
                alert("생년월일을 모두 입력해주세요.");
                return false;
            }

            let u_birth = birthYear + birthMonth + birthDay;

            if ($("#email").val().trim() === "") {

                alert("이메일을 입력해주세요.");
                $("#email").focus();
                return false;
            }

            if ($('input').val().trim() === "") {
                alert("휴대전화 번호를 입력해주세요.");
                $('input').focus();
                return false;
            }

            return true;

        });
    });


</script>

</body>
</html>
