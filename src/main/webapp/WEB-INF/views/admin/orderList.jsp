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
			<h1>주문 관리</h1>

			<!-- 검색창 -->
			<form name="fsearch" id="fsearch" method="get">
				<div class="search-bar">
					<div class="full-width">
						<div class="half-width">
							<label for="searchUser">검색어</label> 
							<input type="text" class="searchInput" placeholder="고객 아이디 및 이름을 입력해주세요" id="searchUser" name="searchUser">
						</div>
					</div>
					<div class="full-width">
						<label for="orderStatus">주문 상태</label>
						<div class="checkbox-group" data-group="orderStatus">
							<label><input type="checkbox" class="select-all" data-group="orderStatus" value="all"> 전체</label>
							<label><input type="checkbox" name="orderStatus" value="pending"> 입금대기</label>
							<label><input type="checkbox" name="orderStatus" value="paid"> 입금완료</label>
							<label><input type="checkbox" name="orderStatus" value="preparing"> 배송준비</label>
							<label><input type="checkbox" name="orderStatus" value="shipping"> 배송중</label>
							<label><input type="checkbox" name="orderStatus" value="delivered"> 배송완료</label>
						</div>
					</div>
					<div class="full-width">
						<label for="cancelStatus">취소 상태</label>
						<div class="checkbox-group" data-group="cancelStatus">
							<label><input type="checkbox" class="select-all" data-group="cancelStatus" value="all"> 전체</label>
							<label><input type="checkbox" name="cancelStatus" value="cancelled"> 취소</label>
							<label><input type="checkbox" name="cancelStatus" value="refunded"> 환불</label>
							<label><input type="checkbox" name="cancelStatus" value="returned"> 반품</label>
							<label><input type="checkbox" name="cancelStatus" value="exchanged"> 교환</label>
						</div>
					</div>
					<div class="full-width">
						<div class="date-group">
							<label for="dateType">날짜 유형</label> 
							<select id="dateType" name="dateType" class="secondary">
								<option value="orderDate">주문일</option>
								<option value="paymentDate">입금일</option>
								<option value="shippingRegisterDate">배송등록일</option>
								<option value="deliveryDate">배송완료일</option>
							</select> 
							<input type="date" name="searchIssuedDateFrom" id="searchIssuedDateFrom" placeholder="시작일" class="secondary">
							<input type="date" name="searchIssuedDateTo" id="searchIssuedDateTo" placeholder="종료일" class="secondary">
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
					<div class="search-buttons full-width">
						<button type="submit" class="primary">검색</button>
						<button type="reset" class="secondary">초기화</button>
					</div>
				</div>
			</form>

			<!-- 주문 목록 -->
			<div class="product-list-header">
				<div>
					<span>조회된 주문 수: <strong>10</strong>개</span>
				</div>
			</div>
			<table class="product-list dark-mode" id="orderTable">
				<thead>
					<tr>
						<th class="order-id-column">주문 번호</th>
						<th class="customer-id-column">고객 ID</th>
						<th class="customer-name-column">고객 이름</th>
						<th class="order-date-column">주문 날짜</th>
						<th class="payment-date-column">입금 날짜</th>
						<th class="shipping-register-date-column">배송등록 날짜</th>
						<th class="delivery-date-column">배송완료 날짜</th>
						<th class="order-status-column">주문 상태</th>
						<th class="cancel-status-column">취소 상태</th>
						<th class="total-amount-column">총 금액</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="order-id-column">123456789</td>
						<td class="customer-id-column">user01</td>
						<td class="customer-name-column">홍길동</td>
						<td class="order-date-column">2024-07-01</td>
						<td class="payment-date-column">2024-07-01</td>
						<td class="shipping-register-date-column">2024-07-02</td>
						<td class="delivery-date-column">2024-07-05</td>
						<td class="order-status-column">배송완료</td>
						<td class="cancel-status-column">-</td>
						<td class="total-amount-column">₩100,000</td>
					</tr>
					<tr>
						<td class="order-id-column">987654321</td>
						<td class="customer-id-column">user02</td>
						<td class="customer-name-column">이순신</td>
						<td class="order-date-column">2024-06-01</td>
						<td class="payment-date-column">2024-06-01</td>
						<td class="shipping-register-date-column">2024-06-02</td>
						<td class="delivery-date-column">2024-06-05</td>
						<td class="order-status-column">배송완료</td>
						<td class="cancel-status-column">-</td>
						<td class="total-amount-column">₩200,000</td>
					</tr>
				</tbody>
			</table>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
		<script src="<c:url value='/js/admin/setDateRange.js'/>"></script>
	</div>
</body>
</html>
