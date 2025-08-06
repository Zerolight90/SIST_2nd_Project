<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전체영화 | CINEFEEL</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/style.css" />
    <link rel="stylesheet" href="../css/sub/sub_page_style.css">
    <link rel="stylesheet" href="../css/allmovie.css">
</head>
<body>
<!-- Header -->
<jsp:include page="../common/sub_menu.jsp" />

<div id="container">
    <div class="content">
        <h2 class="title">전체영화</h2>

        <ul class="tabs">
            <li class="active" data-tab="boxoffice">박스오피스</li>
            <li data-tab="scheduled">상영예정작</li>
            <li data-tab="sistonly">SIST ONLY</li>
            <li data-tab="filmsociety">필름소사이어티</li>
            <li data-tab="classicsociety">클래식소사이어티</li>
        </ul>

        <div class="movie-options">
            <div class="total-count">
                총 <strong>60</strong>개의 영화가 검색되었습니다.
            </div>
            <div class="search-box">
                <input type="text" placeholder="영화명 검색">
                <button type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
        </div>

        <div id="boxoffice" class="tab-content active">
            <jsp:include page="allmovie_boxoffice.jsp" />
        </div>
        <div id="scheduled" class="tab-content">
            <jsp:include page="allmovie_scheduled.jsp" />
        </div>
        <div id="sistonly" class="tab-content">
            <jsp:include page="allmovie_sistonly.jsp" />
        </div>
        <div id="filmsociety" class="tab-content">
            <jsp:include page="allmovie_filmsociety.jsp" />
        </div>
        <div id="classicsociety" class="tab-content">
            <jsp:include page="allmovie_classicsociety.jsp" />
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="../common/Footer.jsp" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tabs = document.querySelectorAll('.tabs li');
        const tabContents = document.querySelectorAll('.tab-content');

        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                tabs.forEach(item => item.classList.remove('active'));
                tabContents.forEach(content => content.classList.remove('active'));

                tab.classList.add('active');
                const tabId = tab.getAttribute('data-tab');
                if(document.getElementById(tabId)) {
                    document.getElementById(tabId).classList.add('active');
                }
            });
        });
    });
</script>

</body>
</html>
