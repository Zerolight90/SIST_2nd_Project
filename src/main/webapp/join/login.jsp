<%@ page import="mybatis.vo.MemVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%
    String mode = request.getParameter("mode");
    //HttpSession객체가 session이라는 이름으로 이미 생성되어 제공되고 있다.
    //이런 HttpSession은 브라우저를 닫을 때까지 사용가능함!
    // 세션에 "mvo"라는 이름으로 저장된 것이 있다면 로그인을 한 상태로 인지하자!
    // 먼저 세션으로부터 "mvo"라는 이름으로 저장된 객체를 얻어내어
    // Object형 변수 obj에 저장하자!
    Object obj = session.getAttribute("mvo");
    String loginError = (String) request.getAttribute("loginError");
    String errorMessage = (String) request.getAttribute("errorMessage");

    if(obj == null){
%>
<article>

    <div id="log_fail" class="show">
        <h2>로그인</h2>
        <%
            // 에러 메시지가 있을 경우 표시
            if (loginError != null && loginError.equals("true")) {
        %>

        <div class="error-message">
            <%= errorMessage != null ? errorMessage : "로그인에 실패했습니다." %>
        </div>

        <%
            }
        %>
        <form action="" method="post">
            <tr>
                <td><label for="s_id"></label></td>
                <td>
                    <input type="text" id="s_id" name="u_id" placeholder="아이디"/>
                </td>
            </tr>

            <tr>
                <td><label for="s_pw"></label></td>
                <td>
                    <input type="password" id="s_pw" name="u_pw"  placeholder="비빌번호"/>
                </td>
            </tr>

            <!-- 로그인/회원가입 버튼 그룹 -->

            <div class="button-group main-buttons">
                <a href="javascript:exe()" class="btn login-btn">
                    로그인
                </a>
                <a href="./join/join.html" class="btn signup-btn">
                    회원가입
                </a>
            </div>
            <!-- SNS 로그인 섹션 -->
            <div class="sns-login-section">
                <p class="sns-login-title">- 또는 SNS 계정으로 로그인 -</p>
                <div class="button-group sns-buttons">
                    <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=062a60d2c107a7fcc160911d7057055b&redirect_uri=http://localhost:8080/index.jsp" class="sns-btn kakao">
                        <img src="../images/kakaotalk_sharing_btn_small.png" alt="카카오 로그인"></a>
                    <a href="#" class="sns-btn naver"><img src="../images/sns_naver.png" alt="네이버 로그인"></a>
                    <!--                    <a href="#" class="sns-btn google"><img src="../images/sns_google.png" alt="구글 로그인"></a>-->
                </div>
            </div>
        </form>
    </div>
    <%
    }else {
        //obj가  null이 아닐 경우다.
        // 이름을 얻기 위해 Object형으로 두면 안되고, MemVO로 형변환을 해야
        // 이름을 얻을 수 있다.
        MemVO mvo = (MemVO) obj;
    }

    %>
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
            document.forms[0].action = "/Controller?type=index"
            document.forms[0].submit();//서버로 보내기
    }
</script>

</body>
</html>
