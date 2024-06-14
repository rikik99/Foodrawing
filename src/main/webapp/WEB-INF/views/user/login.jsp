<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<script src="<c:url value='/js/login.js' />"></script>
</head>
<body>
	<div class="login-main">
		<%@ include file="/WEB-INF/views/user/loginContent.jsp"%>
	</div>
</body>
</html>