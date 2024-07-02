<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/targetAdd.css" />
</head>

<body class="dark-mode">
	<div class="discount-form-container">
		<form id="insertDiscountForm" method="post"
			action="/admin/insertDiscountTarget" class="discount-form">
			<h1>할인 대상 수정</h1>
			<table class="form-table">
				<tr>
					<td><label for="discountId">할인 대상 목록</label></td>
					<td><select id="targetType" name="targetType"
						class="targetType">
							<option value="MODU">모두</option>
							<option value="ALL">전체</option>
							<option value="PRODUCT">상품</option>
							<option value="MEMBER_RATING">회원 등급</option>
							<option value="CATEGORY">카테고리</option>
					</select></td>
				</tr>

			</table>
			<div class="form-container">
				<div class="discountTargetList">
					<table class="discount-table product-list dark-mode">
						<thead>
							<tr>
								<th class="discount-name-column">할인명</th>
								<th class="discount-target-column">할인 종류</th>
								<th class="discount-targetType-column">할인 대상</th>
								<th class="discount-targetId-column">대상 이름</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${discounts.content}" var="discounts">
								<tr data-discountId=${discounts.id }>
									<td class="discount-name-column"><input
										value="${discounts.discountDTO.name}" readonly="readonly"></td>
									<td class="discount-category-column">${discounts.discountDTO.type}</td>
									<td class="discount-targetType-column"><select
										id="targetType" name="targetType" class="targetType">
											<option value="ALL">전체</option>
											<option value="PRODUCT">상품</option>
											<option value="MEMBER_RATING">회원 등급</option>
											<option value="CATEGORY">카테고리</option>
									</select></td>
									<td class="discount-targetId-column"><input type="text"
										value="${discounts.targetName}" required="required"></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<button type="submit" class="primary">등록</button>
		</form>
	</div>

	<nav aria-label="Page navigation">
		<ul class="pagination">
			<c:forEach begin="1" end="${pageCount}" var="i">
				<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
					<a class="page-link" href="javascript:void(0);"
					data-page="${i - 1}" data-url="/admin/discountList"
					data-size="${size}">${i}</a>
				</li>
			</c:forEach>
		</ul>
	</nav>
</body>

</html>