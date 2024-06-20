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
								<option value="001">패션의류/잡화/뷰티</option>
								<option value="002">식품/생필품</option>
								<option value="003">출산/유아동</option>
								<option value="004">생활/건강</option>
								<option value="005">가구/인테리어</option>
								<option value="006">가전/디지털/컴퓨터</option>
								<option value="007">스포츠/레저/자동차/공구</option>
								<option value="008">도서/여행/e쿠폰/취미</option>
							</select>
						</div>
					</div>
					<div class="full-width dark-mode">
						<div class="date-group">
							<label for="fr_date">기간 검색</label> <input type="date"
								name="fr_date" id="fr_date" placeholder="시작일" class="secondary">
							<input type="date" name="to_date" id="to_date" placeholder="종료일"
								class="secondary"> <span class="btn_group"> <input
								type="button" onclick="setDateRange('today');"
								class="btn_small white primary" value="오늘"> <input
								type="button" onclick="setDateRange('yesterday');"
								class="btn_small white primary" value="어제"> <input
								type="button" onclick="setDateRange('week');"
								class="btn_small white primary" value="일주일"> <input
								type="button" onclick="setDateRange('month');"
								class="btn_small white primary" value="1개월"> <input
								type="button" onclick="setDateRange('3months');"
								class="btn_small white primary" value="3개월"> <input
								type="button" onclick="setDateRange('all');"
								class="btn_small white primary" value="전체">
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
						<button type="submit" class="primary">검색</button>
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
					<tr>
						<td><input type="checkbox" class="selectProduct secondary"></td>
						<td><img src="http://example.com/image1.jpg" alt="상품1 이미지"></td>
						<td><p>ST001</p>
							<p>의정부식 부대볶음 밀키트</p></td>
						<td>국,탕,찌개</td>
						<td>₩12,000</td>
						<td>100</td>
						<td>2024-06-13</td>
						<td>판매중</td>
						<td><button class="editButton warning">수정</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" class="selectProduct secondary"></td>
						<td><img src="http://example.com/image1.jpg" alt="상품1 이미지"></td>
						<td>상품 설명</td>
						<td>카테고리 1</td>
						<td>₩10,000</td>
						<td>50</td>
						<td>2024-06-17</td>
						<td>판매중</td>
						<td><button class="editButton warning">수정</button></td>
					</tr>
				</tbody>
			</table>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
	</div>
</body>
</html>
