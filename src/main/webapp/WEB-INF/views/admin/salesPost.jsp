<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/adminSales.css" />
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>판매글 관리</h1>

			<!-- 검색창 -->
			<form name="fsearch" id="fsearch" method="get">
				<div class="search-bar">
					<div class="full-width">
						<div class="half-width">
							<label for="searchInput">검색어</label> <input type="text" class="searchInput"
								placeholder="제목, 상품명, 작성자를 입력하세요" id="searchInput" name="searchInput">
						</div>
					</div>
					<div class="full-width dark-mode">
						<div class="last-Date-group">
							<label for="last_fr_date">판매 마감일</label> <input type="date"
								name="last_fr_date" id="last_fr_date" placeholder="시작일" class="secondary">
							<input type="date" name="last_to_date" id="last_to_date" placeholder="종료일"
								class="secondary"> <span class="btn_group"> <input
								type="button" onclick="setDateRange('today', 'last');"
								class="btn_small white primary" value="오늘"> <input
								type="button" onclick="setDateRange('yesterday', 'last');"
								class="btn_small white primary" value="어제"> <input
								type="button" onclick="setDateRange('week', 'last');"
								class="btn_small white primary" value="일주일"> <input
								type="button" onclick="setDateRange('month', 'last');"
								class="btn_small white primary" value="1개월"> <input
								type="button" onclick="setDateRange('3months', 'last');"
								class="btn_small white primary" value="3개월"> <input
								type="button" onclick="setDateRange('all', 'last');"
								class="btn_small white primary" value="전체">
							</span>
						</div>
					</div>
					<div class="full-width dark-mode">
						<div class="date-group">
							<label for="fr_date">등록일</label> <input type="date"
								name="fr_date" id="fr_date" placeholder="시작일" class="secondary">
							<input type="date" name="to_date" id="to_date" placeholder="종료일"
								class="secondary"> <span class="btn_group"> <input
								type="button" onclick="setDateRange('today', 'register');"
								class="btn_small white primary" value="오늘"> <input
								type="button" onclick="setDateRange('yesterday', 'register');"
								class="btn_small white primary" value="어제"> <input
								type="button" onclick="setDateRange('week', 'register');"
								class="btn_small white primary" value="일주일"> <input
								type="button" onclick="setDateRange('month', 'register');"
								class="btn_small white primary" value="1개월"> <input
								type="button" onclick="setDateRange('3months', 'register');"
								class="btn_small white primary" value="3개월"> <input
								type="button" onclick="setDateRange('all', 'register');"
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
					<span>조회된 판매글 수: <strong>10</strong>개
					</span>
				</div>
				<div class="search-buttons">
					<button id="deleteSelectedButton" class="danger">선택 삭제</button>
					<button id="addSalesButton" class="primary">판매글 등록</button>
				</div>
			</div>
			<table class="product-list dark-mode">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" class="secondary"></th>
						<th>제목</th>
						<th>작성자</th>
						<th>상품코드</th>
						<th>가격</th>
						<th>재고수량</th>
						<th>상태</th>
						<th>판매 마감일</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" class="secondary"></td>
						<td>상품 제목 1</td>
						<td>작성자 1</td>
						<td>12345</td>
						<td>10,000원</td>
						<td>50</td>
						<td>판매중</td>
						<td>2024-07-01</td>
						<td>2024-06-15</td>
					</tr>
					<tr>
						<td><input type="checkbox" class="secondary"></td>
						<td>상품 제목 2</td>
						<td>작성자 2</td>
						<td>67890</td>
						<td>20,000원</td>
						<td>30</td>
						<td>판매중</td>
						<td>2024-07-01</td>
						<td>2024-06-15</td>
					</tr>
				</tbody>
			</table>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/adminMain.js'/>"></script>
	</div>
</body>
</html>
