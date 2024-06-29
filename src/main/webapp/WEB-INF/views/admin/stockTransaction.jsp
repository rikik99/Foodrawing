<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/adminTransaction.css'/>">
</head>
<body class="dark-mode">
    <div class="dashboard-container">
        <jsp:include page="/WEB-INF/views/admin/layout.jsp" />
        <div class="main-content dark-mode" id="mainContent">
            <h1>입출고 목록</h1>
            <div class="product-list-header">
                <div>
                    <span>조회된 상품 개수: <strong>${totalElements}</strong>개</span>
                </div>
            </div>
            <table class="product-list dark-mode">
                <thead>
                    <tr>
                        <th>이미지</th>
                        <th class="sortable" data-column="PRODUCT_NUMBER" data-sort="${sort.startsWith('product,') ? sort.split(',')[1] : '-'}">상품명(상품 코드, 상품명)
                            <span class="sort-icon default">-</span>
                            <span class="sort-icon asc">▲</span>
                            <span class="sort-icon desc">▼</span>
                        </th>
                        <th class="sortable" data-column="TRANSACTION_TYPE" data-sort="${sort.startsWith('transactionType,') ? sort.split(',')[1] : '-'}">입/출고
                            <span class="sort-icon default">-</span>
                            <span class="sort-icon asc">▲</span>
                            <span class="sort-icon desc">▼</span>
                        </th>
                        <th class="sortable" data-column="QUANTITY" data-sort="${sort.startsWith('quantity,') ? sort.split(',')[1] : '-'}">수량
                            <span class="sort-icon default">-</span>
                            <span class="sort-icon asc">▲</span>
                            <span class="sort-icon desc">▼</span>
                        </th>
                        <th class="sortable" data-column="TRANSACTION_DATE" data-sort="${sort.startsWith('TRANSACTION_DATE,') ? sort.split(',')[1] : '-'}">입출고 날짜
                            <span class="sort-icon default">-</span>
                            <span class="sort-icon asc">▲</span>
                            <span class="sort-icon desc">▼</span>
                        </th>
                        <th class="sortable" data-column="EXPIRATION_DATE" data-sort="${sort.startsWith('expirationDate,') ? sort.split(',')[1] : '-'}">유통 기한
                            <span class="sort-icon default">-</span>
                            <span class="sort-icon asc">▲</span>
                            <span class="sort-icon desc">▼</span>
                        </th>
                    </tr>
                </thead>
                <tbody id="stockTableBody">
                    <c:forEach items="${transaction}" var="transaction">
                        <tr>
                            <td><img class="productImg" src="${transaction.productFileDTO.filePath}" alt="상품 이미지"></td>
                            <td><p>${transaction.productNumber}</p><p>${transaction.productDTO.name}</p></td>
                            <td><c:choose>
                                    <c:when test="${fn:trim(transaction.transactionType) == 'IN'}">입고</c:when>
                                    <c:when test="${fn:trim(transaction.transactionType) == 'OUT'}">출고</c:when>
                                    <c:otherwise>알 수 없음</c:otherwise>
                                </c:choose></td>
                            <td>${transaction.quantity}</td>
                            <td>${transaction.transactionDate}</td>
                            <td>${transaction.expirationDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:forEach begin="1" end="${pageCount}" var="i">
                        <li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
                            <a class="page-link" data-page="${i - 1}" data-size="${size}" data-url="/admin/stockTransaction">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
        <button id="toggleMode" class="primary">Toggle Mode</button>
        <script src="<c:url value='/js/admin/main.js'/>"></script>
        <script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
        <script src="<c:url value='/js/admin/sortTable.js'/>"></script>
    </div>
</body>
</html>
