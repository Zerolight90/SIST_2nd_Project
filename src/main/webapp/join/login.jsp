<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스-로그인</title>
    <link rel="stylesheet" href="../css/sub/sub_page_style.css">
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="../images/favicon.png">
</head>

<body>
<article>
    <%-- 가입완료 메시지 알림 --%>
    <c:if test="${not empty msg}">
        <script>
            alert("${msg}");
        </script>
    </c:if>

    <%
        if (session.getAttribute("mvo") != null || session.getAttribute("kvo") != null) {
            response.sendRedirect("/index.jsp");
            return;
        }
    %>

    <c:if test="${empty sessionScope.mvo}">
        <div id="log_fail" class="show">
            <h2>로그인</h2>
            <c:if test="${loginError != null and loginError == true}">
                <div class="error-message" style="color:red;">
                    <c:out value="${errorMessage != null ? errorMessage : '로그인에 실패했습니다.'}"/>
                </div>
            </c:if>

            <form action="" method="post">
                <tr>
                    <td><label for="s_id"></label></td>
                    <td>
                        <input type="text" id="s_id" name="u_id" placeholder="아이디" autofocus />
                    </td>
                </tr>

                <tr>
                    <td><label for="s_pw"></label></td>
                    <td>
                        <input type="password" id="s_pw" name="u_pw"  placeholder="비밀번호"/>
                    </td>
                </tr>

                <!-- 아이디 찾기/ 비밀번호 찾기 -->
                <div class="Search">
                    <a href="/join/search.jsp">아이디 찾기 / 비밀번호 찾기</a>
                </div>

                <!-- 로그인/회원가입 버튼 그룹 -->
                <div id="login" class="button-group main-buttons">
                    <a href="javascript:exe()" class="btn login-btn">
                        로그인
                    </a>
                    <a href="<c:url value="Controller?type=join"/>" class="btn signup-btn">
                        회원가입
                    </a>
                </div>

                <div class="non_member">
                    <!-- id 중복 방지를 위해 class와 data-* 속성으로 변경 -->
                    <a href="/join/nonmenber.jsp" class="openModalBtn" data-popup-name="nonmember" data-popup-url="/join/nonmenber.jsp">비회원 예매 하기</a>
                    <span> / </span>
                    <a href="/join/nonmenber_booking.jsp" class="openModalBtn" data-popup-name="nonmember_booking" data-popup-url="/join/nonmenber_booking.jsp">비회원 예매 확인</a>
                </div>

                <!-- SNS 로그인 섹션 -->
                <div class="sns-login-section">
                    <p class="sns-login-title">- 또는 SNS 계정으로 로그인 -</p>
                    <div class="button-group sns-buttons">
                        <a href="https://kauth.kakao.com/oauth/authorize?client_id=${kakaoApiKey}&redirect_uri=${kakaoRedirectUri}&response_type=code&prompt=select_account" class="sns-btn kakao">
                            <img src="../images/sns/sns_kakao_logo.png" alt="카카오 로그인">
                        </a>

                        <a href="<c:url value='Controller?type=naverAuth'/>" class="sns-btn naver">
                            <img src="../images/sns/sns_naver_logo.png" alt="네이버 로그인"/>
                        </a>
                    </div>
                </div>

            </form>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.mvo}">
        <%-- 로그인 상태 처리 (기존 코드 유지) --%>
    </c:if>
</article>

<script>
    function exe(){
        var id = $("#s_id");
        var pw = $("#s_pw");

        if(id.val().trim().length <= 0){
            alert("아이디를 입력하세요!");
            id.focus();
            return;
        }
        if(pw.val().trim().length <= 0){
            alert("비밀번호를 입력하세요!");
            pw.focus();
            return;
        }
        document.forms[0].action = "/Controller?type=login";
        document.forms[0].submit();
    }

    $(function(){
        // Enter 키로 로그인
        $('#s_id, #s_pw').on('keydown', function(e){
            var id = $("#s_id");
            var pw = $("#s_pw");

            if (e.key === 'Enter' || e.which === 13) {
                if(id.val().trim().length <= 0){
                    alert("아이디를 입력하세요!");
                    id.focus();
                    return;
                }
                if(pw.val().trim().length <= 0){
                    alert("비밀번호를 입력하세요!");
                    pw.focus();
                    return;
                }
                e.preventDefault();
                exe();
            }
        });

        // 팝업(모달 느낌)으로 새 창 열기

        $('.openModalBtn').on('click', function(e){

            e.preventDefault();
            var $this = $(this);
            var url = $this.data('popup-url') || $this.attr('href');
            var name = $this.data('popup-name') || 'popupWin';

            // 팝업 크기/옵션: 필요에 따라 조정
            var features = 'width=820,height=800,top=100,left=100,toolbar=no,menubar=no,location=no,status=no,scrollbars=yes,resizable=yes';
            var win = window.open(url, name, features);

            // 팝업 차단 확인
            if(!win || typeof win === 'undefined'){
                alert('팝업이 차단되었습니다. 브라우저의 팝업 허용 설정을 확인해 주세요.');
                return;
            }
            try {
                win.focus();
            } catch (err) {
                // same-origin 제약 등 예외 무시
            }
        });
    });
</script>
</body>
</html>
