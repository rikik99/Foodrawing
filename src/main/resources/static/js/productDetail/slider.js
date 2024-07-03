document.addEventListener('DOMContentLoaded', function() {
    let currentIndex = {};

    function initSliders() {
        const sliders = document.querySelectorAll('.slider');
        sliders.forEach(slider => {
            currentIndex[slider.id] = 0;
            const slides = slider.querySelector('.slides');
            const totalSlides = slides.children.length;
            const slidesToShow = 3; // 한 번에 보여줄 슬라이드 수

            // 슬라이더의 너비를 설정하여 슬라이드가 모두 보이도록 합니다.
            slides.style.width = '100%';
            for (let slide of slides.children) {
                slide.style.width = (100 / slidesToShow) + '%';
            }

            // 페이지 인디케이터 업데이트
            updatePageIndicator(slider.id);
        });
    }

    function nextSlide(sliderId) {
        const slider = document.getElementById(sliderId);
        const slides = slider.querySelector('.slides');
        const totalSlides = slides.children.length;
        const slidesToShow = 3;
        const maxIndex = totalSlides - slidesToShow;

        if (currentIndex[sliderId] < maxIndex) {
            currentIndex[sliderId] += slidesToShow;
            updateSlider(slides, currentIndex[sliderId]);
            updatePageIndicator(sliderId);
        }
    }

    function prevSlide(sliderId) {
        const slider = document.getElementById(sliderId);
        const slides = slider.querySelector('.slides');
        const totalSlides = slides.children.length;
        const slidesToShow = 3;

        if (currentIndex[sliderId] > 0) {
            currentIndex[sliderId] -= slidesToShow;
            updateSlider(slides, currentIndex[sliderId]);
            updatePageIndicator(sliderId);
        }
    }

    function updateSlider(slides, index) {
        const slideWidth = slides.children[0].getBoundingClientRect().width;
        const newTransformValue = -(index * slideWidth);
        slides.style.transform = 'translateX(' + newTransformValue + 'px)';
    }

    function updatePageIndicator(sliderId) {
        const slider = document.getElementById(sliderId);
        const slides = slider.querySelector('.slides');
        const totalSlides = slides.children.length;
        const slidesToShow = 3;
        const currentPage = Math.ceil((currentIndex[sliderId] + 1) / slidesToShow);
        const totalPages = Math.ceil(totalSlides / slidesToShow);

        const pageIndicator = document.getElementById('page-indicator-' + sliderId);
        pageIndicator.textContent = currentPage + '/' + totalPages;
    }
    
    window.nextSlide = nextSlide;
    window.prevSlide = prevSlide;

    initSliders();
});
