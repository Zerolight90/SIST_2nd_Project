<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SiST_아이디/비밀번호 찾기</title>
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/search_tab.css">
    <link rel="stylesheet" href="../css/search.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <link rel="icon" href="../images/favicon.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body>

<div id="content">

    <div class="page-content">
        <!-- 상단 탭 -->
        <div class="page-title">
            <h2 class="tit">아이디 / 비밀번호 찾기</h2>
        </div>

        <div class="ec-base-tab typeLight notice-tab-wrap ">
            <ul class="notice-tab menu">
                <li class="tabBtn on selected"><a class="btn">아이디 찾기</a></li>
                
                <li class="tabBtn"><a class="btn">비밀번호 찾기</a></li>

            </ul>
        </div>
    </div>

</div>


<script>
        // 1. 모든 탭 버튼(li)과 내용 영역(div)을 가져옵니다.
        const tabs = document.querySelectorAll('.menu li');
        const tabContents = document.querySelectorAll('.tabCont');

        // 2. 각 탭 버튼에 클릭 이벤트 리스너를 추가합니다.
        tabs.forEach((tab, index) => {
        tab.addEventListener('click', (e) => {
            // a 태그의 기본 동작(페이지 이동)을 막습니다.
            e.preventDefault();

            // 3. 모든 탭에서 'selected' 클래스를 제거합니다.
            tabs.forEach(item => item.classList.remove('selected'));

            // 4. 방금 클릭한 탭에만 'selected' 클래스를 추가합니다.
            tab.classList.add('selected');

            // 5. 모든 내용 영역을 숨깁니다.
            tabContents.forEach(content => content.style.display = 'none');

            // 6. 클릭한 탭과 순서가 맞는 내용 영역만 보여줍니다.
            tabContents[index].style.display = 'block';
        });
    });
</script>
</body>
</html>
