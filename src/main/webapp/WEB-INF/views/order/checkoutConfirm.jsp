<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 확인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <%@include file="/WEB-INF/include/header.jsp"%>
    <%@include file="/WEB-INF/include/sidebar.jsp"%>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h1>결제 확인</h1>
            </div>
            <div class="card-body">
                <p>입력한 결제 정보와 배송지 정보를 확인하세요.</p>
                <ul class="list-group">
                    <li class="list-group-item"><strong>카드 번호:</strong> <c:out value="${cardNumber}"/></li>
                    <li class="list-group-item"><strong>유효 기간:</strong> <c:out value="${expiryDate}"/></li>
                    <li class="list-group-item"><strong>CVV:</strong> <c:out value="${cvv}"/></li>
                    <li class="list-group-item"><strong>배송지 주소:</strong> <c:out value="${address}"/></li>
                </ul>
                <form action="/checkoutComplete" method="post" class="mt-3">
                    <input type="hidden" name="cardNumber" value="${cardNumber}">
                    <input type="hidden" name="expiryDate" value="${expiryDate}">
                    <input type="hidden" name="cvv" value="${cvv}">
                    <input type="hidden" name="address" value="${address}">
                    <button type="submit" class="btn btn-success">결제 완료</button>
                </form>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>
