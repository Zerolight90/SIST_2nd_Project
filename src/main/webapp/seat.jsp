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
        <input type="hidden" name="age" id="age" value="${movie.age}">
        <input type="hidden" name="thisTime" id="thisTime" value="${fn:substring(time.startTime, 10, 16)}"/>
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

                <!-- 성인영화가 아닐때만 청소년 추가 버튼을 보여줌 -->
                <c:if test="${movie.age != '19'}">
                    <div class="control-group">
                        <label>청소년</label>
                        <div class="counter">
                            <button onclick="changeCount('teen-count', -1)">-</button>
                            <span id="teen-count">0</span>
                            <button onclick="changeCount('teen-count', 1)">+</button>
                        </div>
                    </div>
                </c:if>

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
            <div class="seat-area">
                <div class="seat-map">
                    <c:forEach var="rowNum" begin="1" end="${screen.sRow}" varStatus="i">
                        <c:set var="rowChar" value="${fn:substring(alphabet, i.index, i.index+1)}"/>
                        <c:forEach var="colNum" begin="1" end="${screen.sColumn}" varStatus="j">
                            <c:set var="seatId" value="${rowChar}${j.count}"/>
                            <button class="seat-item" onclick="selectSeat(this)"
                                    data-seat="${seatId}">
                                    ${seatId}
                            </button>
                            <c:if test="${j.count == 2 || j.count == 6}">
                                <div class="blank"></div>
                            </c:if>
                        </c:forEach>
                        <br/>
                    </c:forEach>
                </div>
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
                <div class="poster-img"><img src="${movie.poster}" alt="스크린 이미지"></div>
            </div>
            <div class="movie-info">
                <div class="flex">
                    <div class="movie-title">${movie.name}</div>
                    <img src="/images/${movie.age}.png"/>
                </div>
                <div class="movie-details">
                    상영관: ${screen.sName}(${screen.screenCode})<br>
                    ${fn:substring(time.startTime, 0, 10)}<br> <!-- 영화가 시작하는 날짜 -->
                    ${fn:substring(time.startTime, 10, 16)}&nbsp;~${fn:substring(time.endTime, 10, 16)} <!-- 영화가 시작하는 시간 -->
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

<!-- 성인영화 선택 시 신분증 지참 알림 창 -->
<div id="adult-alert" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <div class="modal-body">
            <img src="/images/${movie.age}.png"/>
            <h2>청소년관람불가</h2>
            <p>
                입장 시, 신분증을 반드시 지참해주세요!<br>
                만 19세 미만의 고객님은 보호자를 동반하더라도 관람이 불가합니다.
            </p>
            <button class="confirm-btn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<div style="display: none">
    <form action="Controller?type=paymentMovie" name="ff" method="post">
        <!-- 가격 정보 -->
        <input type="hidden" name="teenPrice" id="teenPrice" value="${price.teen}">
        <input type="hidden" name="elderPrice" id="elderPrice" value="${price.elder}">
        <input type="hidden" name="dayPrice" id="dayPrice" value="${price.day}">
        <input type="hidden" name="weekPrice" id="weekPrice" value="${price.week}">
        <input type="hidden" name="morningPrice" id="morningPrice" value="${price.morning}"> <!-- 조조 할인 가격 -->
        <input type="hidden" name="normalPrice" id="normalPrice" value="${price.normal}">

        <input type="hidden" name="timeTableIdx" value="${time.timeTableIdx}">
        <input type="hidden" name="tIdx" value="${theater.tIdx}">
        <input type="hidden" name="sIdx" value="${screen.sIdx}">
        <input type="hidden" name="priceIdx" value="${price.priceIdx}">

        <input type="hidden" name="startTime" value="${time.startTime}">
        <input type="hidden" name="theaterName" value="${theater.tName}">
        <input type="hidden" name="movieTitle" value="${movie.name}">
        <input type="hidden" name="posterUrl" value="${movie.poster}">
        <input type="hidden" name="screenName" value="${screen.sName}">
        <input type="hidden" name="typePrice" value="${screen.screenCode}"> <!-- 코드타입의 가격 보냄 -->

        <input type="hidden" name="teen" value=""> <!-- 십대 수 -->
        <input type="hidden" name="adult" value=""> <!-- 성인 수 -->
        <input type="hidden" name="senior" value=""> <!-- 노인 수 -->
        <input type="hidden" name="special" value=""> <!-- 우대 수 -->
        <input type="hidden" name="Aseat" value="1000"> <!-- A열 할인 가격 -->

        <input type="hidden" name="seatInfo" value=""> <!-- 스크립트에서 value에 담아서 보냄 -->
        <input type="hidden" name="amount" value=""> <!-- 스크립트에서 value에 담아서 보냄 -->
    </form>
</div>

<script>
    // DOM 로드 후, 이미 예매된 좌석들을 비활성화
    document.addEventListener('DOMContentLoaded', function() {
        <c:forEach var="bookedSeat" items="${requestScope.seatVO}">
        var seatElement = document.querySelector('.seat-item[data-seat="${bookedSeat.seatNumber}"]');
        if (seatElement) {
            seatElement.classList.add('seat-item-deactivate');
            seatElement.onclick = null;
        }
        </c:forEach>

        // 19세 관람가 모달 체크
        const ageValue = document.getElementById("age").value; // getAttribute 대신 value 사용
        // console.log("Age value:", ageValue); // 디버깅용
        if (ageValue === "19") {
            // console.log("Opening modal for 19+ movie"); // 디버깅용
            openModal();
        }
    });

    // 모달 함수
    function openModal() {
        document.getElementById("adult-alert").style.display = "block";
    }
    function closeModal() {
        document.getElementById("adult-alert").style.display = "none";
    }

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

    // 인원 수 변경
    function changeCount(type, int) {
        let element = document.getElementById(type);
        let currentCount = parseInt(element.innerText);
        let newCount = currentCount + int;

        // 요소가 존재하지 않으면 함수 종료 (19세 영화에서 teen-count 요소가 없을 때)
        if (!element) {
            // console.log("Element not found:", type);
            return;
        }

        if(int === -1) {
            if(totalPersons === 0) {
                alert("인원수를 확인해주세요")
                return;
            }
            if(seat_list.length === totalPersons){
                alert("좌석을 선택 해제하고 다시 시도해주세요")
                return;
            }
            newCount = currentCount - 1;
        }

        // 0보다 작으면 0으로 설정
        if(newCount < 0) newCount = 0;

        element.innerText = newCount;
        updateTotalPersons();
    }

    // 총 인원 수 업데이트
    function updateTotalPersons() {
        // 총 인원을 변수에 담는데 null이면 0 반환
        let adult_num = adult ? Number(adult.innerText) : 0;
        let teen_num = teen ? Number(teen.innerText) : 0;
        let senior_num = senior ? Number(senior.innerText) : 0;
        let special_num = special ? Number(special.innerText) : 0;

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

        // 할인 적용 (좌석이 선택되어 있을 때만)
        if (seat_list.length > 0) {
            updateTotalPrice();
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
            seat.style.backgroundColor = 'white';
            seat.style.borderColor = 'black';
        } else {
            // 새로운 좌석을 선택하려는 경우
            // 현재 선택된 좌석 수가 총 인원 수와 같거나 많은지 확인
            if(totalPersons === 0) {
                alert("인원을 확인을해주세요");
                return;
            }
            if (currentSelectedCount >= totalPersons) {
                alert("총 인원(" + totalPersons + "명)보다 많은 좌석을 선택할 수 없습니다.");
                return;
            }

            // 좌석 선택 (색상 변경)
            seat.style.backgroundColor = '#007bff';
            seat.style.borderColor = '#0056b3';
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
        } else {
            display.innerText = '-';
        }

        // 좌석이 변경될 때마다 가격 재계산
        updateTotalPersons();
    }

    // 테스트용 함수 (콘솔에서 확인용)
    function testTimeDiscount() {
        const testTimes = ["07:30", "08:59", "09:00", "09:01", "12:00", "22:30"];

        testTimes.forEach(time => {
            // 임시로 시간 변경
            document.getElementById('thisTime').value = time;
            const result = applyTimeDiscount();
            <%--console.log(`시간: ${time} -> 할인: ${result.discount}원 (${result.discountName || "할인없음"})`);--%>
        });
    }

    // 사용자가 선택한 영화가 조조인지 판단해서 값을 - 해주기 위해 시간을 알아야함
    let thisTime = document.getElementById('thisTime').value; // 11:11

    // 시간 문자열을 분으로 변환하는 함수
    function timeToMinutes(timeStr) {
        const [hours, minutes] = timeStr.split(':').map(Number);
        return hours * 60 + minutes;
    }

    // 시간별 할인 적용 함수
    function applyTimeDiscount() {
        // thisTime input에서 시간 가져오기
        const thisTimeElement = document.getElementById('thisTime');
        if (!thisTimeElement) {
            // console.log("thisTime element not found");
            return { discount: 0, discountName: "" };
        }

        let thisTime = thisTimeElement.value; // 예: "08:30"
        const currentTime = timeToMinutes(thisTime);

        let discount = 0;
        let discountName = "";

        // 조조할인: 09:00보다 일찍 시작하는 영화
        if (currentTime < timeToMinutes("09:00")) {
            discount = morningPrice;
            discountName = "조조할인";
            <%--console.log(`조조할인 적용: ${thisTime} < 09:00, -${discount}원`);--%>
        }

        return { discount, discountName };
    }

    // 수정된 updateTotalPrice 함수
    function updateTotalPrice() {
        // 기존 좌석별 할인 (A열)
        let seatDiscount = 0;
        for (let i = 0; i < seat_list.length; i++) {
            let seat = seat_list[i];
            let seat_type = seat.charAt(0);
            if(seat_type === 'A') {
                seatDiscount += 1000;
                <%--console.log(`A열 할인: ${seat} -1000원`);--%>
            }
        }

        // 시간별 할인 적용
        const timeDiscountInfo = applyTimeDiscount();
        let timeDiscount = 0;

        if (timeDiscountInfo.discount > 0) {
            // 선택한 좌석 수만큼 시간 할인 적용
            timeDiscount = timeDiscountInfo.discount * seat_list.length;
            <%--console.log(`${timeDiscountInfo.discountName}: -${timeDiscount}원 (좌석 ${seat_list.length}개 × ${timeDiscountInfo.discount}원)`);--%>
        }

        // 총 할인 금액 적용
        const totalDiscount = seatDiscount + timeDiscount;
        total_price = total_price - totalDiscount;

        <%--console.log(`총 할인: ${totalDiscount}원 (좌석할인: ${seatDiscount}원 + 시간할인: ${timeDiscount}원)`);--%>
    }

    // 전체 초기화
    function resetAll() {
        // 1) 인원 카운트 UI를 0으로 초기화
        // 요소가 존재할 때만 초기화
        if (adult) adult.innerText = '0';
        if (teen) teen.innerText = '0';
        if (senior) senior.innerText = '0';
        if (special) special.innerText = '0';
        totalPersons = 0;

        // 2) 좌석 선택 초기화 (인라인 스타일 제거 → 기본 CSS로 복귀)
        document.querySelectorAll('.seat-item').forEach(seat => {
            seat.removeAttribute('style');      // background/border 등 모두 제거
            seat.classList.remove('selected');  // 혹시 쓴 적 있다면 대비
        });

        // 3) 내부 상태 초기화
        seat_list = [];
        total_price = 0;

        // 4) 우측 패널 UI 초기화
        document.getElementById('selected-seats-display').innerText = '-';
        document.getElementById('total_person').innerText = '총 인원: 0';
        document.getElementById('total-price').innerText = '0 원';
    }

    function goPay() {
        updateTotalPrice();

        if (totalPersons === 0) {
            alert("인원을 선택해주세요")
            return;
        }
        if(seat_list.length === 0) {
            alert("좌석을 선택해주세요")
            return;
        }
        if(totalPersons !== seat_list.length) {
            alert("좌석을 전부 선택해주세요")
            return;
        }

        // 유효성 검사를 통과 후 사용자가 선택한 사람들의 인원 수를 얻어내고 그대로 form에 담아 전달
        document.ff.teen.value = Number(teen.innerText);
        document.ff.adult.value = Number(adult.innerText);
        document.ff.senior.value = Number(senior.innerText);
        document.ff.special.value = Number(special.innerText);

        document.ff.seatInfo.value = seat_list.join(', ');
        document.ff.amount.value = total_price;

        document.ff.submit();
    }

</script>

<jsp:include page="common/Footer.jsp"/>

</body>

</html>