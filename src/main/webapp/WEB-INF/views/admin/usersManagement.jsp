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
				<div class="full-width">
					<div class="half-width">
						<label for="searchInput">검색어</label> <input type="text"
							class="searchInput" placeholder="아이디, 이름을 입력하세요" id="searchInput"
							name="searchInput">
					</div>
				</div>
				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="register_fr_date">가입일</label> <input type="date"
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
					<div class="half-width">
						<label for="memberRating">회원 등급</label> <select id="memberRating"
							name="memberRating" class="secondary">
							<option value="">전체</option>
							<c:forEach items="${memberRatings}" var="rating">
								<option value="${rating.id}">${rating.rating}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="search-buttons full-width">
					<button type="button" class="primary search-btn"
						data-url="/admin/usersManagement">검색</button>
					<button type="reset" class="secondary">초기화</button>
				</div>
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
						<th><input type="checkbox" id="selectAll" class="secondary"></th>
						<th class="user-id-column">아이디</th>
						<th class="user-name-column">이름</th>
						<th class="member-rating-column">회원 등급</th>
						<th class="register-date-column">가입일</th>
						<th class="reserves-column">적립금</th>
						<th class="coupon-count-column">쿠폰 수</th>
						<th class="order-count-column">주문 횟수</th>
						<th class="total-order-amount-column">주문 총액</th>
						<th class="inquiry-count-column">문의 수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${customers.content}" var="customer">
						<tr data-customerId=${customer.id}>
							<td><input type="checkbox" class="selectUser secondary"></td>
							<td class="user-id-column">${customer.userDTO.username}</td>
							<td class="user-name-column">${customer.name}</td>
							<td class="member-rating-column">${customer.member.rating}</td>
							<td class="register-date-column">${customer.userDTO.formattedCreatedDate}</td>
							<td class="reserves-column">${customer.totalReserves}</td>
							<td class="coupon-count-column">${customer.couponIssuances.size()}</td>
							<td class="order-count-column">${customer.orders.size()}</td>
							<td class="total-order-amount-column">${customer.totalOrderAmount}</td>
							<td class="inquiry-count-column">${customer.inquiries.size()}</td>
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
