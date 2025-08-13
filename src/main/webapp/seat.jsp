<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIST BOX 쌍용박스</title>
    <link rel="stylesheet" href="./css/reset.css">
    <link rel="stylesheet" href="./css/sub/sub_page_style.css">
    <link rel="stylesheet" href="./css/seat.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
    <link rel="icon" href="./images/favicon.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<body>
<header>
    <jsp:include page="common/sub_menu.jsp"/>
</header>

<div class="container">
    <div class="header">
        <h1 class="title">빠른예매</h1>
    </div>

    <c:set var="time" value="${requestScope.time}" scope="page"/> <!--상영정보-->
    <c:set var="theater" value="${requestScope.theater}" scope="page"/> <!--영화관-->
    <c:set var="movie" value="${requestScope.movie}" scope="page"/> <!--영화-->
    <c:set var="screen" value="${requestScope.screen}" scope="page"/> <!--상영관-->
    <c:set var="type" value="${requestScope.typeVO}" scope="page"/> <!-- 현재 상영관의 type에 가격 -->
    <c:set var="price" value="${requestScope.price}" scope="page"/> <!-- 현재 상영관의 type에 가격 -->

    <!-- 변수 생성 -->
    <div class="booking-section">
        <div class="seat-area">
            <div class="controls">
                <div class="control-group">
                    <label>성인</label>
                    <div class="counter">
                        <button onclick="changeCount('adult-count', -1)">-</button>
                        <span id="adult-count">0</span>
                        <button onclick="changeCount('adult-count', 1)">+</button>
                    </div>
                </div>

                <div class="control-group">
                    <label>청소년</label>
                    <div class="counter">
                        <button onclick="changeCount('teen-count', -1)">-</button>
                        <span id="teen-count">0</span>
                        <button onclick="changeCount('teen-count', 1)">+</button>
                    </div>
                </div>

                <div class="control-group">
                    <label>경로</label>
                    <div class="counter">
                        <button onclick="changeCount('senior-count', -1)">-</button>
                        <span id="senior-count">0</span>
                        <button onclick="changeCount('senior-count', 1)">+</button>
                    </div>
                </div>

                <div class="control-group">
                    <label>우대</label>
                    <div class="counter">
                        <button onclick="changeCount('special-count', -1)">-</button>
                        <span id="special-count">0</span>
                        <button onclick="changeCount('special-count', 1)">+</button>
                    </div>
                </div>

                <button class="reset-btn" onclick="resetAll()">초기화</button>
            </div>

            <!-- 스크린 이미지 영역 -->
            <div class="screen-area">
                <div><img src="https://www.megabox.co.kr/static/pc/images/reserve/img-theater-screen.png" alt="스크린 이미지"></div>
            </div>

            <c:set var="alphabet" value="ZABCDEFGHIJKLMNOPQRSTUVWXY"/>

            <c:forEach var="row" begin="1" end="${screen.sRow}" varStatus="i">
                <c:forEach var="col" begin="1" end="${screen.sColumn}" varStatus="j">
                    <button class="seat-item"
                            data-seat="${fn:substring(alphabet, i.index, i.index+1)}${j.count}"
                            onclick="selectSeat(this)">
                            ${fn:substring(alphabet, i.index, i.index+1)}${j.count}
                    </button>
                </c:forEach>
                <br/>
            </c:forEach>

            <div class="legend">
                <div class="legend-item">
                    <div class="legend-seat" style="background: white; border-color: #ddd;"></div>
                    <span>선택가능</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat" style="background: #007bff; border-color: #0056b3;"></div>
                    <span>선택됨</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat" style="background: #ccc; border-color: #999;"></div>
                    <span>선택불가</span>
                </div>
            </div>
        </div>

        <div class="info-panel">
            <div class="movie-poster">
                <div class="poster-img">${movie.name}<br>${movie.age}</div>
            </div>
            <div class="movie-info">
                <div class="movie-title">${movie.name}</div>
                <div class="movie-details">
                    상영관: ${screen.sName}${screen.screenCode}<br>
                    ${time.startTime}<br>
                    ${time.endTime}
                </div>

                <div class="selected-info">
                    <div class="info-row">
                        <span>선택좌석</span>
                        <span class="selected-seats" id="selected-seats-display">-</span>
                    </div>
                </div>

                <div class="price-section">
                    <div id="total_person">총 인원:</div>
                    <div class="total-price" id="total-price">0 원</div>
                    <div class="price-detail">최종 결제금액</div>
                </div>
            </div>
        </div>
    </div>
    <div class="payment-section">
        <button onclick="goPay()" class="payment-btn">결제하기</button>
    </div>
</div>

<div style="display: none">
    <form action="Controller?type=paymentMovie" name="ff" method="post">
        <!-- 가격 정보 -->
        <input type="hidden" name="teenPrice" id="teenPrice" value="${price.teen}">
        <input type="hidden" name="elderPrice" id="elderPrice" value="${price.elder}">
        <input type="hidden" name="dayPrice" id="dayPrice" value="${price.day}">
        <input type="hidden" name="weekPrice" id="weekPrice" value="${price.week}">
        <input type="hidden" name="morningPrice" id="morningPrice" value="${price.morning}">
        <input type="hidden" name="normalPrice" id="normalPrice" value="${price.normal}">

        <input type="hidden" name="startTime" value="${time.startTime}">
        <input type="hidden" name="theaterName" value="${theater.tName}">
        <input type="hidden" name="movieTitle" value="${movie.name}">
        <input type="hidden" name="posterUrl" value="${movie.poster}">
        <input type="hidden" name="screenName" value="${screen.sName}">
        <input type="hidden" name="typePrice" value="${type.codeType}"> <!-- 코드타입의 가격 보냄 -->
        <input type="hidden" name="seatInfo" value=""> <!-- 스크립트에서 value에 담아서 보냄 -->
        <input type="hidden" name="amount" value=""> <!-- 스크립트에서 value에 담아서 보냄 -->
    </form>
</div>

<script>
    // 가격 설정
    let teenPrice = Number(document.getElementById('teenPrice').value);
    let specialPrice = Number(document.getElementById('elderPrice').value); // 노인과 취약계층 가격 동일
    let dayPrice = Number(document.getElementById('dayPrice').value);
    let weekPrice = Number(document.getElementById('weekPrice').value);
    let morningPrice = Number(document.getElementById('morningPrice').value);
    let normalPrice = Number(document.getElementById('normalPrice').value); // 성인과 낮의 가격 동일

    // 값을 사용하기 위한 멤버변수 선언
    let adult = document.getElementById('adult-count');
    let teen = document.getElementById('teen-count');
    let senior = document.getElementById('senior-count');
    let special = document.getElementById('special-count');

    let seat_list = [];
    let total_price = 0;

    let totalPersons = 0;

    // 사용자가 선택한 좌석들은 배열에 저장되어 있다


    function goPay() {
        document.ff.seatInfo.value = seat_list.join(', ');
        document.ff.amount.value = total_price;

        // console.log(document.ff.startTime.value)
        // console.log(document.ff.theaterName.value)
        // console.log(document.ff.movieTitle.value)
        // console.log(document.ff.posterUrl.value)
        // console.log(document.ff.screenName.value)
        // console.log(document.ff.typePrice.value)
        // console.log(document.ff.seatInfo.value)
        // console.log(document.ff.amount.value)

        document.ff.submit();
    }

    // 인원 수 변경
    function changeCount(type, int) {
        // console.log("normalPrice:", normalPrice);
        // console.log("teenPrice:", teenPrice);
        // console.log("specialPrice:", specialPrice);
        let element = document.getElementById(type);
        let currentCount = parseInt(element.innerText);
        let newCount = currentCount + int;

        // 보이는 숫자가 0이면 연산해도 돌아감
        if(newCount < 0) newCount = 0;

        element.innerText = newCount;
        updateTotalPersons();
    }

    // 총 인원 수 업데이트
    function updateTotalPersons() {
        let adult_num = Number(adult.innerText);
        let teen_num = Number(teen.innerText);
        let senior_num = Number(senior.innerText);
        let special_num = Number(special.innerText);

        totalPersons = adult_num + teen_num + senior_num + special_num;
        let tperson = document.getElementById('total_person');
        tperson.innerText = '총 인원: ' + totalPersons;

        // 가격 계산
        total_price = 0;
        if (adult_num > 0) {
            total_price += adult_num * normalPrice;
        }
        if (teen_num > 0) {
            total_price += teen_num * teenPrice;
        }
        if (senior_num > 0) {
            total_price += senior_num * specialPrice;
        }
        if(special_num > 0) {
            total_price += special_num * specialPrice;
        }

        document.getElementById("total-price").innerText = total_price + " 원";
    }

    // 좌석 버튼 클릭 시 색이 바뀌는 부분
    function selectSeat(seat) {
        // 현재 선택된 모든 좌석의 개수를 세기
        let selectedSeats = document.querySelectorAll('.seat-item[style*="background-color: rgb(0, 123, 255)"], .seat-item[style*="background: rgb(0, 123, 255)"]');
        let currentSelectedCount = selectedSeats.length;

        // 클릭한 좌석이 이미 선택된 상태인지 확인
        let isAlreadySelected = seat.style.backgroundColor === 'rgb(0, 123, 255)' || seat.style.backgroundColor === '#007bff';

        if (isAlreadySelected) {
            // 이미 선택된 좌석을 다시 클릭하면 선택 취소
            seat.style.backgroundColor = '#ccc';
            seat.style.borderColor = '#ddd';
        } else {
            // 새로운 좌석을 선택하려는 경우
            // 현재 선택된 좌석 수가 총 인원 수와 같거나 많은지 확인
            if (currentSelectedCount >= totalPersons) {
                alert("총 인원(" + totalPersons + "명)보다 많은 좌석을 선택할 수 없습니다.");
                return; // 함수 종료, 좌석 선택하지 않음
            }

            // 좌석 선택 (색상 변경)
            seat.style.backgroundColor = '#007bff';
            seat.style.borderColor = '#0056b3';

            // 좌석을 선택하면 총 금액도 변해야 함

        }

        // 선택된 좌석 표시 업데이트 (필요한 경우)
        updateSelectedSeatsDisplay();
    }

    // 선택된 좌석 표시를 업데이트하는 함수 (선택사항)
    function updateSelectedSeatsDisplay() {
        let selectedSeats = document.querySelectorAll('.seat-item[style*="background-color: rgb(0, 123, 255)"], .seat-item[style*="background: rgb(0, 123, 255)"]');
        seat_list = [];

        selectedSeats.forEach(seat => {
            seat_list.push(seat.getAttribute('data-seat'));
        });

        let display = document.getElementById('selected-seats-display');
        if (seat_list.length > 0) {
            display.innerText = selectedSeats.length;
            // console.log(seat_list);
        } else {
            display.innerText = '-';
        }
    }

    // 선택된 좌석이 총 인원보다 많으면 초과분 제거



    // 선택된 좌석 표시 업데이트

    // 가격 업데이트
    function updateTotalPrice() {
        // seat_list를 돌면서 안에 있는 글자들의 첫번째 글자를 가져옴
        for (let i = 0; i < seat_list.length; i++) {
            let seat = seat_list[i];
            let seat_type = seat.charAt(0);
            // 만약 A 열이라면 총 가격에서 -1000
            if(seat_type === 'A') {
                total_price = total_price - 1000;
            }
        }
    }

    // 전체 초기화

    // 페이지 로드 시 좌석 맵 생성
</script>

<jsp:include page="common/Footer.jsp"/>

</body>

</html>