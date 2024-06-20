function setupOpenDiscountAddWindow() {
    document.addEventListener('click', function(e) {
        if (e.target && e.target.id === 'addDiscount') {
            console.log("clicked");
            openDiscountAddWindow();
        }
    });
}

function openDiscountAddWindow() {
    const screenWidth = window.screen.width;
    const screenHeight = window.screen.height;
    const windowWidth = screenWidth * 0.6;
    const windowHeight = screenHeight * 0.8;
    const left = (screenWidth - windowWidth) / 2;
    const top = (screenHeight - windowHeight) / 2;
    const options = 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + left + ',top=' + top;
    window.open('/admin/discountManagement', 'ApplyWindow', options);
}
