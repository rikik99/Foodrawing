<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 관리</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/common.css">
<style>
.main-content {
    margin-left: 220px;
    padding: 20px;
}

h1 {
    text-align: center;
    margin-bottom: 20px;
}

.form-group {
    text-align: center;
    margin-bottom: 20px;
}

.form-group label, .form-group input, .form-group button {
    display: inline-block;
    margin: 0 10px;
}

.form-group input, .form-group button {
    width: auto;
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
    text-align: center;
}

th {
    background-color: #f8f9fa;
}

.btn-group {
    display: flex;
    justify-content: center;
    gap: 10px;
}
</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/header.jsp"%>
    <%@ include file="/WEB-INF/include/nav.jsp"%>
    <%@ include file="/WEB-INF/include/mypageSidebar.jsp"%>
    <div class="main-content">
        <h1>주문 취소/교환/반품</h1>
        <form action="/user/myPageOrderCancel" method="get" class="form-group">
            <label for="startDate">시작 날짜:</label> 
            <input type="date" id="startDate" name="startDate" required> 
            <label for="endDate">종료 날짜:</label> 
            <input type="date" id="endDate" name="endDate" required>
            <button type="submit" class="btn btn-primary mt-2">검색</button>
        </form>
        <c:if test="${not empty orders}">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th>주문 번호</th>
                            <th>주문 날짜</th>
                            <th>상태</th>
                            <th>총 금액</th>
                            <th>할인 금액</th>
                            <th>수량</th>
                            <th>작업</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
                                <td>${order.orderStatus}</td>
                                <td>${order.totalAmount}</td>
                                <td>${order.discountPrice}</td>
                                <td>${order.quantity}</td>
                                <td>
                                    <div class="btn-group">
                                        <form id="cancelForm_${order.orderId}" class="status-form" action="${pageContext.request.contextPath}/user/updateOrderStatus" method="post">
                                            <input type="hidden" name="orderId" value="${order.orderId}" />
                                            <input type="hidden" name="status" value="Cancelled" />
                                            <button type="button" class="btn btn-danger" onclick="confirmCancel(${order.orderId})">취소</button>
                                        </form>
                                        <form id="returnForm_${order.orderId}" class="status-form" action="${pageContext.request.contextPath}/user/updateOrderStatus" method="post">
                                            <input type="hidden" name="orderId" value="${order.orderId}" />
                                            <input type="hidden" name="status" value="Returned" />
                                            <button type="button" class="btn btn-warning" onclick="confirmReturn(${order.orderId})">반품</button>
                                        </form>
                                        <form id="exchangeForm_${order.orderId}" class="status-form" action="${pageContext.request.contextPath}/user/updateOrderStatus" method="post">
                                            <input type="hidden" name="orderId" value="${order.orderId}" />
                                            <input type="hidden" name="status" value="Exchanged" />
                                            <button type="button" class="btn btn-info" onclick="confirmExchange(${order.orderId})">교환</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${empty orders}">
            <p>주문이 없습니다.</p>
        </c:if>
    </div>
    <%@ include file="/WEB-INF/include/footer.jsp"%>
<script>
function confirmCancel(orderId) {
    if (confirm('상품을 취소하시겠습니까?')) {
        document.getElementById('cancelForm_' + orderId).submit();
    }
}

function confirmReturn(orderId) {
    if (confirm('상품을 반품하시겠습니까?')) {
        document.getElementById('returnForm_' + orderId).submit();
    }
}

function confirmExchange(orderId) {
    if (confirm('상품을 교환하시겠습니까?')) {
        document.getElementById('exchangeForm_' + orderId).submit();
    }
}
</script>
</body>
</html>
