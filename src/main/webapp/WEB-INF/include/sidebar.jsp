<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <div class="sidebar">
        <a href="/cart" class="cart-link">
            <img class="basket-icon" src="/images/basket-icon.png" alt="Cart Icon">
            <div class="sidebar-badge">${cartItemCount}</div>
            장바구니
        </a>
        <div class="recent-view">
            최근 본 상품
            <div class="recent-view-carousel" id="recent-view-carousel">
                <div class="carousel-slides">
                    <!-- 최근 본 상품 목록 표시 -->
                    <c:forEach var="product" items="${recentViewedProducts}" varStatus="status">
                        <c:if test="${status.index % 3 == 0}">
                            <div class="carousel-slide">
                        </c:if>
                        <div class="recent-product" data-salesPostId="${product.salesPostId}">
                            <a href="/ProductDetail/${product.salesPostId}">
                                <img class="recent-product-image" src="${product.filePath}" alt="${product.name}">
                                <div class="product-info">
                                    <p>${product.name}</p>
                                    <c:choose>
                                        <c:when test="${product.discountPrice eq product.price}">
                                            <p class="no-discount-price">${product.price}원</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p><span class="original-price">${product.price}원</span> <span class="discount-price">${product.discountPrice}원</span></p>
                                        </c:otherwise>
                                    </c:choose>
                                    <button class="remove-product">X</button>
                                </div>
                            </a>
                        </div>
                        <c:if test="${status.index % 3 == 2 || status.last}">
                            </div>
                        </c:if>
                    </c:forEach>
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
        let sidebarCurrentIndex = 0;

        function initSliders() {
            const slidesContainer = document.querySelector('.carousel-slides');
            const totalSlides = slidesContainer.children.length;
            const slidesToShow = 1; // 한 번에 보여줄 슬라이드 수 (한 슬라이드에 세로로 3개씩 포함)

            slidesContainer.style.width = (totalSlides * 100) + '%';
            for (let slide of slidesContainer.children) {
                slide.style.width = (100 / totalSlides) + '%'; // 각 슬라이드의 너비 설정
            }

            updateSlider(slidesContainer, sidebarCurrentIndex);
            updatePageIndicator('recent-view-carousel');
        }

        function nextSlide(sliderId) {
            const slidesContainer = document.querySelector('.carousel-slides');
            const totalSlides = slidesContainer.children.length;
            const slidesToShow = 1; // 한 번에 보여줄 슬라이드 수

            if (sidebarCurrentIndex < totalSlides - slidesToShow) {
                  sidebarCurrentIndex++;
                updateSlider(slidesContainer, sidebarCurrentIndex);
                updatePageIndicator(sliderId);
            }
        }

        function prevSlide(sliderId) {
            const slidesContainer = document.querySelector('.carousel-slides');
            const slidesToShow = 1;

            if (sidebarCurrentIndex > 0) {
                  sidebarCurrentIndex--;
                updateSlider(slidesContainer, sidebarCurrentIndex);
                updatePageIndicator(sliderId);
            }
        }

        function updateSlider(slidesContainer, index) {
            const slideWidth = slidesContainer.children[0].getBoundingClientRect().width;
            const newTransformValue = -(index * slideWidth);
            slidesContainer.style.transform = 'translateX(' + newTransformValue + 'px)';
        }

        function updatePageIndicator(sliderId) {
            const slidesContainer = document.querySelector('.carousel-slides');
            const totalSlides = slidesContainer.children.length;
            const slidesToShow = 1;
            const currentPage = Math.ceil((sidebarCurrentIndex + 1) / slidesToShow);
            const totalPages = Math.ceil(totalSlides / slidesToShow);

            const pageIndicator = document.getElementById('page-indicator-' + sliderId);
            pageIndicator.textContent = currentPage + '/' + totalPages;
        }

        document.addEventListener('DOMContentLoaded', initSliders);

        document.addEventListener('DOMContentLoaded', function () {
            const slidesContainer = document.querySelector('.carousel-slides');
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

            document.querySelectorAll('.remove-product').forEach(button => {
                button.addEventListener('click', function(event) {
                    event.preventDefault();
                    const productElement = this.closest('.recent-product');
                    const salesPostId = productElement.getAttribute('data-salesPostId');
                    removeProductFromCookie(salesPostId);
                    productElement.remove();
                    updateSlider(slidesContainer, sidebarCurrentIndex); // 슬라이더 업데이트
                });
            });
        });

        function removeProductFromCookie(salesPostId) {
            let recentViewedProducts = JSON.parse(atobUtf8(getCookie('recentViewedProducts') || 'W10=')); // Base64 디코딩
            recentViewedProducts = recentViewedProducts.filter(product => product.salesPostId !== salesPostId);
            setCookie('recentViewedProducts', btoaUtf8(JSON.stringify(recentViewedProducts)), 7); // Base64 인코딩
            // 슬라이더 업데이트
            const slidesContainer = document.querySelector('.carousel-slides');
            updateSlider(slidesContainer, sidebarCurrentIndex);
            updatePageIndicator('recent-view-carousel');
        }

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

        document.addEventListener('DOMContentLoaded', function() {
            const topButton = document.querySelector(".top-button");
            topButton.addEventListener('click', function () {
                window.scrollTo(0, 0);
            });
        });
    </script>
