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
    <jsp:include page="jsp/menu.jsp"/>
</header>

<div class="container">
    <div class="header">
        <h1 class="title">빠른예매</h1>
    </div>

    <!-- 변수 생성 -->
    <div class="booking-section">
        <div class="seat-area">
            <div class="controls">
                <div class="control-group">
                    <label>성인</label>
                    <div class="counter">
                        <button onclick="changeCount('adult', -1)">-</button>
                        <span id="adult-count">0</span>
                        <button onclick="changeCount('adult', 1)">+</button>
                    </div>
                </div>

                <div class="control-group">
                    <label>청소년</label>
                    <div class="counter">
                        <button onclick="changeCount('teen', -1)">-</button>
                        <span id="teen-count">0</span>
                        <button onclick="changeCount('teen', 1)">+</button>
                    </div>
                </div>

                <div class="control-group">
                    <label>경로</label>
                    <div class="counter">
                        <button onclick="changeCount('senior', -1)">-</button>
                        <span id="senior-count">0</span>
                        <button onclick="changeCount('senior', 1)">+</button>
                    </div>
                </div>

                <div class="control-group">
                    <label>우대</label>
                    <div class="counter">
                        <button onclick="changeCount('special', -1)">-</button>
                        <span id="special-count">0</span>
                        <button onclick="changeCount('special', 1)">+</button>
                    </div>
                </div>

                <button class="reset-btn" onclick="resetAll()">초기화</button>
            </div>

            <!-- 스크린 이미지 영역 -->
            <div class="screen-area">
                <div><img src="https://www.megabox.co.kr/static/pc/images/reserve/img-theater-screen.png" alt="스크린 이미지"></div>
            </div>

            <div class="seat-map" id="seat-map">
                <!-- 좌석은 JavaScript로 동적 생성 -->
            </div>

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
                <div class="poster-img">F1 더 무비<br>2D(자막)</div>
            </div>

            <div class="movie-info">
                <div class="movie-title">F1 더 무비</div>
                <div class="movie-details">
                    감독: 드라마코어닷1관<br>
                    2025.07.29(화)<br>
                    12:25~15:10
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

<script>
    function goPay() {
        location.href = "pay.jsp";
    }
    // 값을 사용하기 위한 멤버변수 선언
    let adult = document.getElementById('adult-count');
    let teen = document.getElementById('teen-count');
    let senior = document.getElementById('senior-count');
    let special = document.getElementById('special-count');

    // 좌석 데이터
    const seatData = {
        adult: 0,
        teen: 0,
        senior: 0,
        special: 0
    };

    const prices = {
        adult: 14000,
        teen: 11000,
        senior: 7000,
        special: 5000
    };

    let selectedSeats = [];
    let totalPersons = 0;

    // 좌석 맵 생성
    function createSeatMap() {
        const seatMap = document.getElementById('seat-map');
        const rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
        const seatsPerRow = [4, 6, 8, 8, 8, 8, 8, 6]; // 각 행별 좌석 수
        const occupiedSeats = ['C3', 'C6', 'D5', 'F7', 'G2', 'G8']; // 이미 선택된 좌석

        seatMap.innerHTML = '';

        rows.forEach((row, rowIndex) => {
            const seatRow = document.createElement('div');
            seatRow.className = 'seat-row';

            const rowLabel = document.createElement('div');
            rowLabel.className = 'row-label';
            rowLabel.textContent = row;
            seatRow.appendChild(rowLabel);

            const seatCount = seatsPerRow[rowIndex];
            const maxSeats = 8;
            const emptySeats = (maxSeats - seatCount) / 2;

// 왼쪽 여백
            for (let i = 0; i < emptySeats; i++) {
                const emptySeat = document.createElement('div');
                emptySeat.className = 'seat disabled';
                seatRow.appendChild(emptySeat);
            }

// 실제 좌석
            for (let i = 1; i <= seatCount; i++) {
                const seat = document.createElement('button');
                seat.className = 'seat';
                seat.textContent = i;
                seat.dataset.seatId = `${row}${i}`;

                if (occupiedSeats.includes(`${row}${i}`)) {
                    seat.className += ' occupied';
                    seat.disabled = true;
                } else {
                    seat.onclick = () => selectSeat(seat);
                }

                seatRow.appendChild(seat);

// 중간 통로
                if (seatCount > 4 && i === Math.floor(seatCount / 2)) {
                    const aisle = document.createElement('div');
                    aisle.className = 'aisle';
                    seatRow.appendChild(aisle);
                }
            }

// 오른쪽 여백
            for (let i = 0; i < emptySeats; i++) {
                const emptySeat = document.createElement('div');
                emptySeat.className = 'seat disabled';
                seatRow.appendChild(emptySeat);
            }

            seatMap.appendChild(seatRow);
        });
    }

    // 인원 수 변경
    function changeCount(type, delta) { <!-- 만약 adult, 1 이 들어오면 -->
        const currentCount = seatData[type]; <!-- seat[type]의  -->
        const newCount = Math.max(0, Math.min(8, currentCount + delta));

        seatData[type] = newCount;

// DOM 요소를 확실하게 찾아서 업데이트
        if(type == 'adult')
            adult.innerText = newCount;
        if(type == 'teen')
            teen.innerText = newCount;
        if(type == 'senior')
            senior.innerText = newCount;
        if(type == 'special')
            special.innerText = newCount;

        <%--const countElement = document.getElementById(`${type}-count`);--%>
        <%--if (countElement) {--%>
        <%--    countElement.innerHTML = newCount;--%>
        <%--    countElement.innerText = newCount;--%>
        updateTotalPersons();
        updatePrice();
    }

    // 총 인원 수 업데이트
    function updateTotalPersons() {
        totalPersons = Number(adult.innerText) + Number(teen.innerText) + Number(senior.innerText) + Number(special.innerText); // 사용자가 추가한 모든 인원의 총 합을 totalPersons 에 담음
        let tperson = document.getElementById('total_person');
        tperson.innerText = '총 인원:' + totalPersons;

// 선택된 좌석이 총 인원보다 많으면 초과분 제거
        if (selectedSeats.length > totalPersons) {
            const excessSeats = selectedSeats.slice(totalPersons);
            excessSeats.forEach(seatId => {
                const seat = document.querySelector(`[data-seat-id="${seatId}"]`);
                if (seat) {
                    seat.classList.remove('selected');
                }
            });
            selectedSeats = selectedSeats.slice(0, totalPersons);
            updateSelectedSeatsDisplay();
        }
    }

    // 좌석 선택
    function selectSeat(seat) {
        const seatId = seat.dataset.seatId;

        if (seat.classList.contains('selected')) {
// 좌석 선택 해제
            seat.classList.remove('selected');
            selectedSeats = selectedSeats.filter(id => id !== seatId);
        } else {
            // 좌석 선택
            if (selectedSeats.length < totalPersons) {
                seat.classList.add('selected');
                selectedSeats.push(seatId);
            } else {
                alert('최대' + totalPersons + '개의 좌석만 선택할 수 있습니다.');
                return;
            }
        }

        updateSelectedSeatsDisplay();
        updatePrice();
    }

    // 선택된 좌석 표시 업데이트
    function updateSelectedSeatsDisplay() {
        const display = document.getElementById('selected-seats-display');
        if (display) {
            if (selectedSeats.length === 0) {
                display.innerHTML = '-';
                display.innerText = '-';
            } else {
                const seatsText = selectedSeats.sort().join(', ');
                display.innerHTML = seatsText;
                display.innerText = seatsText;
            }
        }
    }

    // 가격 업데이트
    function updatePrice() {
        let totalPrice = 0;

// 선택된 좌석이 있을 때만 가격 계산
        if (selectedSeats.length > 0) {
// 티켓 타입별로 가격 계산 (선택된 좌석 수만큼)
            const seatCount = selectedSeats.length;
            let remainingSeats = seatCount;

// 우선순위: 성인 > 청소년 > 경로 > 우대
            if (seatData.adult > 0) {
                const adultSeats = Math.min(seatData.adult, remainingSeats);
                totalPrice += adultSeats * prices.adult;
                remainingSeats -= adultSeats;
            }

            if (seatData.teen > 0 && remainingSeats > 0) {
                const teenSeats = Math.min(seatData.teen, remainingSeats);
                totalPrice += teenSeats * prices.teen;
                remainingSeats -= teenSeats;
            }

            if (seatData.senior > 0 && remainingSeats > 0) {
                const seniorSeats = Math.min(seatData.senior, remainingSeats);
                totalPrice += seniorSeats * prices.senior;
                remainingSeats -= seniorSeats;
            }

            if (seatData.special > 0 && remainingSeats > 0) {
                const specialSeats = Math.min(seatData.special, remainingSeats);
                totalPrice += specialSeats * prices.special;
                remainingSeats -= specialSeats;
            }
        }

        const priceElement = document.getElementById('total-price');
        if (priceElement) {
            const priceText = `${totalPrice.toLocaleString()} 원`;
            priceElement.innerHTML = priceText;
            priceElement.innerText = priceText;
        }
    }

    // 전체 초기화
    function resetAll() {
// 인원 수 초기화
        Object.keys(seatData).forEach(type => {
            seatData[type] = 0;

// DOM 요소를 확실하게 찾아서 업데이트
            const countElement = document.getElementById(`${type}-count`);
            if (countElement) {
                countElement.innerHTML = '0';
                countElement.innerText = '0';
            }

// 추가 보험: querySelector로도 시도
            const countSpan = document.querySelector(`#${type}-count`);
            if (countSpan) {
                countSpan.innerHTML = '0';
            }
        });

// 선택된 좌석 초기화
        selectedSeats.forEach(seatId => {
            const seat = document.querySelector(`[data-seat-id="${seatId}"]`);
            if (seat) {
                seat.classList.remove('selected');
            }
        });

        selectedSeats = [];
        totalPersons = 0;

        updateSelectedSeatsDisplay();
        updatePrice();
    }

    // 페이지 로드 시 좌석 맵 생성
    document.addEventListener('DOMContentLoaded', createSeatMap);
</script>

<jsp:include page="jsp/Footer.jsp"/>

</body>

</html>