<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html id="ajaxArea">
<head>
    <title>Title</title>
    <%--    <link rel="stylesheet" href="./css/sub/sub_page_style.css">--%>
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <style>
        /* 기본 폰트 및 여백 초기화 */
        body {
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
            color: #333;
            margin: 20px;
            background-color: #f9f9f9;
        }

        /* 전체 컨테이너 */
        .admin-container {
            width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        /* 1. 페이지 제목 */
        .page-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #333;
        }

        /* 2. 상단 컨트롤 바 (게시물 수 + 검색 영역) */
        .control-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 10px;
            background-color: #f5f7fa;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .total-count {
            font-size: 14px;
            font-weight: bold;
        }
        .total-count strong {
            color: #e53935;
        }

        .search-form {
            display: flex;
            align-items: center;
            gap: 8px; /* 요소 사이 간격 */
            padding-top: 15px;
        }

        /* 검색 폼 요소 공통 스타일 */
        .search-form select,
        .search-form input[type="text"] {
            height: 36px;
            padding: 0 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .search-form input[type="text"] {
            width: 200px;
        }

        .search-form .btn {
            height: 36px;
            padding: 0 15px;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
        }

        .search-form .btn-search {
            background-color: #337ab7;
        }
        .search-form .btn-reset {
            background-color: #777;
        }

        /* 3. 회원 목록 테이블 */
        .member-table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            font-size: 14px;
        }

        .member-table th, .member-table td {
            padding: 12px 10px;
            border-bottom: 1px solid #eee;
        }

        .member-table thead {
            background-color: #f8f9fa;
            font-weight: bold;
            border-top: 2px solid #ddd;
            border-bottom: 1px solid #ddd;
        }

        .member-table tbody tr:hover {
            background-color: #f5f5f5;
        }

        /* 상태 뱃지 스타일 */
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            color: #fff;
        }
        .status-active {
            background-color: #4caf50; /* 활성 */
        }
        .status-dormant {
            background-color: #f44336; /* 탈퇴 */
        }

        /* 4. 페이징 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            gap: 6px;
        }

        .pagination a, .pagination strong {
            display: inline-block;
            width: 34px;
            height: 34px;
            line-height: 34px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }

        .pagination a:hover {
            background-color: #f0f0f0;
        }

        .pagination .current-page {
            background-color: #337ab7;
            color: #fff;
            border-color: #337ab7;
            font-weight: bold;
        }

        .pagination .nav-arrow {
            font-weight: bold;
        }

        .ui-dialog-titlebar {
            display: none;
        }
        /* 모달 창 자체의 불필요한 패딩 제거 */
        .no-titlebar.ui-dialog .ui-dialog-content {
            padding: 0;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body style="margin: auto" id="ajax">
<!-- 관리자 화면에 처음 들어오는 보이는 상단영역 -->
<div class="dashHead bold">
    <div style="display: inline-block; justify-content: space-between; align-items: center"><p style="margin-left: 10px">admin 관리자님</p></div>
    <div style="display: inline-block; float: right; padding-top: 13px; padding-right: 10px">
        <a href="">SIST</a>
        <a href="">로그아웃</a>
    </div>
</div>

<div class="dashBody">
    <div class="dashLeft">
        <jsp:include page="/admin/admin.jsp"/>
    </div>
    <div class="admin-container">
        <!-- 페이지 타이틀 -->
        <div class="page-title">
            <h2>회원 목록</h2>
        </div>

        <!-- 테이블 상단 바 영역 -->
        <div class="control-bar">
            <div class="total-count">
                전체 <strong>${fn:length(requestScope.ar)}</strong>건
            </div>
            <form class="search-form" action="#" method="get">
                <p class="total-count">가입일 : </p>
                <p><input type="text" id="datepicker" name="datepicker" value=""></p>
                <select name="user_status" id="user_status">
                    <option value="">사용자 상태 선택</option>
                    <option value="0">활성</option>
                    <option value="1">탈퇴</option>
                </select>
                <select name="search_field" id="search_field">
                    <option value="all">검색 대상 선택</option>
                    <option value="name">이름</option>
                    <option value="id">아이디</option>
                    <option value="email">이메일</option>
                </select>
                <input type="text" name="search_keyword" placeholder="검색어를 입력해주세요."/>
                <button type="button" class="btn btn-search">검색</button>
                <button type="button" class="btn btn-reset">초기화</button>
            </form>
        </div>

        <!-- 테이블 영역 -->
        <table class="member-table">
            <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>보유 포인트</th>
                <th>상태</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="vo" items="${requestScope.ar}" varStatus="status">
                    <tr class="userTr" data-idx="${vo.userIdx}">
                        <td>${vo.userIdx}</td>
                        <td>${vo.name}</td>
                        <td>${vo.id}</td>
                        <td>${vo.email}</td>
                        <td>${vo.phone}</td>
                        <td>${vo.totalPoints}</td>

                        <c:if test="${vo.status == 0}">
                            <td><span class="status-badge status-active">활성</span></td>
                        </c:if>
                        <c:if test="${vo.status == 1}">
                            <td><span class="status-badge status-dormant">탈퇴</span></td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이징 영역 -->
        <nav class="pagination">
            <a href="#" class="nav-arrow">&lt;</a>
            <strong class="current-page">1</strong>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">6</a>
            <a href="#">7</a>
            <a href="#">8</a>
            <a href="#">9</a>
            <a href="#">10</a>
            <a href="#" class="nav-arrow">&gt;</a>
        </nav>
    </div>
</div>

<div id="adminUsersModal" style="display:none;"></div>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
    $( function() {
        // Datepicker에 적용할 옵션
        let option = {
            monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
            monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
            dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
            weekHeader: "주",
            dateFormat: "yy-mm-dd",
            showMonthAfterYear: true,
            yearSuffix: "년",
            showOtherMonths: true,
            selectOtherMonths: true
        };

        // 위에서 설정한 옵션을 Datepicker에 할당
        $("#datepicker").datepicker(option);

        // 회원정보 수정 다얄로그 창의 속성 지정
        $("#adminUsersModal").dialog({
            autoOpen: false,
            modal: true,
            resizable: false,
            width: 'auto',
            dialogClass: 'no-titlebar',
            close: function() {
                $(this).empty(); // 다음 모달이 열릴 때 혹시 값이 남아있으면 안 되므로 모달이 닫히면 값 비우기
            }
        });

        $('.member-table tbody').on('click', '.userTr', function () {
            let userIdx = $(this).data('idx');

            let urlToLoad = "Controller?type=adminUsersEdit&userIdx=" + userIdx;

            $("#adminUsersModal").load(urlToLoad, function(response, status, xhr) {
                if (status == "error") {
                    $(this).html("사용자 정보를 불러오는 데 실패했습니다.");
                }
                $("#adminUsersModal").dialog('open');
            });
        });

        // 검색 버튼을 눌렀을 때
        $('.btn-search').on('click', function () {
            // form의 데이터를 쿼리 스트링으로 만드는 함수 (예: user_status=0&search_field=name)
            let formdata = $(".search-form").serialize();

            // 비동기식 통신으로 화면 교체
            $.ajax({
                url: "Controller?type=userSearch",
                type: "GET",
                data: formdata,
                dataType: "html",
                success: function (response) {
                    // 오류가 없다면 tbody의 내용을 새로운 내용으로 교체
                    $(".member-table tbody").html(response);
                },
                error: function() {
                    alert("검색 중 오류가 발생했습니다.");
                }
            });
        });

        // 초기화 버튼을 눌렀을 때 select 태그 등 지정된 값 전부 초기화
        $('.btn-reset').on('click', function() {
            $('.search-form')[0].reset();
            // location.reload(); 또는 전체 목록 출력?
        });
    } );
</script>

</body>
</html>
