<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비회원 주문 정보 찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/common.css"/>
    <link rel="stylesheet" href="/css/sidebar.css"/>
</head>
<body>
    <%@include file="/WEB-INF/include/header.jsp"%>
    <%@include file="/WEB-INF/include/nav.jsp"%>
    <%@include file="/WEB-INF/include/sidebar.jsp"%>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h1>비회원 주문 정보 찾기</h1>
            </div>
            <form action="/guest/myOrder" method="post" class="card-body">
                <div class="mb-3">
                    <label for="orderNumber" class="form-label">주문 번호</label>
                    <input type="text" class="form-control" id="orderNumber" name="orderNumber" required>
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">주문자 이름</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <button type="submit" class="btn btn-primary">주문 정보 찾기</button>
                <a class="btn btn-primary" href="/mainpage?category=11">홈으로</a>
            </form>
        </div>
    </div>
    <%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>
