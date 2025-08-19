<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스-로그인</title>
    <link rel="stylesheet" href="../css/sub/sub_page_style.css">
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
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
                    <a href="#">비회원의로 로그인 하기</a>
                </div>

                <!-- SNS 로그인 섹션 -->
                <div class="sns-login-section">
                    <p class="sns-login-title">- 또는 SNS 계정으로 로그인 -</p>
                    <div class="button-group sns-buttons">
                        <a href="https://kauth.kakao.com/oauth/authorize?client_id=${kakaoApiKey}&redirect_uri=${kakaoRedirectUri}&response_type=code&prompt=select_account" class="sns-btn kakao">
                            <img src="../images/sns/sns_kakao_logo.png" alt="카카오 로그인">
                        </a>

                        <!-- 네이버 로그인 버튼 (수정) -->
                        <a href="<c:url value='Controller?type=naverAuth'/>" class="sns-btn naver">
                            <img src="../images/sns/sns_naver_logo.png" alt="네이버 로그인"/>
                        </a>

                    </div>

                </div>



            </form>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.mvo}">
        <%-- MemberVO mvo = (MemberVO) session.getAttribute("mvo"); --%>
        <%-- 이 부분은 JSTL EL로 직접 접근하여 사용되므로 별도의 코드 변환이 필요하지 않습니다. --%>
        <%-- 예: ${sessionScope.mvo.name}와 같이 직접 속성에 접근하여 사용합니다. --%>
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
        //요청할 서버경로를 변경한다.
        document.forms[0].action = "/Controller?type=login"
        document.forms[0].submit();//서버로 보내기

    }
    // exe() 함수 아래에 추가
    $(function(){
                   // 아이디/비밀번호 입력창에서 Enter 눌렀을 때 exe() 호출
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
                e.preventDefault(); // 기본 폼 제출(중복)을 막음
                exe(); // 기존 로그인 처리 함수 호출
            }
        });
    });


</script>
</body>
</html>
