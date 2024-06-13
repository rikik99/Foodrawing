<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="sidebar">
            <a href="#" class="cart-link">
                <img src="/images/basket-icon.png" alt="Cart Icon">
                <div class="badge">${cartItemCount}</div>
                장바구니
            </a>
            <a href="#" class="recent-view">
                최근 본
                <!-- Add content here as needed -->
            </a>
            <a href="#" class="top-button">
                <img src="/images/btn_top_quick.png" alt="Top">
                TOP
            </a>
        </div>
        
        <script>
        let topButton = document.querySelector(".top-button")
        
        topButton.addEventListener('click', function () {
            window.scrollTo(0, 0);
        });
        
        
        </script>