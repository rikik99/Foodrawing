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
                        <th class="sortable" data-column="product" data-type="string" data-sort="${sort eq 'product,asc' ? 'asc' : (sort eq 'product,desc' ? 'desc' : '-')}">상품명(상품 코드, 상품명)<span class="sort-icon default">-</span><span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="transactionType" data-type="string" data-sort="${sort eq 'transactionType,asc' ? 'asc' : (sort eq 'transactionType,desc' ? 'desc' : '-')}">입/출고<span class="sort-icon default">-</span><span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="quantity" data-type="number" data-sort="${sort eq 'quantity,asc' ? 'asc' : (sort eq 'quantity,desc' ? 'desc' : '-')}">수량<span class="sort-icon default">-</span><span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="transactionDate" data-type="date" data-sort="${sort eq 'transactionDate,asc' ? 'asc' : (sort eq 'transactionDate,desc' ? 'desc' : '-')}">입출고 날짜<span class="sort-icon default">-</span><span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="expirationDate" data-type="date" data-sort="${sort eq 'expirationDate,asc' ? 'asc' : (sort eq 'expirationDate,desc' ? 'desc' : '-')}">유통 기한<span class="sort-icon default">-</span><span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                    </tr>
                </thead>
                <tbody id="stockTableBody">
                    <c:forEach items="${transaction.content}" var="transaction">
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
