<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/tab.css">
    <link rel="stylesheet" href="./css/theater.css">
    <link rel="stylesheet" href="./css/faq.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png">
</head>
<body>

<header>
    <jsp:include page="common/sub_menu.jsp"/>
</header>


<div>
    <div class="topBox">
        <div class="theaterTopBox">
            <div class="location">
                <span>Home</span>
                &nbsp;>&nbsp;
                <span>고객센터</span>
                >
                <a href="#">자주 묻는 질문</a>
            </div>
        </div>
    </div>

    <div class="inner-wrap">
        <div class="container">
            <aside class="aside">
                <jsp:include page="/customer_center.jsp"/>
            </aside>


            <div class="page-content">
                <!-- 상단 탭 -->
                <div class="page-title">
                    <h2 class="tit">자주 묻는 질문</h2>
                </div>
                <div class="faq-container">

                    <div class="faq-item">
                        <div class="faq-question">
                            <div class="faq-question-title">
                                <span class="q-icon">Q</span> 영화 예매는 어떻게 하나요?
                            </div>
                        </div>
                        <div class="faq-answer">
                            <span class="a-icon">A</span>
                            온라인 또는 모바일 앱을 통해 예매하실 수 있습니다. 상영 시간표를 확인 후 원하는 영화와 좌석을 선택하여 결제하면 예매가 완료됩니다.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <div class="faq-question-title">
                                <span class="q-icon">Q</span> 예매를 취소하고 싶어요.
                            </div>
                        </div>
                        <div class="faq-answer">
                            <span class="a-icon">A</span>
                            영화 상영 시작 전까지 '마이페이지' > '예매내역'에서 취소할 수 있습니다. 상영 시작 이후에는 취소가 불가능합니다.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <div class="faq-question-title">
                                <span class="q-icon">Q</span> 영화관람 시 할인받을 수 있는 방법이 있나요?
                            </div>
                        </div>
                        <div class="faq-answer">
                            <span class="a-icon">A</span>
                            제휴 카드 할인, 통신사 멤버십 할인 등 다양한 할인 혜택을 제공하고 있습니다. 자세한 내용은 홈페이지 '이벤트' 또는 '할인 정보' 페이지를 참고해주세요.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <div class="faq-question-title">
                                <span class="q-icon">Q</span> 영화관 내 음식물 반입이 가능한가요?

                            </div>
                        </div>
                        <div class="faq-answer">
                            <span class="a-icon">A</span>
                            극장 내에서 판매하는 음식물 외에는 반입이 제한될 수 있습니다. 냄새가 심한 음식물은 다른 관객들을 위해 반입을 삼가해주시기 바랍니다.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <div class="faq-question-title">
                                <span class="q-icon">Q</span> 상영관 입장 연령 제한이 있나요?
                            </div>
                        </div>
                        <div class="faq-answer">
                            <span class="a-icon">A</span>
                            영화의 등급에 따라 관람 연령이 제한될 수 있습니다. 예매 시 영화 등급을 반드시 확인해주시기 바랍니다.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const faqQuestions = document.querySelectorAll('.faq-question');

        // 첫 번째 FAQ 항목을 자동으로 열기
        const firstQuestion = faqQuestions[0];
        const firstAnswer = firstQuestion.nextElementSibling;

        if (firstQuestion && firstAnswer) {
            firstQuestion.classList.add('active');
            firstAnswer.classList.add('show');
        }

        faqQuestions.forEach(question => {
            question.addEventListener('click', () => {
                const answer = question.nextElementSibling;

                // 다른 답변 숨기기
                document.querySelectorAll('.faq-answer.show').forEach(openAnswer => {
                    if (openAnswer !== answer) {
                        openAnswer.classList.remove('show');
                        openAnswer.previousElementSibling.classList.remove('active');
                    }
                });

                // 현재 답변 토글
                answer.classList.toggle('show');
                question.classList.toggle('active');
            });
        });
    });
</script>

</body>
</html>
