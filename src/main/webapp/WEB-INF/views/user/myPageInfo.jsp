<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${customer.name}님의 개인정보 수정</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<%@ include file="/WEB-INF/include/header.jsp"%>
<%@ include file="/WEB-INF/include/nav.jsp"%>
<%@ include file="/WEB-INF/include/mypageSidebar.jsp"%>
<style>
body {
	font-family: Arial, sans-serif;
}

.main-content {
	margin-left: 220px;
	padding: 20px;
	position: relative;
}

.content {
	text-align: center;
	padding: 20px;
}

.profile-img {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	object-fit: cover;
	margin: 0 auto;
	display: block;
}

h1 {
	text-align: center;
}

.form-group {
	margin-bottom: 20px;
	text-align: center;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
}

.form-group input, .form-group select {
	width: 50%;
	padding: 10px;
	margin: 0 auto;
	display: block;
	border: 1px solid #ced4da;
	border-radius: 4px;
}

.form-group input[readonly] {
	background-color: #e9ecef;
}

.btn-container {
	text-align: center;
	margin-top: 20px;
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	margin: 5px;
	color: #fff;
	background-color: #007bff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	text-decoration: none;
}

.btn-secondary {
	background-color: #6c757d;
}
</style>
</head>
<body>
	<div class="main-content">
		<h1>${customer.name}님의 개인정보 수정</h1>
		<form action="/customer/update" method="POST">
			<div class="form-group">
				<label for="id">ID</label> <input type="text" id="id" name="id"
					value="${customer.id}" readonly>
			</div>
			<div class="form-group">
				<label for="userId">USER_ID</label> <input type="text" id="userId"
					name="userId" value="${customer.userId}" readonly>
			</div>
			<div class="form-group">
				<label for="nickname">닉네임</label> <input type="text" id="nickname"
					name="nickname" value="${customer.nickname}">
			</div>
			<div class="form-group">
				<label for="name">이름</label> <input type="text" id="name"
					name="name" value="${customer.name}">
			</div>
			<div class="form-group">
				<label for="gender">성별</label> <input type="text" id="gender"
					name="gender" value="${customer.gender}">
			</div>
			<div class="form-group">
				<label for="phone">전화번호</label> <input type="text" id="phone"
					name="phone" value="${customer.phone}">
			</div>
			<div class="form-group">
				<label for="email">이메일</label> <input type="email" id="email"
					name="email" value="${customer.email}">
			</div>
			<div class="form-group">
				<label for="birthDate">생년월일</label> <input type="date"
					id="birthDate" name="birthDate"
					value="<fmt:formatDate value='${customer.birthDate}' pattern='yyyy-MM-dd' />">
			</div>
			<div class="form-group">
				<label for="address">주소</label> <input type="text" id="address"
					name="address" value="${customer.address}">
			</div>
			<div class="form-group">
				<label for="addressDetail">상세주소</label> <input type="text"
					id="addressDetail" name="addressDetail"
					value="${customer.addressDetail}">
			</div>
			<div class="form-group">
				<label for="zipcode">우편번호</label> <input type="text" id="zipcode"
					name="zipcode" value="${customer.zipcode}">
			</div>
			<div class="form-group">
				<label for="refundAccount">환불계좌</label> <input type="text"
					id="refundAccount" name="refundAccount"
					value="${customer.refundAccount}">
			</div>
			<div class="form-group">
				<label for="refundBank">환불계좌 은행</label> <select id="refundBank"
					name="refundBank">
					<option value="국민은행"
						${customer.refundBank == '국민은행' ? 'selected' : ''}>국민은행</option>
					<option value="신한은행"
						${customer.refundBank == '신한은행' ? 'selected' : ''}>신한은행</option>
					<option value="카카오뱅크"
						${customer.refundBank == '카카오뱅크' ? 'selected' : ''}>카카오뱅크</option>
					<option value="제주은행"
						${customer.refundBank == '제주은행' ? 'selected' : ''}>제주은행</option>
					<option value="하나은행"
						${customer.refundBank == '하나은행' ? 'selected' : ''}>하나은행</option>
					<option value="우리은행"
						${customer.refundBank == '우리은행' ? 'selected' : ''}>우리은행</option>
					<option value="토스뱅크"
						${customer.refundBank == '토스뱅크' ? 'selected' : ''}>토스뱅크</option>
				</select>
			</div>
			<div class="btn-container">
				<input type="submit" class="btn" value="수정">
				<button type="button" id="goMypage" class="btn btn-secondary">뒤로</button>
				<form action="/customer/delete" method="POST"
					style="display: inline;">
					<input type="hidden" name="id" value="${customer.id}"> <input
						type="submit" class="btn btn-danger" value="회원탈퇴">
				</form>
			</div>
		</form>
	</div>

	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>
