<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/adminLogin.css' />">
</head>
<body>
        <%@ include file="/WEB-INF/views/admin/adminMain.jsp"%>
    <div class="login-overlay">
        <div class="login-container">
            <div class="login-header">
                <h1>Admin Login</h1>
            </div>
            <c:if test="${param.error != null}">
                <div class="error">Invalid username or password.</div>
            </c:if>
            <form action="<c:url value='/admin/login' />" method="post">
                <div class="login-input">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required>
                </div>
                <div class="login-input">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="login-btn">Login</button>
            </form>
            <div class="login-footer">
                <a href="/forgot-password">Forgot Password?</a>
            </div>
        </div>
    </div>
</body>
</html>
