<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>이메일 인증 실패</title>
</head>
<body>
    <h1>이메일 인증 실패</h1>
    <p>${message}</p>
    <a href="/resendVerificationEmail">이메일 재발송</a>
</body>
</html>