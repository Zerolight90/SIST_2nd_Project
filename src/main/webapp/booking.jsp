<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SIST BOX 쌍용박스</title>
  <link rel="stylesheet" href="./css/sub/sub_page_style.css">
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/booking.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"> <!--폰트어썸 css 라이브러리-->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  <link rel="icon" href="./images/favicon.png">
</head>
<body>

<header>
  <jsp:include page="jsp/sub_menu.jsp"/>
</header>

  <div class="inner-wrap">
    <div class="util-title">
      <h2>예매</h2>
    </div>
    <form action="Controller?type=seat" method="post">
      <div id="booking-wrap">
        <!-- 상단 날짜영역 -->
        <div class="booking-date">
          <button class="bf_btn" onclick="changeDate(-1)">
            <i class="fas fa-chevron-left"></i>
          </button>
          <div class="date-wrap" id="dateWrap">
            <!-- 날짜가 동적으로 생성됩니다 -->
          </div>
          <button class="nt_btn" onclick="changeDate(1)">
            <i class="fas fa-chevron-right"></i>
          </button>
        </div>

        <!-- 중앙의 영화 / 극장 / 시간 영역 -->
        <div id="book-wrap-body">
          <!-- 영화 선택 -->
          <div class="book-box" id="movie-box">
            <h3 class="box-tit">영화</h3>
            <div class="book-main" id="movie-list">
              <div class="main-in">
                <div class="ec-base-tab typeLight eTab">
                  <ul class="menu">
                    <li class="selected"><a href="#" onclick="switchTab(this, 'movie-all')">전체</a></li>
                    <li><a href="#" onclick="switchTab(this, 'movie-curation')">큐레이션</a></li>
                  </ul>
                  <div id="movie-all" class="tabCont active">
                    <div class="movie-item" data-movie="1">
                      <span class="movie-rating rating-12">12</span>
                      <span class="movie-title">범퍼카</span>
                    </div>
                    <div class="movie-item" data-movie="2">
                      <span class="movie-rating rating-15">15</span>
                      <span class="movie-title">F1 더 무비</span>
                    </div>
                    <div class="movie-item" data-movie="3">
                      <span class="movie-rating rating-15">15</span>
                      <span class="movie-title">전직 특수 요원</span>
                    </div>
                    <div class="movie-item" data-movie="4">
                      <span class="movie-rating rating-18">18</span>
                      <span class="movie-title">몬스터</span>
                    </div>
                    <div class="movie-item" data-movie="5">
                      <span class="movie-rating rating-12">12</span>
                      <span class="movie-title">컨더스키 4: 제로드 출동</span>
                    </div>
                    <div class="movie-item" data-movie="6">
                      <span class="movie-rating rating-all">ALL</span>
                      <span class="movie-title">베드 가이즈 2</span>
                    </div>
                  </div>
                  <div id="movie-curation" class="tabCont">
                    <div class="movie-item" data-movie="1">
                      <span class="movie-rating rating-12">12</span>
                      <span class="movie-title">범퍼카</span>
                    </div>
                    <div class="movie-item" data-movie="3">
                      <span class="movie-rating rating-15">15</span>
                      <span class="movie-title">전직 특수 요원</span>
                    </div>
                    <div class="movie-item" data-movie="6">
                      <span class="movie-rating rating-all">ALL</span>
                      <span class="movie-title">베드 가이즈 2</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="book_ft">모든영화<br/>목록에서 영화를 선택하세요.</div>
          </div>

          <!-- 극장 선택 -->
          <div class="book-box" id="theater-box">
            <h3 class="box-tit">극장</h3>
            <div class="book-main" id="theater-list">
              <div class="main-in">
                <div class="ec-base-tab typeLight eTab">
                  <ul class="menu">
                    <li class="selected"><a href="#" onclick="switchTab(this, 'theater-all')">전체</a></li>
                    <li><a href="#" onclick="switchTab(this, 'theater-special')">특별관</a></li>
                  </ul>
                  <div id="theater-all" class="tabCont active">
                    <div class="empty-state">영화를 먼저 선택해주세요.</div>
                  </div>
                  <div id="theater-special" class="tabCont">
                    <div class="empty-state">영화를 먼저 선택해주세요.</div>
                  </div>
                </div>
              </div>
            </div>
            <div class="book_ft">전체극장<br/>목록에서 극장을 선택하세요.</div>
          </div>

          <!-- 시간 선택 -->
          <div id="date-box">
            <h3 class="date-box-tit">시간</h3>
            <div id="date-list">
              <div class="empty-state">영화와 극장을 선택해주세요.</div>
            </div>
          </div>
        </div>

        <!-- 광고영역 -->
        <div class="book-add">
          <a href="#" onclick="proceedToSeatSelection(this.form)">좌석선택 하러가기</a>
        </div>
      </div>
    </form>
  </div>

<script>
  let selectedMovie = null;
  let selectedTheater = null;
  let selectedTime = null;
  let selectedDate = null;
  let currentDateIndex = 0;

  // 극장 데이터
  const theaterData = {
    1: { // 범퍼카
      all: [
        { id: 1, name: '강남점', location: '서울 강남구' },
        { id: 2, name: '홍대점', location: '서울 마포구' },
        { id: 3, name: '잠실점', location: '서울 송파구' }
      ],
      special: [
        { id: 4, name: '강남 IMAX', location: '서울 강남구' }
      ]
    },
    2: { // F1 더 무비
      all: [
        { id: 1, name: '강남점', location: '서울 강남구' },
        { id: 5, name: '건대점', location: '서울 광진구' }
      ],
      special: []
    },
    3: { // 전직 특수 요원
      all: [
        { id: 2, name: '홍대점', location: '서울 마포구' },
        { id: 3, name: '잠실점', location: '서울 송파구' },
        { id: 6, name: '신촌점', location: '서울 서대문구' }
      ],
      special: [
        { id: 7, name: '잠실 4DX', location: '서울 송파구' }
      ]
    }
  };

  // 시간 데이터 (더 상세한 정보 포함)
  const timeData = {
    1: { // 범퍼카
      1: [
        { time: '11:55', theater: '전시실특시실험', screen: '2D ATMOS', seats: '140/401', tags: ['고화스탠드', 'DOLBY ATMOS', 'Laser'] },
        { time: '12:50', theater: '전시실특시실험', screen: '2D', seats: '145/456', tags: ['프리미엄아트컨', 'Laser'] },
        { time: '13:20', theater: '전시실특시실험', screen: '2D', seats: '152/526', tags: ['고화스탠드', '3관', 'Laser'] },
        { time: '14:20', theater: '전시실특시실험', screen: '2D', seats: '162/625', tags: ['고화스탠드', '1관', 'Laser'] },
        { time: '15:45', theater: '전시실특시실험', screen: '2D', seats: '175/700', tags: ['고화스탠드', '2관', 'Laser'] },
        { time: '17:15', theater: '전시실특시실험', screen: '2D', seats: '192/800', tags: ['프리미엄아트컨', 'Laser'] },
        { time: '18:10', theater: '전시실특시실험', screen: '2D', seats: '201/850', tags: ['고화스탠드', '2관', 'Laser'] }
      ],
      2: [
        { time: '10:00', theater: '홍대점', screen: '2D', seats: '85/200', tags: ['2D'] },
        { time: '13:20', theater: '홍대점', screen: '2D', seats: '120/200', tags: ['2D'] },
        { time: '16:40', theater: '홍대점', screen: '2D', seats: '150/200', tags: ['2D'] },
        { time: '19:20', theater: '홍대점', screen: '2D', seats: '180/200', tags: ['2D'] }
      ]
    },
    2: { // F1 더 무비
      1: [
        { time: '10:20', theater: '강남점', screen: '2D', seats: '95/250', tags: ['2D'] },
        { time: '13:00', theater: '강남점', screen: '2D', seats: '140/250', tags: ['2D'] },
        { time: '15:40', theater: '강남점', screen: '2D', seats: '180/250', tags: ['2D'] },
        { time: '18:20', theater: '강남점', screen: '2D', seats: '200/250', tags: ['2D'] }
      ]
    },
    3: { // 전직 특수 요원
      2: [
        { time: '11:00', theater: '홍대점', screen: '2D', seats: '90/180', tags: ['2D'] },
        { time: '13:40', theater: '홍대점', screen: '2D', seats: '120/180', tags: ['2D'] },
        { time: '16:20', theater: '홍대점', screen: '2D', seats: '150/180', tags: ['2D'] },
        { time: '19:00', theater: '홍대점', screen: '2D', seats: '170/180', tags: ['2D'] }
      ]
    }
  };

  // 페이지 로드 시 초기화
  $(document).ready(function() {
    initializeDates();
    bindEvents();
  });

  // 날짜 초기화
  function initializeDates() {
    const dateWrap = document.getElementById('dateWrap');
    const today = new Date();
    let dates = [];

    for (let i = 0; i < 7; i++) {
      const date = new Date(today);
      date.setDate(today.getDate() + i);
      dates.push({
        date: date,
        day: ['일', '월', '화', '수', '목', '금', '토'][date.getDay()],
        dateStr: `${date.getMonth() + 1}/${date.getDate()}`
      });
    }

    dateWrap.innerHTML = dates.map((d, index) => `
    <div class="date-item ${index == 0 ? 'selected' : ''}" data-date="${index}" onclick="selectDate(${index})">
      <div class="day">${d.day}</div>
      <div class="date">${d.dateStr}</div>
    </div>
  `).join('');

    selectedDate = 0;
  }

  // 날짜 변경
  function changeDate(direction) {
    // 실제로는 날짜 범위를 변경하는 로직이 들어갈 수 있습니다
    console.log('날짜 변경:', direction);
  }

  // 날짜 선택
  function selectDate(index) {
    document.querySelectorAll('.date-item').forEach(item => item.classList.remove('selected'));
    document.querySelector(`[data-date="${index}"]`).classList.add('selected');
    selectedDate = index;
    updateTimeList();
  }

  // 탭 전환
  function switchTab(element, tabId) {
    const parentTab = element.closest('.ec-base-tab');

    // 탭 메뉴 활성화
    parentTab.querySelectorAll('.menu li').forEach(li => li.classList.remove('selected'));
    element.parentElement.classList.add('selected');

    // 탭 컨텐츠 전환
    parentTab.querySelectorAll('.tabCont').forEach(cont => cont.classList.remove('active'));
    parentTab.querySelector('#' + tabId).classList.add('active');
  }

  // 이벤트 바인딩
  function bindEvents() {
    // 영화 선택 이벤트
    $(document).on('click', '.movie-item', function() {
      $('.movie-item').removeClass('selected');
      $(this).addClass('selected');

      selectedMovie = {
        id: $(this).data('movie'),
        name: $(this).find('.movie-title').text()
      };

      updateTheaterList();
      resetTimeSelection();
    });

    // 극장 선택 이벤트
    $(document).on('click', '.theater-item', function() {
      $('.theater-item').removeClass('selected');
      $(this).addClass('selected');

      selectedTheater = {
        id: $(this).data('theater'),
        name: $(this).find('.theater-name').text()
      };

      updateTimeList();
    });

    // 시간 선택 이벤트
    $(document).on('click', '.time-slot', function() {
      $('.time-slot').removeClass('selected');
      $(this).addClass('selected');

      selectedTime = $(this).data('time');
    });
  }

  // 극장 목록 업데이트
  function updateTheaterList() {
    if (!selectedMovie) return;

    const theaters = theaterData[selectedMovie.id];
    if (!theaters) return;

    // 전체 탭
    const allTheaters = theaters.all.map(theater => `
    <div class="theater-item" data-theater="${theater.id}">
      <div class="theater-name">${theater.name}</div>
      <div class="theater-location">${theater.location}</div>
    </div>
  `).join('');

    $('#theater-all').html(allTheaters || '<div class="empty-state">상영 극장이 없습니다.</div>');

    // 특별관 탭
    const specialTheaters = theaters.special.map(theater => `
    <div class="theater-item" data-theater="${theater.id}">
      <div class="theater-name">${theater.name}</div>
      <div class="theater-location">${theater.location}</div>
    </div>
  `).join('');

    $('#theater-special').html(specialTheaters || '<div class="empty-state">특별관이 없습니다.</div>');
  }

  // 시간 목록 업데이트
  function updateTimeList() {
    if (!selectedMovie || !selectedTheater) {
      $('#date-list').html('<div class="empty-state">영화와 극장을 선택해주세요.</div>');
      return;
    }

    const schedules = timeData[selectedMovie.id]?.[selectedTheater.id] || [];

    if (schedules.length === 0) {
      $('#date-list').html('<div class="empty-state">상영시간이 없습니다.</div>');
      return;
    }

    // 시간대 네비게이션 생성
    const hours = ['07', '08', '09', '10', '11', '12', '13', '14', '15', '16'];
    const timeNavigation = `
    <div class="time-navigation">
      <button class="time-nav-btn" onclick="scrollTimeLeft()">◀</button>
      <div class="time-nav-hours">
<!-- 날짜 -->
      </div>
      <button class="time-nav-btn" onclick="scrollTimeRight()">▶</button>
    </div>
  `;

    // 상단 정보
    const timeHeader = `
    <div class="time-header">
      <span>🟡 조조 🔵 심야실 💧 상영</span>
    </div>
  `;

    // 상영 스케줄 생성
    const scheduleItems = schedules.map(schedule => {
      const [remainSeats, totalSeats] = schedule.seats.split('/');
      const tags = schedule.tags.map(tag => {
        let tagClass = 'tag';
        if (tag.includes('DOLBY')) tagClass += ' dolby';
        else if (tag.includes('Laser')) tagClass += ' laser';
        else if (tag === '2D') tagClass += ' 2d';
        return `<span class="${tagClass}">${tag}</span>`;
      }).join('');

      return `
      <div class="schedule-item" data-time="${schedule.time}" data-theater="${schedule.theater}" onclick="selectSchedule(this)">
        <div class="schedule-time">${schedule.time}</div>
        <div class="schedule-info">
          <div class="schedule-theater">${schedule.theater}</div>
          <div class="schedule-details">
            <span class="schedule-screen">${schedule.screen}</span>
          </div>
        </div>
        <div class="schedule-seats">
          <div class="seats-info">잔여석</div>
          <div class="seats-count">${remainSeats}/${totalSeats}</div>
        </div>
        <div class="schedule-tags">
          ${tags}
        </div>
      </div>
    `;
    }).join('');

    $('#date-list').html(`
    ${timeHeader}
    ${timeNavigation}
    <div class="time-schedule">
      ${scheduleItems}
    </div>
  `);
  }

  // 스케줄 선택
  function selectSchedule(element) {
    $('.schedule-item').removeClass('selected');
    $(element).addClass('selected');

    selectedTime = {
      time: element.dataset.time,
      theater: element.dataset.theater
    };
  }

  // 시간대 선택
  function selectHour(hour) {
    $('.hour-item').removeClass('selected');
    $(`.hour-item:contains(${hour})`).addClass('selected');

    // 해당 시간대로 스크롤
    const schedules = $('.schedule-item');
    schedules.each(function() {
      const time = $(this).data('time');
      if (time && time.startsWith(hour)) {
        this.scrollIntoView({ behavior: 'smooth', block: 'center' });
        return false;
      }
    });
  }

  // 시간 네비게이션 스크롤
  function scrollTimeLeft() {
    const container = $('.time-nav-hours');
    container.animate({ scrollLeft: container.scrollLeft() - 200 }, 300);
  }

  function scrollTimeRight() {
    const container = $('.time-nav-hours');
    container.animate({ scrollLeft: container.scrollLeft() + 200 }, 300);
  }

  // 시간 선택 초기화
  function resetTimeSelection() {
    selectedTheater = null;
    selectedTime = null;
    $('#date-list').html('<div class="empty-state">극장을 선택해주세요.</div>');
  }

  // 좌석선택 진행
  function proceedToSeatSelection(frm) {
    // if (!selectedMovie || !selectedTheater || !selectedTime) {
    //   alert('영화, 극장, 시간을 모두 선택해주세요.');
    //   return;
    // }

    alert(`좌석선택 페이지로 이동합니다.\n\n영화: ${selectedMovie.name}\n극장: ${selectedTheater.name}\n시간: ${selectedTime}`);
    location.href = "Controller?type=seat";
  }

</script>

<jsp:include page="jsp/Footer.jsp"/>



</body>

</html>