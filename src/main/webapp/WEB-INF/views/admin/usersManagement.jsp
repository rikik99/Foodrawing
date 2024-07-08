<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/consolidated.css" />
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>회원 관리</h1>
			<div class="search-bar">
				<!-- 검색 바 코드 생략 -->
			</div>
			<div class="full-width dark-mode between">
				<div class="custom-table-header">
					<div>
						<span>조회된 회원 수: <strong>${totalElements}</strong>명
						</span>
					</div>
				</div>
			</div>
			<table class="user-table custom-table dark-mode">
				<thead>
					<tr>
						<th class="user-id-column">아이디</th>
						<th class="user-name-column">이름</th>
						<th class="member-rating-column">회원 등급</th>
						<th class="register-date-column">가입일</th>
						<th class="reserves-column">적립금</th>
						<th class="userCoupon-count-column">쿠폰 수</th>
						<th class="userOrder-count-column">주문 횟수</th>
						<th class="total-order-amount-column">주문 총액</th>
						<th class="inquiry-count-column">문의 수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${customers.content}" var="customer">
						<tr data-customer-id="${customer.id}">
							<td class="user-id-column">${customer.userDTO.username}</td>
							<td class="user-name-column">${customer.name}</td>
							<td class="member-rating-column">${customer.member.rating}</td>
							<td class="register-date-column">${customer.userDTO.formattedCreatedDate}</td>
							<td class="reserves-column">${customer.totalReserves}</td>
							<td class="userCoupon-count-column" data-customer-id="${customer.userDTO.username}">${customer.couponIssuances.size()}</td>
							<td class="userOrder-count-column" data-customer-id="${customer.userDTO.username}">${customer.orders.size()}</td>
							<td class="total-order-amount-column">${customer.totalOrderAmount}</td>
							<td class="inquiry-count-column" data-customer-id="${customer.id}" onclick="handleInquiryCountClick(event);">${customer.inquiries.size()}</td>
						</tr>
						<tr class="inquiry-list-row" data-customer-id="${customer.id}" style="display:none;">
							<td colspan="9">
								<div class="inquiry-list-container" id="inquiry-list-${customer.id}"></div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" data-page="${i - 1}"
							data-url="/admin/usersManagement" data-size="${size}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
		<script src="<c:url value='/js/admin/openWindow.js'/>"></script>
		<script src="<c:url value='/js/admin/setDateRange.js'/>"></script>
	</div>
	<button id="toggleMode" class="primary">Toggle Mode</button>
</body>
</html>