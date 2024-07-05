<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<h1>결제 완료 관리</h1>

			<div class="search-bar">
				<div class="full-width">
					<div class="half-width">
						<label for="searchInput">검색어</label> <input type="text"
							class="searchInput" placeholder="고객 아이디 및 이름을 입력해주세요"
							id="searchInput" name="searchInput">
					</div>
				</div>
				<div class="full-width">
					<div class="half-width">
						<label for="paymentType">결제 방법</label>
						<div class="checkbox-group" data-group="paymentType">
							<label><input type="checkbox" class="select-all"
								data-group="paymentType" value="all"> 전체</label> <label><input
								type="checkbox" name="paymentType" value="card"> 카드</label> <label><input
								type="checkbox" name="paymentType" value="phone"> 휴대폰 결제</label>
							<label><input type="checkbox" name="paymentType"
								value="tosspayments">토스 페이먼츠</label> <label><input
								type="checkbox" name="paymentType" value="payco">페이코</label> <label><input
								type="checkbox" name="paymentType" value="kakaopay">카카오페이</label>
							<label><input type="checkbox" name="paymentType"
								value="vbank">가상계좌</label>
						</div>
					</div>
				</div>

				<div class="full-width">
					<div class="half-width">
						<label for="order_fr_date">주문 날짜</label> <input type="date"
							name="order_fr_date" id="order_fr_date" placeholder="시작일"
							class="secondary"> <input type="date"
							name="order_to_date" id="order_to_date" placeholder="종료일"
							class="secondary"> <span class="btn_group"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="today" data-group="order" value="오늘"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="yesterday" data-group="order" value="어제"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="week" data-group="order" value="일주일"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="month" data-group="order" value="1개월"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="3months" data-group="order" value="3개월"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="all" data-group="order" value="전체">
						</span>
					</div>
				</div>
				<div class="search-buttons full-width">
					<button type="button" class="primary search-btn"
						data-url="/admin/paymentCompleted">검색</button>
					<button type="reset" class="secondary">초기화</button>
				</div>
			</div>

			<!-- 주문 목록 -->
			<div class="custom-table-header">
				<div>
					<span>조회된 주문 수: <strong>${totalElements}</strong>개
					</span>
				</div>
				<button id="progressButton" class="primary"
					data-url="/admin/shipping">상태 변경</button>
			</div>
			<table class="custom-table dark-mode" id="orderTable">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" class="secondary"></th>
						<th class="customer-id-column">고객 ID</th>
						<th class="customer-name-column">고객 이름</th>
						<th class="order-id-column">주문 번호</th>
						<th class="order-date-column">주문 날짜</th>
						<th class="customer-name-column">주문 상품</th>
						<th class="customer-name-column">구매 수량</th>
						<th class="customer-name-column">상품 금액</th>
						<th class="order-status-column">주문 상태</th>
						<th class="total-amount-column">총 주문액</th>
						<th class="total-amount-column">결제방법</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orders.content}" var="order">
						<c:forEach items="${order.orderDetailList}" var="details"
							varStatus="status">
							<tr data-orderId="${order.id }" data-progress="${order.orderStatus.orderStatus}">
								<c:if test="${status.first}">
									<td rowspan="${fn:length(order.orderDetailList)}"><input
										type="checkbox" class="selectOrder secondary"></td>
									<td rowspan="${fn:length(order.orderDetailList)}">${order.customer.userDTO.username}</td>
									<td rowspan="${fn:length(order.orderDetailList)}">${order.customer.name}</td>
									<td rowspan="${fn:length(order.orderDetailList)}">${order.orderNumber}</td>
									<td rowspan="${fn:length(order.orderDetailList)}">${order.formattedOrderDate}</td>
								</c:if>
								<td>${details.sales.title}</td>
								<td>${details.quantity}</td>
								<td>${details.unitPrice}</td>
								<c:if test="${status.first}">
									<td rowspan="${fn:length(order.orderDetailList)}">${order.orderStatus.orderStatus}</td>
									<td rowspan="${fn:length(order.orderDetailList)}">${order.totalAmount}</td>
									<td rowspan="${fn:length(order.orderDetailList)}">${order.paymentType}</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:forEach>
				</tbody>
			</table>

			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" data-page="${i - 1}"
							data-url="/admin/discountList" data-size="${size}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
		<script src="<c:url value='/js/admin/setDateRange.js'/>"></script>
	</div>
</body>
</html>
