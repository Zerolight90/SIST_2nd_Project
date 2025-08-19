<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SIST CINEMA - 아이디 / 비밀번호 찾기</title>
<%--    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/search_tab.css"/>--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/join.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/search.css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
</head>
<body>

<div class="container">
    <h1>SIST CINEMA</h1>
    <h2>아이디 / 비밀번호 찾기</h2>

    <div class="ec-base-tab grid2 typeLight">
        <ul class="menu">
            <li class="selected"><a href="#" data-url="<%=request.getContextPath()%>/join/search_id.jsp">아이디 찾기</a></li>
            <li><a href="#" data-url="<%=request.getContextPath()%>/join/search_pw.jsp">비밀번호 찾기</a></li>
        </ul>
    </div>

    <div id="tabContent">
        <!-- AJAX로 로드된 내용이 표시됩니다 -->
    </div>
</div>

<script>
    $(function(){
        var $menuItems = $('.ec-base-tab .menu li');
        var $tabContent = $('#tabContent');

        function loadContent(url) {
            $tabContent.html('<p class="loading">로딩 중...</p>');
            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'html',
                success: function(data){
                    $tabContent.html(data);
                },
                error: function(){
                    $tabContent.html('<p class="error">콘텐츠를 불러오는 중 오류가 발생했습니다.</p>');
                }
            });
        }

        // 초기 로드 (첫 번째 탭)
        loadContent($menuItems.first().find('a').data('url'));

        // 탭 클릭 이벤트
        $menuItems.find('a').on('click', function(e){
            e.preventDefault();
            var $parentLi = $(this).parent();

            if($parentLi.hasClass('selected')) return;

            $menuItems.removeClass('selected');
            $parentLi.addClass('selected');

            var url = $(this).data('url');
            loadContent(url);
        });
    });
</script>

</body>
</html>
