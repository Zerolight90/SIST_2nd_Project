document.addEventListener('DOMContentLoaded', function () {
    const sliderBox = document.querySelector('.slider-box');
    const prevBtn = document.getElementById('prev-btn');
    const nextBtn = document.getElementById('next-btn');
    const slideItems = document.querySelectorAll('.slide-item');
    const totalSlides = slideItems.length;

    // 한 번에 보여줄 슬라이드 개수 (예: 4개)
    const slidesPerPage = 4;
    // 슬라이드 하나의 너비 + 마진
    const slideWidth = 170 + 20;

    let currentIndex = 0;

    function updateSliderPosition() {
        const offset = -currentInde * lideWidth;
        sliderBox.style.transform = `translateX(${offset}px)`;
    }

    nextBtn.addEventListener('click', () => {
        // 마지막 페이지가 아닐 경우에만 이동
        if (currentIndex < totalSlides - slidesPerPage) {
            currentIndex++;
            updateSliderPosition();
        }
    });

    prevBtn.addEventListener('click', () => {
        // 첫 페이지가 아닐 경우에만 이동
        if (currentIndex > 0) {
            currentIndex--;
            updateSliderPosition();
        }
    });

    // 초기 위치 설정
    updateSliderPosition();
});
