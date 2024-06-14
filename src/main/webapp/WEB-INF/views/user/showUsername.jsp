<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 결과</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F5F5F5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .username {
            font-size: 24px;
            font-weight: bold;
            color: #007BFF;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>아이디 찾기 결과</h1>
        <p>회원님의 아이디는 다음과 같습니다:</p>
        <div class="username">${userId}</div>
        <a href="/login" class="btn">로그인 페이지로 이동</a>
    </div>
</body>
</html>
