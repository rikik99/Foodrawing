<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/findUsername.css' />">
</head>
<body>
	<div>
		<h2>비밀번호 재설정</h2>
		<div class="container">
			<form action="<c:url value='/passwordReset' />" method="post">
				<input type="hidden" name="email" value="${email}"> <label
					for="newPassword">새 비밀번호</label> <input type="password"
					id="newPassword" name="newPassword" required> <label
					for="confirmPassword">비밀번호 확인</label> <input type="password"
					id="confirmPassword" name="confirmPassword" required>
				<button type="submit">비밀번호 재설정</button>
			</form>
		</div>
	</div>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			var newPasswordInput = document.getElementById('newPassword');
			var confirmPasswordInput = document
					.getElementById('confirmPassword');
			var submitButton = document.querySelector('button[type="submit"]');

			function validatePasswords() {
				if (newPasswordInput.value === confirmPasswordInput.value) {
					submitButton.disabled = false;
				} else {
					submitButton.disabled = true;
				}
			}

			newPasswordInput.addEventListener('input', validatePasswords);
			confirmPasswordInput.addEventListener('input', validatePasswords);
		});
	</script>
</body>
</html>
