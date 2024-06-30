// 공통 윈도우 열기 함수
function openWindow(url, windowName) {
    const screenWidth = window.screen.width;
    const screenHeight = window.screen.height;
    const windowWidth = screenWidth * 0.6;
    const windowHeight = screenHeight * 0.8;
    const left = (screenWidth - windowWidth) / 2;
    const top = (screenHeight - windowHeight) / 2;
    const options = 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + left + ',top=' + top + ',resizable=yes,scrollbars=yes';
    window.open(url, windowName, options);
}


// 이벤트 리스너 설정 함수
function setupOpenWindow(buttonId, url) {
    document.addEventListener('click', function(e) {
        if (e.target && e.target.id === buttonId) {
            console.log(buttonId + " clicked");
            openWindow(url, 'ApplyWindow');
        }
    });
}

// 할인 추가 윈도우 열기 설정
setupOpenWindow('addDiscount', '/admin/insertDiscount');

// 쿠폰 추가 윈도우 열기 설정
setupOpenWindow('addCounpon', '/admin/couponManagement');

// 상품 추가 윈도우 열기 설정
setupOpenWindow('addProduct', '/admin/insertProduct');