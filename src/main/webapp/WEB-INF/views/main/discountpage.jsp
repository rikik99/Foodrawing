<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Discount Products</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/bestpage.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/sidebar.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<style>
.product-card {
    height: 600px;
}

.product-title .product-name {
    font-size: 1.2em;
    font-weight: bold;
}

.product-title .product-description {
    color: #b4b4b4;
    margin-top: 5px;
}

.product-rating {
    color: #ffa500;
    margin-top: 5px;
}

.delivery-info {
    font-size: 0.9em;
    color: #888;
    margin-top: 10px;
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/sidebar.jsp"%>
    <%@ include file="/WEB-INF/include/header.jsp"%>
    <%@ include file="/WEB-INF/include/nav.jsp"%>
    <main>
        <div class="section">
            <div style="text-align:center; padding-top:50px; padding-bottom:50px;">
                <h1>할인 상품</h1>
                <small>특가로 제공되는 상품들</small>
            </div>
            <div class="container">
                <div class="row">
                    <c:forEach var="product" items="${discountProducts}">
                        <div class="col-md-4 mb-5">
                            <div class="product-card">
                                <div class="product-top">
                                    <a class="product-card-href" href="/ProductDetail?salesPostId=${product.id}">
                                        <div class="badge">SALE</div>
                                        <img src="${product.productFilePath}" alt="${product.productName}">
                                    </a>
                                    <a class="product-card-cart-href" href="#">
                                        <div class="cart-icon">
                                            <img src="/images/basket-icon.png" alt="Cart Icon">
                                        </div>
                                    </a>
                                </div>
                                <a class="product-card-href" href="/ProductDetail?salesPostId=${product.id}">
                                    <div class="product-details">
                                        <div class="product-title">
                                            <span class="product-name">${product.productName}</span><br>
                                            <span class="product-description">${product.productDescription}</span>
                                        </div>
                                        <div class="product-price">
                                            <span class="text-danger">${product.discountedPrice}원</span>
                                            <span class="product-old-price">${product.originalPrice}원</span>
                                        </div>
                                        <div class="product-discount">${product.discountValue}% 할인</div>
                                        <div class="product-rating">★ 4.7 (64)</div>
                                        <div class="delivery-info">
                                            내일 <span>꼭! 도착</span><br> 내일 도착예정
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="/WEB-INF/include/footer.jsp"%>
 <script>
        function atobUtf8(str) {
            return decodeURIComponent(escape(window.atob(str)));
        }

        document.addEventListener("DOMContentLoaded", function() {
            // atobUtf8 함수를 사용하여 필요한 로직을 수행
            console.log(atobUtf8("c29tZSBzdHJpbmc=")); // 예시: 디코딩된 문자열 출력
        });
    </script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
