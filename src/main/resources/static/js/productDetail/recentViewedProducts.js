export function recentViewedProducts(salesPostId, discountPrice, price, productName, productFilePath) {
    if (discountPrice == 0) {
        discountPrice = price;
    }

    const productInfo = {
        salesPostId: salesPostId,
        name: productName,
        filePath: productFilePath,
        originalPrice: price,
        price: discountPrice
    };

    let recentViewedProducts = JSON.parse(atobUtf8(getCookie('recentViewedProducts') || 'W10=')); // Base64 디코딩

    recentViewedProducts = recentViewedProducts.filter(product => product.salesPostId !== salesPostId);
    recentViewedProducts.unshift(productInfo);

    if (recentViewedProducts.length > 5) {
        recentViewedProducts.pop();
    }

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

    function btoaUtf8(str) {
        return btoa(unescape(encodeURIComponent(str)));
    }

    function atobUtf8(str) {
        return decodeURIComponent(escape(atob(str)));
    }
}
