<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
            <!-- 재고 목록 -->
            <div class="product-list-header">
                <div>
                    <span>조회된 상품 개수: <strong>10</strong>개</span>
                </div>
            </div>
            <table class="product-list dark-mode">
                <thead>
                    <tr>
                        <th>이미지</th>
                        <th class="sortable" data-column="product">상품명(상품 코드, 상품명)<span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="type">입/출고<span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="quantity">수량<span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="date">입출고 날짜<span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                        <th class="sortable" data-column="expiration">유통 기한<span class="sort-icon asc">▲</span><span class="sort-icon desc">▼</span></th>
                    </tr>
                </thead>
                <tbody id="stockTableBody">
                    <tr>
                        <td><img src="http://example.com/image1.jpg" alt="상품1 이미지" width="50" height="50"></td>
                        <td data-column="product" data-type="string">001, 상품 1</td>
                        <td data-column="type" data-type="string">입고</td>
                        <td data-column="quantity" data-type="number">10</td>
                        <td data-column="date" data-type="date">2024-06-17</td>
                        <td data-column="expiration" data-type="date">2024-06-30</td>
                    </tr>
                    <tr>
                        <td><img src="http://example.com/image2.jpg" alt="상품2 이미지" width="50" height="50"></td>
                        <td data-column="product" data-type="string">002, 상품 2</td>
                        <td data-column="type" data-type="string">출고</td>
                        <td data-column="quantity" data-type="number">5</td>
                        <td data-column="date" data-type="date">2024-06-18</td>
                        <td data-column="expiration" data-type="date">2024-06-30</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <button id="toggleMode" class="primary">Toggle Mode</button>
        <script src="<c:url value='/js/adminMain.js'/>"></script>
    </div>
</body>
</html>
