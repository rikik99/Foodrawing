<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/adminSalesInquiries.css" />
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>할인 관리</h1>

			<!-- 검색창 -->
			<form name="fsearch" id="fsearch" method="get">
				<div class="search-bar">
					<div class="full-width">
						<div class="half-width">
							<label for="searchInput">검색어</label> <input type="text"
								class="searchInput" placeholder="제목, 상품명, 작성자를 입력하세요"
								id="searchInput" name="searchInput">
						</div>
						<div class="half-width">
							<label for="radio-group">진행 여부</label>
							<div id="radio-group">
								<label><input type="radio" name="resolved_status"
									value="" checked> 전체</label> <label><input type="radio"
									name="resolved_status" value="Y"> 진행중</label> <label><input
									type="radio" name="resolved_status" value="N"> 종료</label>
							</div>
						</div>
					</div>
					<div class="full-width">
						<div class="half-width">
							<label for="radio-group">할인 유형</label>
							<div id="radio-group">
								<label><input type="radio" name="resolved_status"
									value="" checked> 전체</label> <label><input type="radio"
									name="resolved_status" value="이벤트"> 이벤트</label> <label><input
									type="radio" name="resolved_status" value="쿠폰"> 쿠폰</label>
							</div>
						</div>
						<div class="half-width">
							<label for="radio-group">할인 종류</label>
							<div id="radio-group">
								<label><input type="radio" name="resolved_status"
									value="" checked> 전체</label> <label><input type="radio"
									name="resolved_status" value="퍼센트"> 퍼센트</label> <label><input
									type="radio" name="resolved_status" value="금액"> 금액</label>
							</div>
						</div>
					</div>
					<div class="full-width dark-mode">
						<div class="half-width">
							<label for="fr_date">최소 구매 값</label> <input type="number"
								name="fr_date" id="fr_date" placeholder="원단위" class="secondary">
							<input type="number" name="fr_date" id="fr_date"
								placeholder="원단위" class="secondary">
						</div>
						<div class="half-width">
							<label for="fr_date">최대 할인 값</label> <input type="number"
								name="fr_date" id="fr_date" placeholder="원단위" class="secondary">
							<input type="number" name="fr_date" id="fr_date"
								placeholder="원단위" class="secondary">
						</div>
					</div>
					<div class="full-width dark-mode">
						<div class="date-group">
							<label for="fr_date">할인 기간</label> <input type="date"
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
					<div class="search-buttons full-width">
						<button type="submit" class="primary">검색</button>
						<button type="reset" class="secondary">초기화</button>
					</div>
					<div>
						<button type="button" id="editDiscount" class="primary">할인
							수정</button>
						<button type="button" id="addDiscount" class="primary">할인
							추가</button>
					</div>
				</div>
			</form>

			<!-- 상품 목록 -->
			<div class="product-list-header">
				<div>
					<span>조회된 할인 수: <strong>10</strong>개
					</span>
				</div>
			</div>
			<table class="product-list dark-mode" id="discountTable">
				<thead>
					<tr>
						<th class="discount-name-column">할인명</th>
						<th class="discount-description-column">할인 설명명</th>
						<th class="discount-type-column">할인 유형</th>
						<th class="discount-category-column">할인 종류</th>
						<th class="discount-value-column">할인 값</th>
						<th class="min-purchase-value-column">최소 구매 값</th>
						<th class="max-discount-value-column">최대 할인 값</th>
						<th class="start-date-column">시작 날짜</th>
						<th class="end-date-column">종료 날짜</th>
						<th class="status-column">진행 여부</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="discount-name-column">Summer Sale</td>
						<td class="discount-description-column">여름 특별 할인</td>
						<td class="discount-type-column">이벤트</td>
						<td class="discount-category-column">%</td>
						<td class="discount-value-column">15%</td>
						<td class="min-purchase-value-column">₩10,000</td>
						<td class="max-discount-value-column">₩50,000</td>
						<td class="start-date-column">2024-07-01</td>
						<td class="end-date-column">2024-07-31</td>
						<td class="status-column">종료</td>
					</tr>
					<tr>
						<td class="discount-name-column">Winter Sale</td>
						<td class="discount-description-column">겨울 특별 할인</td>
						<td class="discount-type-column">이벤트</td>
						<td class="discount-category-column">₩</td>
						<td class="discount-value-column">₩5,000</td>
						<td class="min-purchase-value-column">₩20,000</td>
						<td class="max-discount-value-column">₩30,000</td>
						<td class="start-date-column">2024-12-01</td>
						<td class="end-date-column">2024-12-31</td>
						<td class="status-column">예정</td>
					</tr>
					<tr>
						<td class="discount-name-column">Black Friday</td>
						<td class="discount-description-column">블랙 프라이데이 특별 할인</td>
						<td class="discount-type-column">이벤트</td>
						<td class="discount-category-column">%</td>
						<td class="discount-value-column">20%</td>
						<td class="min-purchase-value-column">₩50,000</td>
						<td class="max-discount-value-column">₩100,000</td>
						<td class="start-date-column">2024-11-25</td>
						<td class="end-date-column">2024-11-27</td>
						<td class="status-column">예정</td>
					</tr>
					<tr>
						<td class="discount-name-column">New Year Coupon</td>
						<td class="discount-description-column">새해 맞이 쿠폰</td>
						<td class="discount-type-column">쿠폰</td>
						<td class="discount-category-column">₩</td>
						<td class="discount-value-column">₩10,000</td>
						<td class="min-purchase-value-column">₩30,000</td>
						<td class="max-discount-value-column">₩50,000</td>
						<td class="start-date-column">2025-01-01</td>
						<td class="end-date-column">2025-01-15</td>
						<td class="status-column">예정</td>
					</tr>
					<tr>
						<td class="discount-name-column">Ongoing Discount</td>
						<td class="discount-description-column">현재 진행 중인 할인</td>
						<td class="discount-type-column">쿠폰</td>
						<td class="discount-category-column">₩</td>
						<td class="discount-value-column">₩8,000</td>
						<td class="min-purchase-value-column">₩25,000</td>
						<td class="max-discount-value-column">₩40,000</td>
						<td class="start-date-column">2024-06-01</td>
						<td class="end-date-column">2024-06-30</td>
						<td class="status-column">진행 중</td>
					</tr>
				</tbody>
			</table>

		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
		<script src="<c:url value='/js/admin/openWindow.js'/>"></script>
		<script src="<c:url value='/js/admin/setDateRange.js'/>"></script>
	</div>
</body>
</html>