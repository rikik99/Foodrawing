<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <%@include file="/WEB-INF/include/header.jsp"%>
    <%@include file="/WEB-INF/include/nav.jsp"%>
    <%@include file="/WEB-INF/include/sidebar.jsp"%>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h1>결제 실패</h1>
            </div>
            <div class="card-body">
                <p>결제가 완료되지 못했습니다. </p>
                <a href="/" class="btn btn-primary">홈으로 돌아가기</a>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>
