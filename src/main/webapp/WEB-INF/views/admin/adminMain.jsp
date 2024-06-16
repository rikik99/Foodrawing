<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/adminMain.css'/>">
</head>
<body>
	<div class="dashboard-container">

		<%@ include file="/WEB-INF/views/admin/layout.jsp"%>
		<div class="main-content" id="mainContent">
			<h1>관리자 메인 페이지</h1>
			<p>여기에 메인 페이지 내용이 있습니다.</p>
		</div>
		<button id="toggleMode">Toggle Mode</button>
		<script src="<c:url value='/js/adminMain.js'/>"></script>
	</div>
</body>
</html>
