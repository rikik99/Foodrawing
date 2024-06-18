<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="sidebar">
    <a href="/cart" class="cart-link">
        <img src="/images/basket-icon.png" alt="Cart Icon">
        <div class="badge">${cartItemCount}</div>
        장바구니
    </a>
    <div class="recent-view">
        최근 본  
        <c:forEach var="product" items="${sessionScope.recentViewedProducts}">
            <div class="recent-product">
                <a href="/product/${product.ProductNumber}">
                    <img src="${product.imagePath}" alt="${product.name}">
                    <p>${product.name}</p>
                </a>
            </div>
        </c:forEach>
    </div>
    <a href="#" class="top-button">
        <img src="/images/btn_top_quick.png" alt="Top">
        TOP
    </a>
</div>

<script>
    let topButton = document.querySelector(".top-button");
    topButton.addEventListener('click', function () {
        window.scrollTo(0, 0);
    });
</script>

<style>
    .recent-product {
        margin-bottom: 10px;
    }
    .recent-product img {
        width: 50px;
        height: 50px;
        object-fit: cover;
        border-radius: 5px;
    }
    .recent-product p {
        margin: 5px 0 0;
        font-size: 0.9em;
    }
</style>
