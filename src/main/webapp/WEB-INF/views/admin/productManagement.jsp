<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/adminProducts.css" />
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>상품 관리</h1>

			<!-- 검색창 -->
			<form name="fsearch" id="fsearch" method="get">
				<div class="search-bar">
					<div class="full-width">
						<div class="half-width">
							<label for="searchInput">검색어</label> <input type="text"
								placeholder="상품명을 입력하세요" id="searchInput" name="searchInput">
						</div>
						<div class="half-width second-layer">
							<label for="category">카테고리</label> <select id="category"
								name="category" class="secondary">
								<option value="">전체</option>
								<c:forEach items="${categoryList}" var="category">
									<option value="${category.id}">${category.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
	                   <div class="full-width">
                        <div class="date-group">
                            <label for="searchIssuedDateFrom">발행 날짜</label>
                            <input type="date" name="searchIssuedDateFrom" id="fr_date" placeholder="시작일" class="secondary">
                            <input type="date" name="searchIssuedDateTo" id="to_date" placeholder="종료일" class="secondary">
                            <span class="btn_group">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="today" data-group="searchIssuedDate" value="오늘">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="yesterday" data-group="searchIssuedDate" value="어제">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="week" data-group="searchIssuedDate" value="일주일">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="month" data-group="searchIssuedDate" value="1개월">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="3months" data-group="searchIssuedDate" value="3개월">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="all" data-group="searchIssuedDate" value="전체">
                            </span>
                        </div>
                    </div>
					<div class="full-width">
						<div class="half-width number-group">
							<label for="stock_min">상품 재고</label> <input type="number"
								name="stock_min" id="stock_min" placeholder="이상"
								class="secondary"> <input type="number" name="stock_max"
								id="stock_max" placeholder="이하" class="secondary">
						</div>
						<div class="half-width number-group">
							<label for="price_min">판매 가격</label> <input type="number"
								name="price_min" id="price_min" placeholder="이상"
								class="secondary"> <input type="number" name="price_max"
								id="price_max" placeholder="이하" class="secondary">
						</div>
					</div>
					<div class="full-width">
						<div class="half-width">
							<label for="radio-group">판매 여부</label>
							<div id="radio-group">
								<label><input type="radio" name="sale_status" value=""
									checked> 전체</label> <label><input type="radio"
									name="sale_status" value="sale"> 판매중</label> <label><input
									type="radio" name="sale_status" value="soldout"> 품절</label> <label><input
									type="radio" name="sale_status" value="discontinued">
									단종</label> <label><input type="radio" name="sale_status"
									value="stopped"> 중지</label>
							</div>
						</div>

					</div>
					<div class="search-buttons full-width">
						<button type="button" class="primary search-btn">검색</button>
						<button type="reset" class="secondary">초기화</button>
					</div>
				</div>
			</form>

			<!-- 상품 목록 -->
			<div class="product-list-header">
				<div>
					<span>조회된 상품 개수: <strong>10</strong>개
					</span>
				</div>
				<div>
					<button id="deleteSelectedButton" class="danger">선택삭제</button>
					<button id="addProductButton" class="primary">상품등록</button>
				</div>
			</div>
			<table class="product-list dark-mode">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" class="secondary"></th>
						<th>이미지</th>
						<th>상품명(상품 코드, 상품명)</th>
						<th>카테고리</th>
						<th>가격</th>
						<th>재고</th>
						<th>등록일</th>
						<th>판매여부</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${product.content}" var="product">
						<tr>
							<td><input type="checkbox" class="selectProduct secondary"></td>
							<td><img class="productImg"
								src="${product.productFileDTO.filePath}" alt="상품 이미지"></td>
							<td><p>${product.productNumber}</p>
								<p>${product.name}</p></td>
							<td>${product.productCategoryDTO.name}</td>
							<td>${product.price}</td>
							<td>${product.quantity}</td>
							<td>${product.createdDate}</td>
							<td>판매중</td>
							<td><button class="editButton warning">수정</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="full-width">
			
			</div>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" href="#" data-target="productManagement"
							onclick="(function(event) { loadPage(event, ${i - 1}, ${size}); })(event)">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>

		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
	</div>
</body>
</html>
