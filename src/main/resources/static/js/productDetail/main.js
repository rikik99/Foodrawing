document.addEventListener('DOMContentLoaded', async function() {
    function loadScript(url) {
        const script = document.createElement('script');
        script.src = url;
        script.defer = true;
        document.head.appendChild(script);
    }

    // 각 기능별 스크립트 파일을 로드
    loadScript('/js/productDetail/wishlist.js');
    loadScript('/js/productDetail/totalPrice.js');
    loadScript('/js/productDetail/cart.js');
    loadScript('/js/productDetail/slider.js');
    loadScript('/js/productDetail/productImage.js');
    loadScript('/js/productDetail/tabs.js');
});
