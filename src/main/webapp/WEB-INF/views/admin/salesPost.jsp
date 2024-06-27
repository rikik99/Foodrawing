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
			<div class="search-bar">
				<div class="full-width">
					<div class="half-width">
						<label for="searchInput">검색어</label> <input type="text"
							class="searchInput" placeholder="제목, 상품명, 작성자를 입력하세요"
							id="searchInput" name="searchInput">
					</div>
				</div>
				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="last_fr_date">판매 마감일</label> <input type="date"
							name="last_fr_date" id="last_fr_date" placeholder="시작일"
							class="secondary"> <input type="date" name="last_to_date"
							id="last_to_date" placeholder="종료일" class="secondary"> <span
							class="btn_group"> <input type="button"
							class="btn_small white primary date-range-btn" data-range="today"
							data-group="last" value="오늘"> <input type="button"
							class="btn_small white primary date-range-btn"
							data-range="yesterday" data-group="last" value="어제"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="week" data-group="last" value="일주일"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="month" data-group="last" value="1개월"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="3months" data-group="last" value="3개월"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="all" data-group="last" value="전체">
						</span>
					</div>
				</div>
				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="register_fr_date">등록일</label> <input type="date"
							name="register_fr_date" id="register_fr_date" placeholder="시작일"
							class="secondary"> <input type="date"
							name="register_to_date" id="register_to_date" placeholder="종료일"
							class="secondary"> <span class="btn_group"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="today" data-group="register" value="오늘"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="yesterday" data-group="register" value="어제">
							<input type="button"
							class="btn_small white primary date-range-btn" data-range="week"
							data-group="register" value="일주일"> <input type="button"
							class="btn_small white primary date-range-btn" data-range="month"
							data-group="register" value="1개월"> <input type="button"
							class="btn_small white primary date-range-btn"
							data-range="3months" data-group="register" value="3개월"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="all" data-group="register" value="전체">
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
								name="sale_status" value="1"> 판매중</label> <label><input
								type="radio" name="sale_status" value="2"> 품절</label> <label><input
								type="radio" name="sale_status" value="3"> 단종</label>
							<label><input type="radio" name="sale_status"
								value="4"> 중지</label>
						</div>
					</div>
				</div>
				<div class="search-buttons full-width">
					<button type="button" class="primary search-btn" data-url="/admin/salesPost">검색</button>
					<button type="reset" class="secondary">초기화</button>
				</div>
			</div>

			<!-- 상품 목록 -->
			<div class="product-list-header">
				<div>
					<span>조회된 판매글 수 : <strong>${totalElements}</strong>개</span>
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
					<c:forEach items="${post.content}" var="post">
						<tr>
							<td><input type="checkbox" class="secondary selectProduct"></td>
							<td>${post.title}</td>
							<td>${post.adminDTO.name}</td>
							<td>${post.productNumber}</td>
							<td>${post.productDTO.price}</td>
							<td>${post.productDTO.quantity}</td>
							<td>
								<c:choose>
									<c:when test="${post.status == 1}">
							        판매중
								    </c:when>
										<c:when test="${post.status == 2}">
								        품절
								    </c:when>
										<c:when test="${post.status == 3}">
								        단종
								    </c:when>
										<c:when test="${post.status == 4}">
								        중지
								    </c:when>
									<c:otherwise>
							        알 수 없음
							    	</c:otherwise>
								</c:choose>
							</td>
							<td>${post.lastPostDate}</td>
							<td>${post.createdDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" data-page="${i - 1}"
							data-url="/admin/salesPost" data-size="${size}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
		<script src="<c:url value='/js/admin/starRating.js'/>"></script>
	</div>
</body>
</html>