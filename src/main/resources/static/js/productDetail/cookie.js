// UTF-8 문자열을 Base64로 인코딩하는 함수
    function btoaUtf8(str) {
        return btoa(unescape(encodeURIComponent(str)));
    }

    // Base64를 UTF-8 문자열로 디코딩하는 함수
    function atobUtf8(str) {
        return decodeURIComponent(escape(atob(str)));
    }
	document.addEventListener('DOMContentLoaded', function () {
	    const salesPostId = document.getElementById('salesPostId').value;
	    var discountPrice = document.getElementById('discountPrice').value;
	    const price = document.getElementById('productInfoPrice').value;
	    var name = document.getElementById('productInfoName').value;
	    var filePath = document.getElementById('productInfoFilePath').value;
	    var originalPrice = document.getElementById('productprice').value;
	    
	    if(discountPrice == 0) {
	        discountPrice = price;
	    }
	    
	    const productInfo = {
	        salesPostId: salesPostId,
	        name: name,
	        filePath: filePath,
	        originalPrice: originalPrice,
	        price: discountPrice
	    };

	    // 쿠키에 저장된 최근 본 상품 목록을 가져옴
	    let recentViewedProducts = JSON.parse(atobUtf8(getCookie('recentViewedProducts') || 'W10=')); // Base64 디코딩

	    // 현재 상품을 최근 본 상품 목록에 추가
	    recentViewedProducts = recentViewedProducts.filter(product => product.salesPostId !== salesPostId);
	    recentViewedProducts.unshift(productInfo);

	    // 최대 5개의 최근 본 상품만 저장
	    if (recentViewedProducts.length > 5) {
	        recentViewedProducts.pop();
	    }

	 	// 쿠키에 저장
	    setCookie('recentViewedProducts', btoaUtf8(JSON.stringify(recentViewedProducts)), 7); // Base64 인코딩

	    function setCookie(name, value, days) {
	        const expires = ""; // 컴퓨터가 종료되면 쿠키가 삭제되도록 설정
	        document.cookie = name + "=" + value + ";" + expires + ";path=/";
	    }

	    function getCookie(name) {
	        const decodedCookie = decodeURIComponent(document.cookie);
	        const ca = decodedCookie.split(';');
	        name = name + "=";
	        for (let i = 0; i < ca.length; i++) {
	            let c = ca[i];
	            while (c.charAt(0) == ' ') {
	                c = c.substring(1);
	            }
	            if (c.indexOf(name) == 0) {
	                return c.substring(name.length, c.length);
	            }
	        }
	        return "";
	    }
	});