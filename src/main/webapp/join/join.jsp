<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <!--    <link rel="stylesheet" href="../css/sub/sub_page_style.css">-->
    <link rel="stylesheet" href="/css/reset.css">
    <link rel="stylesheet" href="/css/join.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="/images/favicon.png">
</head>

<body>

<div class="member">
    <!-- 1. 로고 -->
    <img class="logo" src="../images/logo.png">

    <!-- 2. 필드 -->
    <div class="field">
        <b>아이디<small>(*필수사항)</small></b>
        <span class="placehold-text"><input type="text"></span>
    </div>
    <div class="field">
        <b>비밀번호<small>(*필수사항)</small></b>
        <input class="userpw" type="password">
    </div>
    <div class="field">
        <b>비밀번호 재확인<small>(*필수사항)</small></b>
        <input class="userpw-confirm" type="password">
    </div>
    <div class="field">
        <b>이름<small>(*필수사항)</small></b>
        <input type="text">
    </div>

    <!-- 3. 필드(생년월일) -->
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

    <!-- 4. 필드(성별) -->
    <div class="field gender">
        <b>성별</b>
        <div>
            <label><input type="radio" name="gender">남자</label>
            <label><input type="radio" name="gender">여자</label>
            <label><input type="radio" name="gender">선택안함</label>
        </div>
    </div>

    <!-- 5. 이메일_전화번호 -->
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

    <!-- 6. 가입하기 버튼 -->
    <input id="join_btn" type="submit"/>

    <!-- 7. 푸터 -->
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





</body>
</html>