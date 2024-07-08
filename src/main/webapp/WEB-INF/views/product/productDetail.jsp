<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${productInfo.name}</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/common.css" type="text/css">
<link rel="stylesheet" href="/css/sidebar.css" type="text/css">
<link rel="stylesheet" href="/css/bestpage.css" type="text/css">
<link rel="stylesheet" href="/css/product/productimage.css" type="text/css">
<link rel="stylesheet" href="/css/product/slider.css" type="text/css">
<link rel="stylesheet" href="/css/product/cart.css" type="text/css">
<link rel="stylesheet" href="/css/product/reviewchartbox.css" type="text/css">
<style>
/* 스타일 추가 및 기존 스타일 유지 */
.detail-top {
	margin: 0;
	padding: 0;
	background-color: white;
	display: flex;
	justify-content: center;
	align-items: flex-start;
}

.detail-container {
	width: 100%;
	max-width: 1200px;
	background: white;
	padding: 20px;
	border-radius: 10px;
	display: flex;
	flex-wrap: wrap;
	justify-content: center; /* Center align the detail-container */
}

.product-section {
	display: flex;
	width: 100%;
	margin-bottom: 20px;
}

.left-column {
	flex: 1;
	padding: 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.right-column {
	flex: 1;
}

.product-info {
	font-size: 14px;
}

.price {
	color: red;
	font-size: 24px;
	font-weight: bold;
}

.original-price {
	text-decoration: line-through;
	color: gray;
}

.rating {
	font-size: 16px;
	margin-top: 10px;
}

.purchase-buttons {
	margin-top: 20px;
}

.purchase-buttons button {
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
	margin-right: 10px;
}

.cart-button {
	background-color: #4CAF50;
	color: white;
	border: none;
}

.buy-button {
	background-color: #FFA500;
	color: white;
	border: none;
}

.sticky-wrap {
	position: -webkit-sticky;
	position: sticky;
	top: 0px;
	width: 100%;
	z-index: 1000;
}

.sticky-content {
	border-bottom: 1px solid #ddd;
	margin-bottom: 20px;
	background: white;
}

.sticky-content .nav-tabs {
	margin: 0;
	padding: 0;
	list-style: none;
	display: flex;
	justify-content: center;
}

.sticky-content .nav-tabs .nav-item {
	margin-right: 20px;
}

.sticky-content .nav-tabs .nav-link {
	padding: 10px 15px;
	color: #555;
	border: 1px solid transparent;
	transition: background-color 0.3s;
}

.sticky-content .nav-tabs .nav-link.active {
	background-color: #f8f8f8;
	border-color: #ddd #ddd #fff;
}

.contents-wrapper {
	display: flex;
	justify-content: center; /* Center align the contents-wrapper */
	margin-top: 20px;
	/* Add some margin to ensure it doesn't overlap with sticky-wrap */
	margin: 0 auto;
}

.contents {
	flex: 1;
	width: 1000px; /* Limit the max width of the contents */
	padding: 20px;
}

.detail-content {
	margin-bottom: 40px;
}

.detail-content h2, .detail-content h3 {
	margin-top: 20px;
}

.product-detail {
	display: flex;
	justify-content: center;
	align-items: flex-start; /* Align items to the start */
	flex-direction: column;
}

.review-badge, .inquiry-badge {
	border: 2px solid rgb(255, 193, 7);
	padding-left: 5px;
	padding-right: 5px;
}

.review-section {
	width: 100%;
	max-width: 1100px;
	margin: 20px auto;
	padding: 20px;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.review-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

.review-header h2 {
	margin: 0;
	font-size: 24px;
}

.review-header .sort-options {
	display: flex;
	align-items: center;
}

.review-header .sort-options select, .review-header .sort-options button
	{
	margin-left: 10px;
}

.review-details {
	display: flex;
	flex-direction: column;
	width: 100%;
}

.review-item {
	display: flex;
	flex-direction: column;
	border-bottom: 1px solid #eee;
	padding: 15px 0;
}

.review-item:last-child {
	border-bottom: none;
}

.review-info {
	display: flex;
	align-items: center;
}

.review-info .review-rating {
	color: #f5a623;
	margin-right: 10px;
}

.review-info .review-author {
	font-weight: bold;
	margin-right: 10px;
}

.review-info .review-date {
	color: #aaa;
}

.review-content {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	margin: 10px 0;
}

.review-image img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 8px;
}

.pagination {
	display: flex;
	justify-content: center;
	padding: 20px 0;
}

.pagination li {
	margin: 0 5px;
}

.inquiry-section {
	width: 100%;
	max-width: 1100px;
	margin: 20px auto;
	padding: 20px;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.inquiry-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

.inquiry-header h2 {
	margin: 0;
	font-size: 24px;
}

.inquiry-item {
	display: flex;
	flex-direction: column;
	border-bottom: 1px solid #eee;
	padding: 15px 0;
	cursor: pointer;
}

.inquiry-item:last-child {
	border-bottom: none;
}

.inquiry-info {
	display: flex;
	align-items: center;
}

.inquiry-info .inquiry-badge {
	margin-right: 10px;
	display: flex; /* Flex container for alignment */
	align-items: center; /* Vertically center the badge */
}

.inquiry-info .inquiry-content {
	margin-right: 20px;
	flex-grow: 1; /* Allow content to take remaining space */
}

.inquiry-info .inquiry-author, .inquiry-info .inquiry-date {
	color: #aaa;
}

.inquiry-answer {
	display: none;
	flex-direction: column;
	margin-top: 10px;
	background: #f8f8f8;
	padding: 10px;
	border-radius: 5px;
}

.inquiry-answer-content {
    background-color: white;
    padding: 10px;
    border-radius: 5px;
    margin-top: 10px;
    border: 1px solid #ddd;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
}
.inquiry-answer-content p {
    margin: 0;
    line-height: 1.5;
}
.inquiry-answer-content strong {
    display: block;
    margin-bottom: 5px;
}

.lock-icon {
    font-size: 14px;
    color: #aaa;
    margin-right: 5px;
}

.pagination {
	display: flex;
	justify-content: center;
	padding: 20px 0;
}

.pagination li {
	margin: 0 5px;
}

.detail-cart-wrap {
	width: 100%; /* Adjust this width as needed */
	background: #f8f8f8;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.sticky-sidebar {
	width: 300px;
	position: -webkit-sticky;
	position: sticky;
	top: 70px; /* Adjust this value to control the sticky position */
	margin-right: 0px; /* Remove left margin */
}

.cart-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.cart-item div {
	flex: 1;
	text-align: center;
}

.cart-item .item-info {
	flex: 3;
	text-align: left;
}

.cart-item .item-quantity {
	display: flex;
	align-items: center;
}

.cart-item .item-quantity button {
	border: none;
	background: none;
	font-size: 16px;
	padding: 0 10px;
}

.cart-item .item-quantity input {
	width: 40px;
	text-align: center;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin: 0 10px;
}

.cart-total {
	text-align: right;
	font-size: 18px;
	font-weight: bold;
}

.sticky-sidebar .cart-item {
	display: inline-block;
}

.sticky-cart {
	max-width: 305px;
}

.review {
	margin-top: 10px;
	position: relative;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	width: 900px;
}

.review-thumbnail img {
	width: 60px;
	height: 60px;
	object-fit: cover;
	cursor: pointer;
}

.more-content {
	display: none;
	flex-direction: column;
	align-items: flex-start;
}

.full-size-img {
	width: 300px;
	height: auto;
	margin-top: 10px;
}

.more-btn {
	color: #007bff;
	cursor: pointer;
	text-decoration: underline;
	margin-top: 10px;
}

.review-section .review-answer {
	background-color: #e5e5e5;
	padding: 20px;
	border-radius: 5px;
	width: 850px;
	margin-top: 10px;
}

.review-section .review-comment {
	width: 900px;
}

.product-title {
	display: flex;
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: space-between; /* 자식 요소 간의 간격을 최대화하여 양 끝에 배치 */
	width: 100%;
	padding: 10px; /* 선택 사항: 내부 여백 추가 */
	box-sizing: border-box; /* 패딩과 테두리를 포함한 박스 크기 계산 */
}

/* 제품 이름 스타일 */
.product-title .product-name {
	font-size: 24px; /* 적절한 글꼴 크기 지정 */
	margin: 0; /* 기본 마진 제거 */
	flex-grow: 1; /* 여유 공간을 차지하게 함 */
	margin-right: 20px; /* 아이콘과의 간격 */
}

/* 위시리스트 아이콘 스타일 */
.product-title .wish-icon {
	cursor: pointer; /* 커서를 포인터로 변경하여 클릭 가능 표시 */
}

.popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .popup {
            position: absolute;
            width: 700px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1001;
        }

        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .popup-close {
            cursor: pointer;
        }
        
        .detail-discription img {
        	width: 1000px;
        }
</style>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<script>
       // UTF-8 문자열을 Base64로 인코딩하는 함수
    function btoaUtf8(str) {
        return btoa(unescape(encodeURIComponent(str)));
    }

    // Base64를 UTF-8 문자열로 디코딩하는 함수
    function atobUtf8(str) {
        return decodeURIComponent(escape(atob(str)));
    }
    document.addEventListener('DOMContentLoaded', function () {
        const salesPostId = '${salesInfo.id}';
        var discountPrice = '${discountPrice}';
        const price = '${productInfo.price}';
        var productNumber = document.getElementById('product_number').value
        
        if(discountPrice == 0) {
            discountPrice = price;
        }
        
        const productInfo = {
            salesPostId: salesPostId,
            name: '${productInfo.name}',
            filePath: '${productFileInfo.filePath}',
            originalPrice: '${productInfo.price}',
            price: discountPrice,
            productNumber: productNumber
        };

        // 쿠키에 저장된 최근 본 상품 목록을 가져옴
        let recentViewedProducts = JSON.parse(atobUtf8(getCookie('recentViewedProducts') || 'W10=')); // Base64 디코딩

        // 현재 상품을 최근 본 상품 목록에 추가
        recentViewedProducts = recentViewedProducts.filter(product => product.salesPostId !== salesPostId);
        recentViewedProducts.unshift(productInfo);

        // 최대 5개의 최근 본 상품만 저장
        /*if (recentViewedProducts.length > 5) {
            recentViewedProducts.pop();
        }*/

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

    </script>
	<script src="js/guestorder/guestid.js"></script>
</head>
<body>
	<c:set var="totalReviews" value="${totalReviews}" />
	<c:set var="ratingPercentages" value="${ratingPercentages}" />
	
	<input type="hidden" id="loginCustomerId" class="loginCustomerId" name="loginCustomerId" value="${customer.id}">

	<div class="header-wrap">
		<%@include file="/WEB-INF/include/header.jsp"%>
		<%@include file="/WEB-INF/include/nav.jsp"%>
	</div>
	<div class="detail-top">
		<div class="detail-container">
			<div class="product-section">
				<div class="left-column">
					<div class="big" id="bigImageContainer">
						<img id="bigImage" src="${productFileInfo.filePath}"
							alt="bigimage">
					</div>
					<div class="mini">
						<span data-image="/images/20240517_CaTchWorkFavicon.png"><img
							src="/images/20240517_CaTchWorkFavicon.png" alt="1"></span> <span
							data-image="images/logo_default.jpg"><img
							src="/images/logo_default.jpg" alt="2"></span> <span
							data-image="images/cblank_profile.jpg"><img
							src="/images/cblank_profile.jpg" alt="3"></span> <span
							data-image="images/cblank_profile.jpg"><img
							src="/images/cblank_profile.jpg" alt="4"></span> <span
							data-image="images/cblank_profile.jpg"><img
							src="/images/cblank_profile.jpg" alt="5"></span>
					</div>
				</div>
				<div class="right-column">
					<input type="hidden" id="product_number" name="productNumber"
						value="${productInfo.productNumber}"> <input type="hidden"
						id="salesPostId" name="salesPostId" value="${salesInfo.id}">
					<input type="hidden" id="discountPrice" name="discountPrice"
						class="discountPrice" value="${discountPrice}"> <input
						type="hidden" id="productName" name="productName"
						class="productName" value="${productInfo.name}"> <input
						type="hidden" id="productFilePath" name="productFilePath"
						class="productFilePath" value="${productFileInfo.filePath}">
					<div class="product-title">
						<h1 class="product-name">${productInfo.name}</h1>
						<img id="wish-icon" class="wish-icon"
							src="/images/svg/iconUtilWish.svg" data-wished="false"
							alt="위시리스트 아이콘">
					</div>
					<div class="product-info" style="text-align: left;">
						<input type="hidden" id="productprice" name="productprice"
							class="productprice" value="${productInfo.price}">

						<c:choose>

							<c:when test="${discountPrice == 0}">
								<p class="price">
									<fmt:formatNumber type="number" value="${productInfo.price}" />
									원
								</p>
							</c:when>
							<c:otherwise>
								<p class="original-price">
									<fmt:formatNumber type="number" value="${productInfo.price}" />
									원
								</p>
								<p class="price">
									<fmt:formatNumber type="number" value="${discountPrice}" />
									원
								</p>
							</c:otherwise>
						</c:choose>

						<p>원산지 : 하단 상품정보 참고</p>
						<div class="rating">⭐ ${averageRating} (<fmt:formatNumber type="number" value="${totalReviews}" />)</div>
					</div>
					<div class="detail-cart-wrap mt-3">
						<div class="cart-item">
							<div class="item-info">${productInfo.name}</div>
							<div class="item-quantity">
								<button class="decrement">-</button>
								<input type="text" class="quantity" value="1" readonly>
								<button class="increment">+</button>
							</div>

							<c:choose>
								<c:when test="${discountPrice == 0}">
									<div class="item-price">
										<fmt:formatNumber type="number" value="${productInfo.price}" />
										원
									</div>
								</c:when>
								<c:otherwise>
									<p>${discountType}</p>
									<div class="item-price">
										<fmt:formatNumber type="number" value="${discountPrice}" />
										원
									</div>
								</c:otherwise>
							</c:choose>

						</div>
						<div class="cart-total">
							합계 <span class="total-price"><fmt:formatNumber
									type="number" value="${productInfo.price}" />원</span>
						</div>
					</div>
					<div class="purchase-buttons">
						<button class="cart-button">장바구니담기</button>
						<button class="buy-button">바로구매</button>
					</div>
				</div>
			</div>
			<div class="sliders-section">
				<div class="slider-container">
					<div class="slider-header">
						<h2>비슷한 상품</h2>
						<div class="nav-buttons">
							<button class="nav-button prev" onclick="prevSlide('slider1')">&#10094;</button>
							<span class="page-indicator" id="page-indicator-slider1">1/1</span>
							<button class="nav-button next" onclick="nextSlide('slider1')">&#10095;</button>
						</div>
					</div>
					
					<div class="slider" id="slider1">
    <div class="slides">
        <c:forEach var="product" items="${categoryProducts}">
            <div class="slide" style="display: inline-block; width: calc(25% - 20px); vertical-align: top;">
                <div class="product-card" style="border: 1px solid #e0e0e0; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); position: relative; background-color: white; text-align: center;">
                    <div class="product-top" style="position: relative;">
                        <form method="get" action="/productDetail/${product.salesPostId}" style="margin: 0;">
                            <input type="hidden" id="salesPostId" class="salesPostId" name="id" value="${product.salesPostId}" />
                            <button type="submit" class="product-card-href" style="border: none; padding: 0; background: none; cursor: pointer;">
                                <img src="${product.filePath}" alt="${product.name}" style="width: 100%; height: auto; border-bottom: 1px solid #e0e0e0;">
                            </button>
                        </form>
                       
                    </div>
                    <form method="post" action="/productDetail/${product.salesPostId}" style="margin: 0;">
                        <input type="hidden" id="salesPostId" class="salesPostId" name="id" value="${product.salesPostId}" />
                        <button type="submit" class="product-card-href product-details-button" style="border: none; padding: 0; background: none; cursor: pointer;">
                            <div class="product-details" style="padding: 15px;">
                                <div class="product-title" style="font-size: 14px; color: #333; margin: 10px 0;">
                                    ${product.name}
                                </div>
                                <div class="product-price" style="font-size: 20px; color: #d32f2f; margin: 5px 0;">
                                    <c:choose>
                                        <c:when test="${product.discountedPrice != null}">
                                            ${product.discountedPrice}원
                                            <span class="product-old-price" style="text-decoration: line-through; color: #888; font-size: 14px; margin-left: 10px;">
                                                ${product.price}원
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            ${product.price}원
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <c:if test="${product.discountValue != null}">
                                    <div class="product-discount" style="font-size: 14px; color: #333;">
                                        ${product.discountValue}% 할인
                                    </div>
                                </c:if>
                                <div class="product-rating" style="font-size: 14px; color: #888;">
                                    ${product.description}
                                </div>
                                <div class="delivery-info" style="font-size: 14px; color: #333; margin: 10px 0;">
                                   
                                </div>
                                <div class="cart-icon" data-product-number="${product.productNumber}" style="position: absolute; bottom: 10px; right: 10px; background-color: white; padding: 10px; border-radius: 50%; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                            <img src="/images/basket-icon.png" alt="Cart Icon" style="width: 24px; height: 24px;">
                        </div>
                                <div class="refrigeration-info" style="display: flex; align-items: center; font-size: 14px; color: #333; margin-top: 10px; height: 35px;">
                                    <!-- <img src="path/to/refrigeration-icon.png" alt="Refrigeration Icon" style="width: 20px; height: 20px; margin-right: 5px;"> -->
                                    <!-- 냉장 -->
                                </div>
                            </div>
                        </button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
</div>





					
				</div>
				<div class="slider-container">
					<div class="slider-header">
						<h2>함께 보면 좋은 상품</h2>
						<div class="nav-buttons">
							<button class="nav-button prev" onclick="prevSlide('slider2')">&#10094;</button>
							<span class="page-indicator" id="page-indicator-slider2">1/1</span>
							<button class="nav-button next" onclick="nextSlide('slider2')">&#10095;</button>
						</div>
					</div>
					<div class="slider" id="slider2">
						<div class="slides">
							<div class="slide"><%@include
									file="/WEB-INF/include/productCard.jsp"%>7
							</div>
							<div class="slide"><%@include
									file="/WEB-INF/include/productCard.jsp"%>8
							</div>
							<div class="slide"><%@include
									file="/WEB-INF/include/productCard.jsp"%>9
							</div>
							<div class="slide"><%@include
									file="/WEB-INF/include/productCard.jsp"%>10
							</div>
							<div class="slide"><%@include
									file="/WEB-INF/include/productCard.jsp"%>11
							</div>
							<div class="slide"><%@include
									file="/WEB-INF/include/productCard.jsp"%>12
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="product-detail">
		<div class="sticky-wrap">
			<div class="sticky-content">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						href="#detail-content">상세정보</a></li>
					<li class="nav-item"><a class="nav-link" href="#review">리뷰(<fmt:formatNumber type="number" value="${totalReviews}" />)</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#purchase-info">상품문의</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="contents-wrapper">
			<div class="contents">
				<div id="detail-content" class="detail-content">
					<h2>제품 상세 정보</h2>
					<div class="detail-discription">
						${salesInfo.description}
					</div>
				</div>
				<div id="review" class="detail-content">
					<h2>리뷰</h2>

					<!-- Review Summary Section -->
					<div class="review-chart-box">
						<div class="rating-chart-box-inner">
							<div class="rating-wrap">
								<div class="average-rating">
									<fmt:formatNumber value="${averageRating}" type="number"
										minFractionDigits="1" maxFractionDigits="1" />
									<span>/ 5</span>
								</div>
								<div class="star-rating">
									<c:forEach var="i" begin="1" end="${floorRating}">
                    ★
                </c:forEach>
									<c:forEach var="i" begin="${floorRating + 1}" end="5">
                    ☆
                </c:forEach>
								</div>
							</div>
							<div class="review-summary">
								<div class="total-reviews">
									총 <span style="color: #FFA500;">${totalReviews}건</span>의 리뷰 중
								</div>
								<div class="percentage">
									<span style="color: #FFA500;"> ${ratingPercentages[4]}%
									</span> 고객님이 <span style="color: #FFA500;">5점</span>을 주었어요
								</div>
							</div>
						</div>
						<div class="bar-chart-wrap">
							<c:forEach var="i" begin="0" end="4">
								<div class="score-item">
									<div>${5 - i}점</div>
									<div class="score-bar">
										<div class="score"
											style="width: ${ratingPercentages[4 - i]}%;"></div>
									</div>
									<div class="score-percentage">${ratingPercentages[4 - i]}%
									</div>
								</div>
							</c:forEach>
						</div>
					</div>


					<!-- 리뷰 내용 추가 -->
					<div class="review-section">
						<div class="review-header">
							<h2>상품리뷰 ${totalReviews}건</h2>
							<div class="sort-options">
								<select>
									<option>최근 등록순</option>
									<option>높은 평점순</option>
									<option>낮은 평점순</option>
								</select>
								<button class="btn btn-outline-secondary">포토리뷰 모아보기</button>
							</div>
						</div>

						<div id="review-section" class="review-section">
							<!-- 리뷰 데이터가 여기에 비동기적으로 추가됩니다 -->
						</div>
						<ul class="pagination">
							<!-- 페이지네이션이 여기에 추가됩니다 -->
						</ul>
					</div>
				</div>

				<div id="inquiry-info" class="detail-content">
					<h2>상품 문의</h2>
					<!-- 구매 정보 추가 -->
					<div class="inquiry-section">
						<div class="inquiry-header">
							<h2>상품문의 1건</h2>
							<button class="btn btn-primary" onclick="showInquiryPopup()">상품문의 하기</button>
						</div>

						<div id="inquiry-section" class="inquiry-section"></div>
						<ul id="inquiry-pagination" class="pagination"></ul>

						
					</div>
				</div>
			</div>
			<div class="right-column sticky-cart">
				<div class="detail-cart-wrap sticky-sidebar">
					<div class="cart-item">
						<div class="item-info">비비고 왕교자 1.05kg</div>
						<div class="item-price">
							<c:choose>

							<c:when test="${discountPrice == 0}">
								<span class="price">
									<fmt:formatNumber type="number" value="${productInfo.price}" />
									원
								</span>
							</c:when>
							<c:otherwise>
								<span class="original-price">
									<fmt:formatNumber type="number" value="${productInfo.price}" />
									원
								</span>
								<span class="price" style="margin-left: 10px;">
									<fmt:formatNumber type="number" value="${discountPrice}" />
									원
								</span>
							</c:otherwise>
						</c:choose>
						</div>
						<div class="item-quantity">
							<button class="decrement">-</button>
							<input type="text" class="quantity" value="1" readonly>
							<button class="increment">+</button>
						</div>
					</div>
					<c:choose>
						<c:when test="${discountPrice == 0}">
							<div class="cart-total">
								합계 <span class="total-price"><fmt:formatNumber
										type="number" value="${productInfo.price}" />원</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="cart-total">
								합계 <span class="total-price"><fmt:formatNumber
										type="number" value="${discountPrice}" />원</span>
							</div>
						</c:otherwise>
					</c:choose>
					<!-- <div class="cart-total">합계 <span class="total-price"><fmt:formatNumber type="number" value="${productInfo.price}" />원</span></div> -->
					<div class="purchase-buttons">
						<button class="cart-button">장바구니담기</button>
						<button class="buy-button">바로구매</button>
					</div>

				</div>
			</div>
		</div>
	</div>
	
	<!-- 팝업 오버레이 -->
    <div class="popup-overlay" id="inquiryPopupOverlay">
        <div class="popup">
            <div class="popup-header">
                <h3>상품 문의</h3>
                <span class="popup-close" onclick="hideInquiryPopup()">×</span>
            </div>
            <div class="form-group">
                <label for="inquirySubject">제목</label>
                <input type="text" id="inquirySubject" class="form-control" placeholder="제목">
            </div>
            <div class="form-group">
                <label for="inquiryMessage">내용</label>
                <textarea id="inquiryMessage" class="form-control" rows="4" placeholder="내용"></textarea>
            </div>
            <div class="form-group">
                <input type="checkbox" id="inquirySecret" class="form-check-input">
                <label for="inquirySecret">비밀글로 설정</label>
            </div>
            <button class="btn btn-primary mt-3" onclick="submitInquiry()">등록</button>
        </div>
    </div>

	<%@include file="/WEB-INF/include/sidebar.jsp"%>
	<%@include file="/WEB-INF/include/footer.jsp"%>

	<script src="/js/productDetail/main.js" defer></script>
	<script src="/js/productDetail/wishlist.js"></script>
	<script src="/js/productDetail/cart.js"></script>
	<script src="/js/productDetail/reviews.js"></script>
	<script src="/js/productDetail/slider.js"></script>
	<script src="/js/productDetail/tabs.js"></script>
	<script src="/js/productDetail/totalPrice.js"></script>
	<script src="/js/productDetail/inquiries.js"></script>
</body>
</html>
