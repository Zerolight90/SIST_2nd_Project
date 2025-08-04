<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <!-- 모달 창의 제목 표시줄을 숨기고, X 버튼 스타일을 정의하는 CSS -->
    <style>
        .no-titlebar .ui-dialog-titlebar {
            display: none;
        }
        .custom-close-button {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #888;
        }
    </style>
</head>

<footer>
    <div id="footer-top">
        <div class="footer-top">
            <ul>
                <li><a href="#" title="회사소개">회사소개</a></li>
                <li><a href="#" title="인재채용">인재채용</a></li>
                <li><a href="#" title="사회공헌">사회공헌</a></li>
                <li><a href="#" title="제휴,광고,부대산업문의">제휴/광고/부대산업문의</a></li>
                <li><a href="#" title="이용약관">이용약관</a></li>
                <li><a href="#" title="위치기반 서비스 이용약관">위치기반서비스 이용약관</a></li>
                <li><a href="#" title="개인정보방침">개인정보처리방침</a></li>
                <li><a href="#" title="윤리경영">윤리경영</a></li>
            </ul>
        </div>

    </div>

    <div id="footer-bottom">
        <div class="footer-bottom">
            <div class="footer-logo">
                <img src="../images/Simbol_logo.png" alt="SIST 로고" />
                <p>MEET PLAY SHARE</p>
            </div>

            <address>
                서울특별시 강남구 역삼동 테헤란로 132 한독약품빌딩 8층
                Tel 02-3482-4632 대표이메일 m.dreamcenter@sist.movie.co.kr<br/>
                대표자명 장영환, 오경주 · 개인정보보호책임자 문우진 · 사업자등록번호 273-73-98119 ·
                통신판매업신고번호 2025-서울강남-00722
                COPYRIGHT &copy; SIST CINEMA, Inc. All rights reserved
            </address>

            <div class="footer-social">
                <a href="#" title="유튜브"><i class="fab fa-youtube"></i></a>
                <a href="#" title="인스타그램"><i class="fab fa-instagram"></i></a>
                <a href="#" title="페이스북"><i class="fab fa-facebook-f"></i></a>
                <a href="#" title="트위터"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </div>

    <div id="admin-login-modal" title="관리자 로그인" style="display:none;"></div>

    <script>
        $(function() {
            let dialogOptions = {
                autoOpen: false,
                modal: true,
                width: 'auto',
                height: 'auto',
                resizable: false,
                dialogClass: 'no-titlebar', // 제목 표시줄을 숨기기
                // 모달이 열릴 때마다 실행되는 open 이벤트 핸들러 추가
                open: function() {
                    // X 버튼
                    let closeButton = $('<button type="button" class="custom-close-button">&times;</button>');

                    // X 버튼 클릭 시 다얄로그 닫기
                    closeButton.on('click', function() {
                        $("#admin-login-modal").dialog("close");
                    });

                    // 모달에 버튼 추가
                    $(this).append(closeButton);
                },
                close: function() {
                    // 모달이 닫힐 때 내부 내용 청소
                    $(this).empty();
                }
            };

            $("#admin-login-modal").dialog(dialogOptions);

            // 로고 3번 클릭 이벤트
            let clickCount = 0;
            let clickTimer = null;

            $('.footer-logo').on('click', function() {
                clickCount += 1;

                if (clickCount === 3) {
                    $("#admin-login-modal").load("adminLogin.jsp", function(response, status, xhr) {
                        if (status == "error") {
                            $(this).html("로그인 창을 불러오는 데 실패했습니다: " + xhr.status + " " + xhr.statusText);
                        }
                        $("#admin-login-modal").dialog("open");
                    });

                    clickCount = 0;
                    clearTimeout(clickTimer);
                    return;
                }

                clearTimeout(clickTimer);
                clickTimer = setTimeout(function() {
                    clickCount = 0;
                }, 700);
            });
        });
    </script>
</footer>
