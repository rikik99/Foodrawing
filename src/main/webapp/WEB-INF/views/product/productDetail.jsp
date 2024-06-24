<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bibigo 왕교자</title>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/bestpage.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/product/productimage.css">
    <link rel="stylesheet" href="css/product/slider.css">
    <link rel="stylesheet" href="css/product/cart.css">
    <link rel="stylesheet" href="css/product/reviewchartbox.css">
    <link rel="stylesheet" href="css/product/review.css">
    <link rel="stylesheet" href="css/product/inquiry.css">
    <style>
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
            margin-top: 20px; /* Add some margin to ensure it doesn't overlap with sticky-wrap */
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
        .detail-content h2,
        .detail-content h3 {
            margin-top: 20px;
        }
        
        .product-detail {
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Align items to the start */
            flex-direction: column;
        }
        
        .review-badge, .inquiry-badge {
        	border: 2px solid rgb(255 193 7);
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
        .review-header .sort-options select,
        .review-header .sort-options button {
            margin-left: 10px;
        }
        /*.review-item {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }*/
        
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
        .inquiry-info .inquiry-author,
        .inquiry-info .inquiry-date {
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
            margin-bottom: 20px;
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
            width: 70%;
            height: auto;
            margin-top: 10px;
        }

        .more-btn {
            color: #007bff;
            cursor: pointer;
            text-decoration: underline;
            margin-top: 10px;
        }
        .review .review-answer {
        	background-color: #e5e5e5;
        	padding: 20px;
        	border-radius: 5px;
        	width: 900px;
        }
        .review .review-comment {
        	width: 900px;
        }
        
        
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
		<script>
        document.addEventListener('DOMContentLoaded', function() {
            const quantityInputs = document.querySelectorAll('.quantity');
            const totalPriceElements = document.querySelectorAll('.total-price');
            const pricePerItem = parseInt(document.getElementById('productprice').value);

            function updateTotalPrice() {
                const quantity = parseInt(quantityInputs[0].value);
                totalPriceElements.forEach(totalPriceElement => {
                    const totalPrice = quantity * pricePerItem;
                    totalPriceElement.innerText = totalPrice.toLocaleString() + '원';
                });
                quantityInputs.forEach(input => {
                    input.value = quantity;
                });
            }

            document.querySelectorAll('.increment').forEach(button => {
                button.addEventListener('click', function() {
                    const quantity = parseInt(quantityInputs[0].value) + 1;
                    quantityInputs.forEach(input => input.value = quantity);
                    updateTotalPrice();
                });
            });

            document.querySelectorAll('.decrement').forEach(button => {
                button.addEventListener('click', function() {
                    if (quantityInputs[0].value > 1) {
                        const quantity = parseInt(quantityInputs[0].value) - 1;
                        quantityInputs.forEach(input => input.value = quantity);
                        updateTotalPrice();
                    }
                });
            });

            updateTotalPrice();
        });
        
        document.addEventListener('DOMContentLoaded', function () {
            const cartButton = document.querySelector('.cart-button');
            const buyButton = document.querySelector('.buy-button');
            const quantityInput = document.querySelector('.quantity');
            const productNumberInput = document.getElementById('product_number');
            const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
            
            cartButton.addEventListener('click', function () {
                const quantity = parseInt(quantityInput.value);
                const productNumber = productNumberInput.value; // 실제 제품 ID로 교체
                const customerId = 1; // 실제 사용자 ID로 교체

                checkStock(productNumber, quantity, customerId);
            });

            buyButton.addEventListener('click', function () {
                // 바로구매 로직
            });

            function checkStock(productNumber, quantity, customerId) {
                const data = { productNumber, quantity, customerId };
                fetch('/cart/checkStock', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        [csrfHeader]: csrfToken
                    },
                    body: JSON.stringify(data),
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        if (data.stockAvailable) {
                            if (data.inCart) {
                                if (confirm('장바구니에 이미 있는 상품입니다. 수량을 추가하시겠습니까?')) {
                                    addToCart(productNumber, quantity, customerId);
                                }
                            } else {
                                addToCart(productNumber, quantity, customerId);
                            }
                        } else {
                            alert('재고가 부족합니다.');
                        }
                    } else {
                        alert('장바구니에 담는데 문제가 발생했습니다');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('장바구니에 담는데 문제가 발생했습니다');
                });
            }

            function addToCart(productNumber, quantity, customerId) {
                const data = { productNumber, quantity, customerId };
                fetch('/cart/addToCart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        [csrfHeader]: csrfToken
                    },
                    body: JSON.stringify(data),
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('장바구니에 담겼습니다');
                        updateCartCount(quantity);
                    } else {
                        alert('장바구니에 담는데 문제가 발생했습니다');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('장바구니에 담는데 문제가 발생했습니다');
                });
            }

            function updateCartCount(quantity) {
                const headerCartCount = document.getElementById('headerCartCount');
                const cartBadge = document.querySelector('.cart-link .badge');

                if (headerCartCount) {
                    const currentCount = parseInt(headerCartCount.textContent) || 0;
                    headerCartCount.textContent = currentCount + quantity;
                }

                if (cartBadge) {
                    const currentBadgeCount = parseInt(cartBadge.textContent) || 0;
                    cartBadge.textContent = currentBadgeCount + quantity;
                }
            }
        });
    </script>
    
    <script>
    function toggleMoreContent(id) {
        var content = document.getElementById('more-content-' + id);
        var btn = document.getElementById('more-btn-' + id);
        var thumbnail = document.getElementById('thumbnail-' + id);

        if (content.style.display === 'none' || content.style.display === '') {
            content.style.display = 'flex';
            thumbnail.style.display = 'none'; // 작은 이미지 숨기기
            btn.innerText = '닫기';
        } else {
            content.style.display = 'none';
            thumbnail.style.display = 'block'; // 작은 이미지 보이기
            btn.innerText = '더보기';
        }
    }
    
    function toggleInquiryAnswer(id) {
        var answer = document.getElementById('inquiry-answer-' + id);
        if (answer.style.display === 'none' || answer.style.display === '') {
            answer.style.display = 'flex';
        } else {
            answer.style.display = 'none';
        }
    }
    </script>
</head>
<body>
    <div class="header-wrap">
        <%@include file="/WEB-INF/include/header.jsp"%>
        <%@include file="/WEB-INF/include/nav.jsp"%>
    </div>
    <div class="detail-top">
        <div class="detail-container">
            <div class="product-section">
                <div class="left-column">
                    <div class="big" id="bigImageContainer">
                        <img id="bigImage" src="images/20240517_CaTchWorkFavicon.png" alt="bigimage">
                    </div>
                    <div class="mini">
                        <span data-image="images/20240517_CaTchWorkFavicon.png"><img src="images/20240517_CaTchWorkFavicon.png" alt="1"></span>
                        <span data-image="images/logo_default.jpg"><img src="images/logo_default.jpg" alt="2"></span>
                        <span data-image="images/cblank_profile.jpg"><img src="images/cblank_profile.jpg" alt="3"></span>
                        <span data-image="images/cblank_profile.jpg"><img src="images/cblank_profile.jpg" alt="4"></span>
                        <span data-image="images/cblank_profile.jpg"><img src="images/cblank_profile.jpg" alt="5"></span>
                    </div>
                </div>
                <div class="right-column">
                    <input type="hidden" id="product_number" name="productNumber" value="${productinfo.productNumber}">
                    <h1>${productinfo.name} 1.05kg</h1>
                    <div class="product-info" style="text-align: left;">
                        <input type="hidden" id="productprice" name="productprice" class="productprice" value="${productinfo.price}">
                        <p class="original-price"><fmt:formatNumber type="number" value="${productinfo.price}" />원</p>
                        <p class="price"><fmt:formatNumber type="number" value="${productinfo.price}" />원</p>
                        <p>원산지 : 하단 상품정보 참고</p>
                        <div class="rating">⭐ 4.9 (9,999)</div>
                    </div>
                    <div class="detail-cart-wrap mt-3">
                        <div class="cart-item">
                            <div class="item-info">비비고 왕교자 1.05kg</div>
                            <div class="item-quantity">
                                <button class="decrement">-</button>
                                <input type="text" class="quantity" value="1" readonly>
                                <button class="increment">+</button>
                            </div>
                            <div class="item-price"><fmt:formatNumber type="number" value="${productinfo.price}" />원</div>
                        </div>
                        <div class="cart-total">합계 <span class="total-price"><fmt:formatNumber type="number" value="${productinfo.price}" />원</span></div>
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
                        <h2>다른 고객이 함께 구매한 상품</h2>
                        <div class="nav-buttons">
                            <button class="nav-button prev" onclick="prevSlide('slider1')">&#10094;</button>
                            <span class="page-indicator" id="page-indicator-slider1">1/1</span>
                            <button class="nav-button next" onclick="nextSlide('slider1')">&#10095;</button>
                        </div>
                    </div>
                    <div class="slider" id="slider1">
                        <div class="slides">
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>1</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>2</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>3</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>4</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>5</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>6</div>
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
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>7</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>8</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>9</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>10</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>11</div>
                            <div class="slide"><%@include file="/WEB-INF/include/productCard.jsp"%>12</div>
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
                    <li class="nav-item">
                        <a class="nav-link active" href="#detail-content">상세정보</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#review">리뷰(9,999+)</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#purchase-info">구매정보</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="contents-wrapper">
            <div class="contents">
                <div id="detail-content" class="detail-content">
                    <h2>제품 상세 정보</h2>
                    <img src="path_to_image1.jpg" alt="제품 이미지 1">
                    <p>비비고 왕교자는 신선한 재료로 만든 고급 만두입니다. 한국에서 1등을 차지한 만두로, 쫄깃한 피와 풍부한 속을 자랑합니다.</p>
                    
                    <h3>영양 정보</h3>
                    <p>1회 제공량: 100g</p>
                    <ul>
                        <li>칼로리: 200kcal</li>
                        <li>단백질: 8g</li>
                        <li>지방: 10g</li>
                        <li>탄수화물: 22g</li>
                        <li>나트륨: 500mg</li>
                    </ul>
                    
                    <h3>조리 방법</h3>
                    <img src="path_to_image2.jpg" alt="조리 방법 이미지">
                    <p>프라이팬에 식용유를 두르고 중불에서 7분간 조리하세요. 만두가 노릇해질 때까지 구워줍니다.</p>
                    
                    <h3>원재료</h3>
                    <p>돼지고기, 부추, 양배추, 대파, 마늘, 생강, 간장, 참기름</p>
                    
                    <h3>보관 방법</h3>
                    <p>영하 18도 이하 냉동 보관</p>
                </div>
                <div id="review" class="detail-content">
                    <h2>리뷰</h2>
                    
                    <!-- Review Summary Section -->
                    <div class="review-chart-box">
                        <div class="rating-wrap">
                            <div class="average-rating">4.8<span>/5</span></div>
                            <div class="star-rating">★★★★★</div>
                        </div>
                        <div class="review-summary">
                            <div class="total-reviews">총 <span style="color: #FFA500;">47건</span>의 리뷰 중</div>
                            <div class="percentage"><span style="color: #FFA500;">87%</span> 고객님이 <span style="color: #FFA500;">5점</span>을 주었어요</div>
                        </div>
                        <div class="bar-chart-wrap">
                            <div class="score-item">
                                <div>5점</div>
                                <div class="score-bar">
                                    <div class="score" style="width: 87%;"></div>
                                </div>
                                <div class="score-percentage">87%</div>
                            </div>
                            <div class="score-item">
                                <div>4점</div>
                                <div class="score-bar">
                                    <div class="score" style="width: 10%;"></div>
                                </div>
                                <div class="score-percentage">10%</div>
                            </div>
                            <div class="score-item">
                                <div>3점</div>
                                <div class="score-bar">
                                    <div class="score" style="width: 2%;"></div>
                                </div>
                                <div class="score-percentage">2%</div>
                            </div>
                            <div class="score-item">
                                <div>2점</div>
                                <div class="score-bar">
                                    <div class="score" style="width: 1%;"></div>
                                </div>
                                <div class="score-percentage">1%</div>
                            </div>
                            <div class="score-item">
                                <div>1점</div>
                                <div class="score-bar">
                                    <div class="score" style="width: 0%;"></div>
                                </div>
                                <div class="score-percentage">0%</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 리뷰 내용 추가 -->
                    <div class="review-section">
                        <div class="review-header">
                            <h2>상품리뷰 59건</h2>
                            <div class="sort-options">
                                <select>
                                    <option>최근 등록순</option>
                                    <option>높은 평점순</option>
                                    <option>낮은 평점순</option>
                                </select>
                                <button class="btn btn-outline-secondary">포토리뷰 모아보기</button>
                                <button class="btn btn-primary">상품리뷰 쓰기</button>
                            </div>
                        </div>
        
                        <!-- Review Item -->
                        <div class="review-item">
                            <div class="review-details">
                                <div class="review-info">
                                    <span class="review-rating">★★★★★</span>
                                    <span class="review-author">sang *****</span>
                                    <span class="review-date">2024.06.10</span>
                                    <span class="review-badge text-dark" style="margin-left: 10px;">한달사용기</span>
                                </div>
                                <div class="review-content">
                                    <div class="review">
                                        <div class="review-comment">
                                            <p>맛있게 빨리 먹어서 조리하고 사진을 못찍었네요~<br>
                                               넘 자극적이지하고 담백한 육개장 맛있게 먹었어요~<br>
                                               좋아요~</p> 
                                        </div>
                                        <div class="review-thumbnail">
                                            <img id="thumbnail-1" src="images/20240517_CaTchWorkFavicon.png" alt="Review Image" onclick="toggleMoreContent(1)">
                                        </div>
                                        <div id="more-content-1" class="more-content">
                                            <img src="images/20240517_CaTchWorkFavicon.png" class="full-size-img" alt="Full Review Image">
                                            <div class="review-answer">
                                                <p>마이셰프<br>
                                                   안녕하세요 마이셰프 입니다.<br>
                                                   마이셰프를 믿고 구매해주셔서 감사합니다.<br>
                                                   늘 변하지 않는 맛과 서비스를 보답하겠습니다.<br>
                                                   감사합니다.</p>
                                            </div>
                                        </div>
                                        <div id="more-btn-1" class="more-btn" onclick="toggleMoreContent(1)">더보기</div>
                                    </div>
                                </div>
                            </div>
                        </div>
        
                        <!-- Repeat the Review Item block for more reviews -->
        
                        <!-- Pagination -->
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">4</a></li>
                            <li class="page-item"><a class="page-link" href="#">5</a></li>
                            <li class="page-item"><a class="page-link" href="#">다음</a></li>
                        </ul>
                    </div>
                </div>
                <div id="purchase-info" class="detail-content">
                    <h2>구매 정보</h2>
                    <!-- 구매 정보 추가 -->
                    <div class="inquiry-section">
                        <div class="inquiry-header">
                            <h2>상품문의 1건</h2>
                            <button class="btn btn-primary">상품문의 하기</button>
                        </div>
                        
                        <!-- Inquiry Item -->
                        <div class="inquiry-item" onclick="toggleInquiryAnswer(1)">
                            <div class="inquiry-info">
                                <span class="inquiry-badge text-dark">답변완료</span>
                                <span class="inquiry-content">배송문의입니다.</span>
                            </div>
                            <div class="inquiry-meta">
                                <span class="inquiry-author">artr *****</span>
                                <span class="inquiry-date">2024.05.15</span>
                            </div>
                            <div id="inquiry-answer-1" class="inquiry-answer">
                                <p>4월 29일에 주문한 제품이 아직도 도착을 안하고 있습니다. 주문 누락인가요? 빠른 처리 바랍니다.</p>
                                <div class="inquiry-answer-content">
                                    <p><strong>마이셰프</strong></p>
                                    <p>안녕하세요, 마이셰프입니다.</p>
                                    <p>먼저 배송으로 이용에 불편을 드려 죄송합니다.</p>
                                    <p>주문하신 상품 4월 30일 정상 출고 진행하였으나,<br>
                                    출고 진행 과정 중 송장 탈착으로 정상 배송이 불가했던 것으로 확인됩니다.</p>
                                    <p>주문하신 상품은 금일 재생산, 출고 진행 예정입니다. (5/17 수령)</p>
                                    <p>문의사항 있으시면 카카오톡 채팅으로 상담 부탁드립니다.<br>
                                    감사합니다.</p>
                                </div>
                            </div>
                        </div>
        
                        <!-- Pagination -->
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="#">&#60;</a></li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">&#62;</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="right-column sticky-cart">
                <div class="detail-cart-wrap sticky-sidebar">
                    <div class="cart-item">
                        <div class="item-info">비비고 왕교자 1.05kg</div>
                        <div class="item-price"><fmt:formatNumber type="number" value="${productinfo.price}" />원</div>
                        <div class="item-quantity">
                            <button class="decrement">-</button>
                            <input type="text" class="quantity" value="1" readonly>
                            <button class="increment">+</button>
                        </div>
                    </div>
                    <div class="cart-total">합계 <span class="total-price"><fmt:formatNumber type="number" value="${productinfo.price}" />원</span></div>
                    <div class="purchase-buttons">
                        <button class="cart-button">장바구니담기</button>
                        <button class="buy-button">바로구매</button>
                    </div>
                    
                  </div>
            </div>
        </div>
    </div>
    
    <%@include file="/WEB-INF/include/sidebar.jsp"%>
    <%@include file="/WEB-INF/include/footer.jsp"%>
    <script>
        document.querySelectorAll('.mini span').forEach(span => {
            span.addEventListener('click', function() {
                var bigImage = document.getElementById('bigImage');
                var newSrc = this.getAttribute('data-image');
                bigImage.setAttribute('src', newSrc);
            });
        });
    </script>
    
    <script>
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

    document.addEventListener('DOMContentLoaded', initSliders);
    
    document.addEventListener('DOMContentLoaded', function () {
        var navLinks = document.querySelectorAll('.nav-tabs .nav-link');
        navLinks.forEach(function (link) {
            link.addEventListener('click', function (event) {
                event.preventDefault(); // Prevent default anchor behavior
                navLinks.forEach(function (navLink) {
                    navLink.classList.remove('active'); // Remove active class from all tabs
                });
                link.classList.add('active'); // Add active class to clicked tab
                var targetId = link.getAttribute('href').substring(1); // Get the target content ID
                var targetElement = document.getElementById(targetId);
                var offset = document.querySelector('.sticky-wrap').offsetHeight; // Adjust scroll position by sticky-wrap height
                window.scrollTo({
                    top: targetElement.offsetTop - offset,
                    behavior: 'smooth'
                });
            });
        });

        // Scroll to top on page load and replace URL without hash
        if (window.location.hash) {
            history.replaceState(null, null, 'http://localhost:9086/ProductDetail');
            window.scrollTo(0, 0);
        } else {
            window.scrollTo(0, 0);
        }
    });

    // Ensure page scrolls to top on refresh
    window.addEventListener('beforeunload', function () {
        history.replaceState(null, null, 'http://localhost:9086/ProductDetail');
    });
    </script>
</body>
</html>
