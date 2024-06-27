<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/discountAdd.css" />
<script src="<c:url value='/js/admin/couponForm.js'/>"></script>
</head>
<body class="dark-mode">
	<div class="discount-form-container">
		<form id="insertProductForm" method="post" action="/admin/insertProduct" enctype="multipart/form-data"
			class="insertProductForm">
			<h1>상품 등록</h1>
			<table class="form-table">
				<tr>
					<td><label for="category">상품 카테고리</label></td>
					<td><select id="category" name="category" class="secondary">
							<option value="">전체</option>
							<c:forEach items="${categoryList}" var="category">
								<option value="${category.id}">${category.name}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td><label for="productNumber">상품 코드</label></td>
					<td><input type="text" id="productNumber" name="productNumber"
						required="required" readonly="readonly" value="상품코드"></td>
				</tr>
				<tr>
					<td><label for="name">상품 이름</label></td>
					<td><input type="text" id="name" name="name"
						required="required" value="" placeholder="상품 이름을 입력해주세요.">
					</td>
				</tr>
				<tr>
					<td><label for="price">상품 가격</label></td>
					<td><input type="text" id="price" name="price"
						required="required" value="" placeholder="상품 가격을 입력해주세요."></td>
				</tr>
				<tr>
					<td><label for="quantity">상품 재고</label></td>
					<td><input type="text" id="quantity" name="quantity"
						required="required" value="" placeholder="상품 재고를 입력해주세요."></td>
				</tr>
				<tr>
					<td><label for="file">상품 사진</label></td>
					<td><input type="file" class="form-control" id="file"
						name="file" aria-describedby="profile"></td>
				</tr>
				<tr>
					<td><label for="preview">사진 미리보기</label></td>
					<td><img alt="사진 미리보기" src="/images/FooDrawing_Logo.png" class="previewArea"
						style="height: 120px; width: auto;"></td>
				</tr>
				<tr>
					<td><label for="description">상품 설명</label></td>
					<td><textarea id="description" name="description" required></textarea></td>
				</tr>
				<tr>
					<td colspan="2"><button type="submit" class="primary">상품
							등록</button></td>
				</tr>
			</table>
		</form>
	</div>
	<script src="<c:url value='/js/admin/productNumber.js'/>"></script>
</body>
</html>
