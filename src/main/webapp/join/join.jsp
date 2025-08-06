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
                <div style="border: none; background: none;">
                    <label><input type="radio" name="u_gender">남자</label>
                    <label><input type="radio" name="u_gender">여자</label>
                    <label><input type="radio" name="u_gender">선택안함</label>
                </div>
            </div>

            <div class="field auth-field">
                <b>본인 확인 이메일*<small>(*필수사항)</small></b>
                <input type="email" id="email" name="u_email" placeholder="필수입력" value="${param.u_email}">
                <input class="c_btn" type="button" value="인증번호 받기" style="cursor: pointer">

                <!-- 이메일 인증번호 입력 필드 -->
                <input class="c_num" id="email_auth_key" name="email_auth_key" type="text"
                       placeholder="인증번호를 입력하세요" value="${param.email_auth_key}">
                <!-- 이메일 인증 메시지 표시 영역 -->

                    <span id="email_auth_msg" class="error-msg" style="color: red;">
<%--                            ${errorMsg}--%>
                    </span>


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
                <a href="#">이용약관</a>
                <a href="#">개인정보처리방침</a>
                <a href="#">책임의 한계와 법적고지</a>
                <a href="#">회원정보 고객센터</a>
            </div>
            <span><a href="#">SIST CINEMA Corp.</a></span>
        </div>
    </div>

    <script>
        $(function (){
            if ("${not empty requestScope.errorMsg}" === "true" || "${not empty param.email_auth_key}" === "true") {

                $("#email_auth_key").css("display", "block");
                $("#email_auth_msg").css("display", "block");
                if ("${requestScope.errorMsg}" !== "") {
                    $("#email_auth_msg").text("${requestScope.errorMsg}").css("color", "red");
                    $("#email_auth_key").addClass("error"); // 오류 시 빨간 테두리
                } else if ("${not empty param.email_auth_key}" === "true") { // 인증번호만 있을 경우 (성공이거나 아직 확인 전)
                    // 만약 서버에서 인증 성공 여부도 같이 내려준다면 여기에 초록색 메시지 등 추가 가능
                    $("#email_auth_msg").text("인증번호를 입력해주세요.").css("color", "red"); // 초기 상태
                }

            }


            // 아이디 유효성 검사 및 중복 확인
            $("#u_id").on("keyup", function (){
                let u_id = $(this).val().trim();
                // 영문/숫자 조합 4~12자 정규식
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
                    url: "Controller?type=idcheck",
                    type: "post",
                    data: { u_id: u_id },
                    dataType: 'json'

                }).done(function (response){
                    console.log(response)
                    if (response.isDuplicate) {
                        $("#u_id").addClass("error");
                        $("#id_check_msg").text("중복된 아이디입니다.");
                    } else {
                        $("#id_check_msg").text("사용 가능한 아이디입니다.").css("color", "green");
                    }
                })
            });


            $("#u_pw").on("keyup", function() {
                let u_pw = $(this).val();

                let pwCheckRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,16}$/;


                $("#u_pw").removeClass("error");
                $("#pw_check_msg").text("");

                if (u_pw.length === 0) {

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

                checkPasswordMatch();
            });


            $("#u_pw_confirm").on("keyup", function() {
                checkPasswordMatch();
            });


            function checkPasswordMatch() {
                let u_pw = $("#u_pw").val();
                let u_pw_confirm = $("#u_pw_confirm").val();


                $("#u_pw_confirm").removeClass("error");
                $("#pw_confirm_check_msg").text("");

                if (u_pw_confirm.length === 0) {
                    return;
                }

                if (u_pw !== u_pw_confirm) {
                    $("#u_pw_confirm").addClass("error");
                    $("#pw_confirm_check_msg").text("비밀번호가 일치하지 않습니다.");
                } else {
                    if ($("#pw_check_msg").text().includes("유효한 비밀번호입니다.")) {
                        $("#pw_confirm_check_msg").text("비밀번호가 일치합니다.").css("color", "green");
                    }
                }
            }


            $(".c_btn").click(function() {
                let email = $("#email").val().trim();
                $("#email_auth_msg").text("").css("color", "red");

                if(email === "") {
                    alert("이메일을 입력해 주세요.");
                    $("#email").focus();
                    return;
                }


                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!emailRegex.test(email)) {
                    $("#email_auth_msg").text("유효한 이메일 주소를 입력해주세요.").css("color", "red");
                    $("#email").addClass("error");
                    return;
                } else {
                    $("#email").removeClass("error");
                }

                alert("인증번호가 발송되었습니다.");

                $.ajax({
                    url:  "Controller?type=emailAuth",
                    type: "POST",
                    data: { email: email },
                    dataType: "json"
                }).done(function(response) {
                    if(response.success) {

                        $("#email_auth_msg").text("인증번호가 발송되었습니다. 메일을 확인하세요.").css("color", "green");
                        $("#email_auth_key").show();
                        $("#email_auth_msg").show();
                        $("#email_auth_key").focus();
                    } else {
                        $("#email_auth_msg").text(response.message).css("color", "red");
                        $("#email_auth_key").show();
                        $("#email_auth_msg").show();
                    }
                }).fail(function() {
                    $("#email_auth_msg").text("인증번호 전송 중 오류가 발생했습니다.").css("color", "red");
                    $("#email_auth_key").show();
                    $("#email_auth_msg").show();
                });
            });

            $("#email_auth_key").on("keyup blur", function () {
                let authCode = $(this).val().trim();
                if (authCode.length === 0) {
                    $("#email_auth_msg").text("");
                    $("#email_auth_key").removeClass("error success");
                    return;
                }

                $.ajax({
                    url:"Controller?type=emailAuthVerify",
                    type: "POST",
                    data: { authCode: authCode},
                    dataType: "json"
                }).done(function (response) {
                    if (response.match) {
                        $("#email_auth_msg").text("인증번호가 일치합니다.").css("color", "green");
                        $("#email_auth_key")
                            .removeClass("error")
                            .addClass("success");
                    } else {
                        $("#email_auth_msg").text(response.message).css("color", "red");
                        $("#email_auth_key")
                            .removeClass("success")
                            .addClass("error");
                    }
                });
            });


            // 유효성 검사
            $("#joinForm").submit(function(event) {

                // 이메일 인증번호 입력 여부 검사 (클라이언트 측)
                let emailAuthKey = $("#email_auth_key").val().trim();
                if (emailAuthKey === "" || $("#email_auth_key").css("display") === "none") {
                    alert("이메일 인증을 완료해주세요.");
                    $("#email").focus();
                    return false;
                }
                return true;

                // if ($("#u_id").val().trim() === "" || $("#id_check_msg").text().includes("중복된 아이디입니다.") || !$("#id_check_msg").text().includes("사용 가능한 아이디입니다.")) {
                //     alert("아이디를 올바르게 입력해주세요.");
                //     $("#u_id").focus();
                //     return false;
                // }
                //
                // if ($("#u_pw").val().trim() === "" || !$("#pw_check_msg").text().includes("유효한 비밀번호입니다.")) {
                //     alert("비밀번호를 올바르게 입력해주세요.");
                //     $("#u_pw").focus();
                //     return false;
                // }
                //
                // if ($("#u_pw_confirm").val().trim() === "" || !$("#pw_confirm_check_msg").text().includes("비밀번호가 일치합니다.")) {
                //     alert("비밀번호 재확인을 올바르게 입력해주세요.");
                //     $("#u_pw_confirm").focus();
                //     return false;
                // }
                //
                // if ($("#u_name").val().trim() === "") {
                //     alert("이름을 입력해주세요.");
                //     $("#u_name").focus();
                //     return false;
                // }
                //
                // let birthYear = $('.year').val();
                // let birthMonth = $('.month').val();
                // let birthDay = $('.day').val();
                //
                // if (birthYear === "" || birthMonth === "" || birthDay === "") {
                //     alert("생년월일을 모두 입력해주세요.");
                //     return false;
                // }
                //
                // if ($("#email").val().trim() === "") {
                //     alert("이메일을 입력해주세요.");
                //     $("#email").focus();
                //     return false;
                // }
                //
                // if ($('input[name="u_phone"]').val().trim() === "") {
                //     alert("휴대전화 번호를 입력해주세요.");
                //     $('input[name="u_phone"]').focus();
                //     return false;
                // }


            });
        });
    </script>

    </body>
    </html>
