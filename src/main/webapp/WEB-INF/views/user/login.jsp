<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/login.css' />">
<script src="<c:url value='/js/login.js' />"></script>
</head>
<body>
	<div class="login-container">
		<div class="login-header">
			<h1>로그인</h1>
		</div>
		<c:if test="${param.error != null}">
			<div class="login-error">아이디나 비밀번호가 잘못되었거나 권한이 없습니다.</div>
		</c:if>
		<form action="<c:url value='/login' />" method="post">
			<!-- CSRF Token -->
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />

			<div class="login-input">
				<label for="username">아이디</label> <input type="text" id="username"
					name="username" placeholder="아이디 6-20자" required>
			</div>
			<div class="login-input">
				<label for="password">비밀번호</label> <input type="password"
					id="password" name="password"
					placeholder="비밀번호 영문, 특수문자, 숫자조합 8-12자" required>
			</div>
			<button type="submit" class="login-btn">로그인</button>

			<div class="login-options">
				<label> <input type="checkbox" name="remember-me">
					로그인 유지
				</label>
				<div>
					<a href="<c:url value='/findUsername' />">아이디 찾기</a> | <a
						href="<c:url value='/findPassword' />">비밀번호 찾기</a>
				</div>
			</div>
		</form>

		<div class="login-social">
			<a href="<c:url value='/oauth2/authorization/kakao' />"
				class="social-btn kakao"> <img
				src="<c:url value='/images/kakao_login_large_narrow.png' />"
				alt="카카오 로그인">
			</a> <a href="<c:url value='/oauth2/authorization/naver' />"
				class="social-btn naver"> <img
				src="<c:url value='/images/btnG_완성형.png' />" alt="네이버 로그인">
			</a>
		</div>

		<div class="login-footer">
			<a href="<c:url value='/signup' />" class="signup-btn">회원가입</a> <a
				href="<c:url value='/guestOrder' />" class="guest-order">비회원
				주문배송 조회</a>
			<div class="login-promotion">
				<img src="<c:url value='/images/promotion.png' />" alt="프로모션 이미지">
			</div>
		</div>
	</div>
</body>
</html>
