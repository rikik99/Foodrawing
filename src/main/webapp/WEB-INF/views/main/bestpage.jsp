<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Best Selling Products</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/bestpage.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/sidebar.css">
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
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
			<h1>베스트 상품</h1>
			<small>많이 팔린 순서대로</small>
			</div>
			<div class="container">
				<div class="row">
					<c:forEach var="product" items="${bestSellingProducts}">
						<div class="col-md-4 mb-5">
							<div class="product-card">
								<div class="product-top">
									<a class="product-card-href"
										href="/ProductDetail?salesPostId=${product.salesPostId}">
										<div class="badge">BEST</div> <img src="${product.filePath}"
										alt="${product.salesPostTitle}">
									</a> <a class="product-card-cart-href" href="#">
										<div class="cart-icon">
											<img src="/images/basket-icon.png" alt="Cart Icon">
										</div>
									</a>
								</div>
								<a class="product-card-href"
									href="/ProductDetail?salesPostId=${product.salesPostId}">
									<div class="product-details">
										<div class="product-title">
											<span class="product-name">${product.salesPostTitle}</span><br>
											<span class="product-description">${product.salesPostDescription}</span>
										</div>
										<div class="product-price">
											${product.unitPrice}원
										</div>
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

	<script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
