<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/배송 조회</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/common.css">
<%@ include file="/WEB-INF/include/header.jsp"%>
<%@ include file="/WEB-INF/include/nav.jsp"%>
<%@ include file="/WEB-INF/include/mypageSidebar.jsp"%>
<style>
body {
    font-family: Arial, sans-serif;
}

.main-content {
    margin-left: 220px;
    padding: 20px;
    position: relative;
}

.content {
    text-align: center;
    padding: 20px;
}

h1 {
    text-align: center;
}

.form-group {
    margin-bottom: 20px;
    text-align: center;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
}

.form-group input, .form-group button {
    width: 50%;
    padding: 10px;
    margin: 0 auto;
    display: block;
    border: 1px solid #ced4da;
    border-radius: 4px;
}

.table-responsive {
    margin-top: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 8px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}
</style>
</head>
<body>
<div class="main-content">
    <h1>주문/배송 조회</h1>
    <div class="content">
        <form action="/user/myPageOrder" method="get" class="form-group">
            <label for="startDate">시작 날짜:</label>
            <input type="date" id="startDate" name="startDate" required>
            
            <label for="endDate">종료 날짜:</label>
            <input type="date" id="endDate" name="endDate" required>
            
            <button type="submit" class="btn btn-primary mt-2">검색</button>
        </form>
        
        <div class="table-responsive">
            <c:if test="${not empty orders}">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>주문 번호</th>
                            <th>주문 날짜</th>
                            <th>상태</th>
                            <th>총 금액</th>
                            <th>단가</th>
                            <th>할인 금액</th>
                            <th>수량</th>
                            <th>배송 상태</th>
                            <th>운송 업체</th>
                            <th>운송장 번호</th>
                            <th>예상 도착 날짜</th>
                            <th>구매 확정</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
                                <td>${order.orderStatus}</td>
                                <td>${order.totalAmount}</td>
                                <td>${order.unitPrice}</td>
                                <td>${order.discountPrice}</td>
                                <td>${order.quantity}</td>
                                <td>${order.deliveryStatus}</td>
                                <td>${order.carrier}</td>
                                <td>${order.trackingNumber}</td>
                                <td><fmt:formatDate value="${order.estimatedArrivalDate}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <c:if test="${order.orderStatus == '결제완료'}">
                                        <form action="${pageContext.request.contextPath}/user/confirmOrder" method="post">
                                            <input type="hidden" name="orderId" value="${order.orderId}" />
                                            <button type="submit" class="btn btn-success">구매 확정</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${order.orderStatus == '구매확정'}">
                                        구매 확정됨
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty orders}">
                <p>주문이 없습니다.</p>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>
