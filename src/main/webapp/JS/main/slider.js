// slider.js
$(document).ready(function() {
    let $sliderTits = $('.slider_tit');
    let $sliderImgs = $('.slider_img');
    let $dots = $('.slider_btn .page span');
    let $btnPrev = $('.btn-prev');
    let $btnNext = $('.btn-next');
    let $btnPause = $('.btn-pause');
    let $btnPlay = $('.btn-play');
    let $count = $('.slider_btn .count');
    let totalSlide = $sliderTits.length;
    let current = 0;
    let auto = true;
    let timer = null;
    let interval = 5000;

    function setSlide(idx, prev) {
        $sliderTits.each(function(i) {
            if (i === idx) {
                $(this).css({
                    top: '100px',
                    opacity: 0,
                    transition: 'none'
                });
                setTimeout(()=>{
                    $(this).css({
                        top: 0,
                        opacity: 1,
                        transition: 'top 0.5s, opacity 0.7s'
                    });
                }, 20);
            } else {
                $(this).css({
                    opacity: 0,
                    top: '100px',
                    transition: 'none'
                });
            }
        });

        $sliderImgs.each(function(i) {
            if(i === idx){
                $(this).css({
                    left: '450px',
                    opacity: 0,
                    transition: 'none'
                });
                setTimeout(()=>{
                    $(this).css({
                        left: '300px',
                        opacity: 1,
                        transition: 'left 0.5s, opacity 0.7s'
                    });
                }, 20);
            } else {
                $(this).css({
                    opacity: 0,
                    left: '450px',
                    transition: 'none'
                });
            }
        });

        // 페이지 인디케이터
        $dots.removeClass('on').addClass('off');
        $dots.eq(idx).removeClass('off').addClass('on');

        // 카운트
        $count.text((idx + 1) + " / " + totalSlide);
    }

    function goToSlide(idx) {
        if(idx < 0) idx = totalSlide - 1;
        if(idx >= totalSlide) idx = 0;
        let prev = current;
        current = idx;
        setSlide(current, prev);
    }

    function autoMove() {
        if (timer) clearTimeout(timer);
        if (auto) {
            timer = setTimeout(function() {
                goToSlide(current + 1);
                autoMove();
            }, interval);
        }
        updatePlayPauseBtn();
    }

    function updatePlayPauseBtn() {
        if(auto){
            $btnPause.show();
            $btnPlay.hide();
        }else{
            $btnPause.hide();
            $btnPlay.show();
        }
    }

    $btnPrev.on('click', function() {
        goToSlide(current - 1);
        if (auto) {
            autoMove();
        }
    });

    $btnNext.on('click', function() {
        goToSlide(current + 1);
        if (auto) {
            autoMove();
        }
    });

    $dots.on('click', function(){
        let idx = $(this).index();
        goToSlide(idx);
        if (auto) {
            autoMove();
        }
    });

    $btnPause.on('click', function() {
        auto = false;
        clearTimeout(timer);
        updatePlayPauseBtn();
    });

    $btnPlay.on('click', function() {
        auto = true;
        autoMove();
    });

    // 초기화
    $btnPause.hide(); // 처음엔 자동재생 버튼만 보이게
    $btnPlay.show();
    setSlide(current, null);
    autoMove();
});
