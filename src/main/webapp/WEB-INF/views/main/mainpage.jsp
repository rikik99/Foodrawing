<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/bestpage.css">
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/sidebar.css">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <style>
        .section {
            padding-bottom: 20px;
            margin-bottom: 20px;
        }

        .section.grid {
            display: grid;
            grid-template-columns: repeat(2, 6fr);
            grid-gap: 20px;
        }

        .section.grid {
            text-align: right;
        }

        .btn-group-vertical {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
        }

        .btn-group-vertical>button>img {
            width: 325px;
            height: 100px;
            border-radius: 20px;
        }

        .btn-group-vertical>button {
            width: 650px;
            height: 100px;
            border-radius: 20px;
        }

        .buttonText {
            position: absolute;
            top: 50%;
            left: 78%;
            transform: translate(-50%, -50%);
        }

        .btnGroup {
            position: relative;
            padding: 0px;
            margin: 0px;
            margin-bottom: 10px;
        }

        .image-container {
            width: 1400px;
            height: 300px;
            position: relative;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .image-controls {
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            transform: translateY(-50%);
            display: flex;
            justify-content: space-between;
            padding: 0 20px;
        }

        .image-controls button {
            background-color: rgba(0, 0, 0, 0.5);
            border: none;
            color: white;
            font-size: 24px;
            padding: 10px;
            cursor: pointer;
            border-radius: 50%;
        }

        .image-controls button i {
            display: block;
        }

        .image-index {
            display: none;
        }

        .grid-item {
            max-width: 800px;
            margin: 0 auto;
        }

        .slide_div img {
            max-width: 150px;
            max-height: 150px;
            object-fit: cover;
            margin-right: 20px;
        }

        .content-wrapper {
            display: flex;
            align-items: center;
        }

        .content-wrapper img {
            margin-right: 20px;
        }

        .slick-prev, .slick-next {
            display: block !important;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            font-size: 24px;
            line-height: 50px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1;
        }

        .slick-prev {
            left: 10px;
        }

        .slick-next {
            right: 10px;
        }

        .saleicon {
            width: 35px;
            height: 35px;
        }

        .product-title .product-name {
            font-size: larger;
        }

        .product-title .product-description {
            color: #b4b4b4;
        }

        .product-card {
            height: 600px;
        }

        .slick-slider {
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/include/sidebar.jsp" %>
    <%@ include file="/WEB-INF/include/header.jsp" %>
    <%@ include file="/WEB-INF/include/nav.jsp" %>
    <main>
        <div class="image-container">
            <img id="image-container" src="/images/2.png" alt="이미지" style="width: 100%; height: 100%; object-fit: contain;">
            <div class="image-controls">
                <button id="prev-btn" class="prev-btn">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button id="next-btn" class="next-btn">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
            <div id="image-index" class="image-index">1/5</div>
        </div>

        <section style="margin-top:100px;">
            <c:choose>
                <c:when test="${category == 11}">
                <div style="text-align:center;">
                <h2>회원님의 추천상품</h2>
                    <small>균형잡힌 식단</small>
                </div>
                </c:when>
                <c:when test="${category == 12}">
                <div style="text-align:center;">
                 <h2>회원님의 추천상품</h2>
                    <small>단백질 위주 식단</small>
                    </div>
                </c:when>
                <c:when test="${category == 13}">
                <div style="text-align:center;">
                 <h2>회원님의 추천상품</h2>
                    <small>다이어트 식단</small>
                    </div>
                </c:when>
                <c:when test="${category == 22}">
                <div style="text-align:center;">
                 <h2>회원님의 추천상품</h2>
                    <small>저염 식단</small>
                    </div>
                </c:when>
            </c:choose>

            <div class="container" >
                <div class="product-slider" >
                    <c:forEach var="product" items="${recommendedProducts}">
                        <div class="product-card" style="height:500px;">
                            <div class="product-top">
                                <a class="product-card-href" href="/ProductDetail?productNumber=${product.productNumber}">
                                    <img src="${product.productFileDTO.filePath}" alt="${product.name}">
                                </a>
                            </div>
                            <div class="product-details">
                                <div class="product-title">
                                    <span class="product-name">${product.name}</span><br>
                                    <span class="product-description">${product.description}</span>
                                </div>
                                <div class="product-price">
                                    ${product.price}원
                                </div>
                                <div class="product-rating">★ 4.7 (64)</div>
                                <div class="delivery-info">
                                    내일 <span>꼭! 도착</span><br>
                                    내일 도착예정
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <div class="section grid" style="border: 1px solid #ccc; padding: 20px; margin-top: 20px;">
            <div class="grid-item" >
                <h3 style="text-align: center; font-weight: bold">
                    할인품목<img src="/images/saleicon.png" class="saleicon">
                </h3>
                <div class="now-top item-area" id="discountMainArea">
                    <c:set var="firstProduct" value="${products[0]}" />
                    <div class="box">
                        <a href="#" class="item-link">
                            <img src="${firstProduct.productFileDTO.filePath}" style="margin: 10px; min-width: 230px; max-width: 400px; width: 100%;">
                            <div class="box_list_title" style="text-align: left;">${firstProduct.name}</div>
                        </a>
                        <div class="box_list_sub" style="text-align: left;">${firstProduct.description}</div>
                        <div class="box_list_price" style="text-align: left;">${firstProduct.price}원</div>
                    </div>
                </div>
            </div>
            <div class="grid-item" style="display: flex; flex-direction: column; align-items: left; padding-left: 20px;">
                <div class="slick_slider">
                    <c:forEach var="product" items="${products}">
                        <div class="slide_div">
                            <div class="content-wrapper" style="display: flex; align-items: center;">
                                <a href="#" class="item-link"><img src="${product.productFileDTO.filePath}" alt="${product.name}"></a>
                                <div style="text-align: left;">
                                    <h4>${product.name}</h4>
                                    <p>${product.price}원</p>
                                    <p>${product.description}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="section">베스트 상품</div>

        <div class="section">
            <h1 style="text-align: center;">메인 품목</h1>
            <div class="container">
                <div class="row">
                    <c:forEach var="product" items="${products}">
                        <div class="col-md-4 mb-5">
                            <div class="product-card">
                                <div class="product-top">
                                    <a class="product-card-href" href="/ProductDetail">
                                        <div class="badge">BEST</div>
                                        <img src="${product.productFileDTO.filePath}" alt="${product.name}">
                                    </a>
                                    <a class="product-card-cart-href" href="#">
                                        <div class="cart-icon">
                                            <img src="/images/basket-icon.png" alt="Cart Icon">
                                        </div>
                                    </a>
                                </div>
                                <a class="product-card-href" href="/ProductDetail">
                                    <div class="product-details">
                                        <div class="product-title">
                                            <span class="product-name">${product.name}</span><br>
                                            <span class="product-description">${product.description}</span>
                                        </div>
                                        <div class="product-price">
                                            ${product.price}원
                                            <span class="product-old-price">7,980원</span>
                                        </div>
                                        <div class="product-discount">35% 할인</div>
                                        <div class="product-rating">★ 4.7 (64)</div>
                                        <div class="delivery-info">
                                            내일 <span>꼭! 도착</span><br>
                                            내일 06/08 (토) 도착예정
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <a href="/main/custompage">test</a>
        <a href="/main/bestpage">best</a>
        <a href="/user/myPage">mypage</a>
    </main>
    <%@ include file="/WEB-INF/include/footer.jsp" %>
    <script>
    const imageContainer = document.getElementById('image-container');
    const prevBtn = document.getElementById('prev-btn');
    const nextBtn = document.getElementById('next-btn');
    const imageIndex = document.getElementById('image-index');

    const images = ['/images/2.png', '/images/3.png', '/images/7.png', '/images/8.png', '/images/9.png'];

    let currentIndex = 0;

    function changeImage() {
        currentIndex = (currentIndex + 1) % images.length;
        imageContainer.src = images[currentIndex];
        imageIndex.textContent = `${currentIndex + 1}/${images.length}`;
    }

    prevBtn.addEventListener('click', () => {
        currentIndex = (currentIndex - 1 + images.length) % images.length;
        imageContainer.src = images[currentIndex];
        imageIndex.textContent = `${currentIndex + 1}/${images.length}`;
    });

    nextBtn.addEventListener('click', changeImage);

    setInterval(changeImage, 3000);

    $(document).ready(function() {
        $('.slick_slider').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: true,
            vertical: true,
            autoplaySpeed: 1000,
            responsive: [
                {
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });

        // 추천상품(카테고리별) 슬릭슬라이더
        $('.product-slider').slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 2000,
            arrows: true,
            prevArrow: '<button type="button" class="slick-prev"><i class="fas fa-chevron-left"></i></button>',
            nextArrow: '<button type="button" class="slick-next"><i class="fas fa-chevron-right"></i></button>',
            responsive: [
                {
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    });
    </script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
