// Swiper 초기화 스크립트
document.addEventListener('DOMContentLoaded', function() {
    const mySwiper = new Swiper('.swiper-container', {
        // 선택 사항: 슬라이드 방향 (기본값 'horizontal')
        direction: 'horizontal',
        // 루프 모드 (무한 반복)
        loop: true,

        // 페이지네이션 (점 형태)
        pagination: {
            el: '.swiper-pagination',
            clickable: true, // 점 클릭으로 이동 가능
        },

        // 네비게이션 버튼 (이전/다음)
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },

        // 스크롤바
        scrollbar: {
            el: '.swiper-scrollbar',
            hide: true, // 스크롤바 숨김 (마우스 오버 시 표시)
        },

        // 자동 재생
        autoplay: {
            delay: 3000, // 3초마다 슬라이드 전환
            disableOnInteraction: false, // 사용자 상호작용 후에도 자동 재생 유지
        },
    });
});
