<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="sidebar">
    <a href="/cart" class="cart-link">
        <img class="basket-icon" src="/images/basket-icon.png" alt="Cart Icon">
        <div class="sidebar-badge">${cartItemCount}</div>
        장바구니
    </a>
    <div class="recent-view">
        최근 본  
        <div class="recent-view-carousel" id="recent-view-carousel">
            <div class="carousel-slides slides">
                <!-- 최근 본 상품 목록 표시 --> 
            </div>
            <div class="carousel-navigation">
                <button class="carousel-prev" onclick="prevSlide('recent-view-carousel')">&#60;</button>
                <button class="carousel-next" onclick="nextSlide('recent-view-carousel')">&#62;</button>
            </div>
            <div id="page-indicator-recent-view-carousel" class="page-indicator"></div>
        </div>
    </div>
    <a href="#" class="top-button">
        <img class="top-icon" src="/images/btn_top_quick.png" alt="Top">
        TOP
    </a>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const recentViewedProducts = JSON.parse(atobUtf8(getCookie('recentViewedProducts') || 'W10=')); // Base64 디코딩
    const slidesContainer = document.querySelector('.recent-view-carousel .carousel-slides');
    let currentIndex = 0;

    if (recentViewedProducts.length > 0) {
        recentViewedProducts.forEach(product => {
            const slide = document.createElement('div');
            slide.classList.add('recent-product');
            slide.innerHTML = `
                <a href="/ProductDetail/\${product.salesPostId}">
                    <img class="recent-product-image" src="\${product.filePath}" alt="\${product.name}">
                    <div class="product-info">
                        <p>\${product.name}</p>
                        <p>\${product.price}원</p>
                    </div>
                </a>
            `;
            slidesContainer.appendChild(slide);
        });
    }

    function setCookie(name, value, days) {
        const d = new Date();
        d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
        const expires = "expires=" + d.toUTCString();
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

    function updateSlider() {
        const totalSlides = slidesContainer.children.length;
        slidesContainer.style.transform = `translateY(-${currentIndex * 120}px)`; // Adjust for height of each slide
    }

    document.querySelector('.carousel-prev').addEventListener('click', function () {
        if (currentIndex > 0) {
            currentIndex--;
            updateSlider();
        }
    });

    document.querySelector('.carousel-next').addEventListener('click', function () {
        if (currentIndex < slidesContainer.children.length - 3) {
            currentIndex++;
            updateSlider();
        }
    });

    slidesContainer.addEventListener('mouseover', function(event) {
        const target = event.target.closest('.recent-product');
        if (target) {
            const infoBox = target.querySelector('.product-info');
            if (infoBox) {
                infoBox.style.display = 'block';
            }
        }
    });

    slidesContainer.addEventListener('mouseout', function(event) {
        const target = event.target.closest('.recent-product');
        if (target) {
            const infoBox = target.querySelector('.product-info');
            if (infoBox) {
                infoBox.style.display = 'none';
            }
        }
    });
});

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


<style>
    .sidebar {
        position: fixed;
        top: 50%;
        right: 0;
        transform: translateY(-50%);
        width: 140px; /* Increased width for more content space */
        background-color: white;
        border: 1px solid #e0e0e0;
        border-radius: 8px 0 0 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 10px;
        z-index: 1000;
    }

    .sidebar a {
        margin: 10px 0;
        text-decoration: none;
        color: #333;
        font-size: 14px;
        text-align: center;
    }

    .sidebar a .basket-icon, .top-icon {
        width: 24px;
        height: 24px;
        display: block;
        margin: 0 auto;
    }

    .sidebar .cart-link {
        position: relative;
    }

    .sidebar .cart-link .sidebar-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background-color: red;
        color: white;
        border-radius: 50%;
        padding: 2px 4px;
        font-size: 12px;
    }

    .sidebar .top-button {
        margin-top: auto;
        margin-bottom: 10px;
    }

    .sidebar .top-button img {
        width: 32px;
        height: 32px;
    }

    .recent-view {
        width: 100%;
    }

    .recent-view-carousel {
        position: relative;
        overflow: hidden;
        width: 100%;
        height: 360px; /* Ensure enough height to display 3 items */
    }

    .carousel-slides {
        display: flex;
        transition: transform 0.3s ease-in-out;
        flex-direction: column;
        align-items: center;
        height: 100%;
    }

    .recent-product {
        margin-top: 5px;
        margin-bottom: 5px; /* Reduced margin-bottom */
        position: relative;
        width: 100%;
        height: 90px; /* Increased height to fit larger image */
    }

    .recent-product img {
        width: 80px; /* Increased width */
        height: 80px; /* Increased height */
        object-fit: cover;
        border-radius: 5px;
        display: block;
        margin: 0 auto;
    }

    .recent-product .product-info {
        display: none;
        position: absolute;
        top: 0;
        left: -200px; /* Position to the left of the image */
        width: 180px;
        background: white;
        border: 1px solid #ddd;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        padding: 10px;
        z-index: 100;
    }

    .carousel-navigation {
        position: absolute;
        bottom: 10px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
    }

    .carousel-navigation .carousel-prev,
    .carousel-navigation .carousel-next {
        background: white;
        border: 1px solid #ddd;
        cursor: pointer;
        padding: 5px 10px;
        margin: 0 5px;
    }
    
    .recent-product-image {
        width: 100px;
        height: 100px;
    }

    .page-indicator {
        margin-top: 10px;
        text-align: center;
    }
</style>
