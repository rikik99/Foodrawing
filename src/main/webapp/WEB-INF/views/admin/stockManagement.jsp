<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/adminProducts.css'/>">
</head>
<body class="dark-mode">
    <div class="dashboard-container">
        <jsp:include page="/WEB-INF/views/admin/layout.jsp" />
        <div class="main-content dark-mode" id="mainContent">
            <h1>재고 관리</h1>

            <!-- 검색창 -->
            <div class="search-bar">
                <div class="full-width">
                    <div class="half-width">
                        <label for="searchInput">검색어</label>
                        <input type="text" placeholder="상품명을 입력하세요" id="searchInput" name="searchInput">
                    </div>
                    <div class="half-width second-layer">
                        <label for="category">카테고리</label>
                        <select id="category" name="category" class="secondary">
                            <option value="">전체</option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="full-width">
                    <div class="date-group">
                        <label for="last_fr_date">최종 수정일</label>
                        <input type="date" name="last_fr_date" id="last_fr_date" placeholder="시작일" class="secondary">
                        <input type="date" name="last_to_date" id="last_to_date" placeholder="종료일" class="secondary">
                        <span class="btn_group">
                            <input type="button" class="btn_small white primary date-range-btn" data-range="today" data-group="last" value="오늘">
                            <input type="button" class="btn_small white primary date-range-btn" data-range="yesterday" data-group="last" value="어제">
                            <input type="button" class="btn_small white primary date-range-btn" data-range="week" data-group="last" value="일주일">
                            <input type="button" class="btn_small white primary date-range-btn" data-range="month" data-group="last" value="1개월">
                            <input type="button" class="btn_small white primary date-range-btn" data-range="3months" data-group="last" value="3개월">
                            <input type="button" class="btn_small white primary date-range-btn" data-range="all" data-group="last" value="전체">
                        </span>
                    </div>
                </div>
                <div class="full-width">
                    <div class="half-width number-group">
                        <label for="stock_min">상품 재고</label>
                        <input type="number" name="stock_min" id="stock_min" placeholder="이상" class="secondary">
                        <input type="number" name="stock_max" id="stock_max" placeholder="이하" class="secondary">
                        <span class="btn_group">
                            <input type="button" class="btn_small white primary stock-range-btn" data-stock="all" value="전체">
                            <input type="button" class="btn_small white primary stock-range-btn" data-stock="out" value="품절">
                            <input type="button" class="btn_small white primary stock-range-btn" data-stock="low" value="부족">
                            <input type="button" class="btn_small white primary stock-range-btn" data-stock="enough" value="여유">
                        </span>
                    </div>
                </div>
                <div class="search-buttons full-width">
                    <button type="button" class="primary search-btn" data-url="/admin/stockManagement">검색</button>
                    <button type="reset" class="secondary">초기화</button>
                </div>
            </div>
            <!-- 재고 목록 -->
            <div class="product-list-header">
                <div>
                    <span>조회된 상품 개수: <strong>${totalElements}</strong>개</span>
                </div>
            </div>
            <table class="product-list dark-mode">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll" class="secondary"></th>
                        <th>이미지</th>
                        <th>상품명(상품 코드, 상품명)</th>
                        <th>카테고리</th>
                        <th>진열 수량</th>
                        <th>재고 수량</th>
                        <th>입/출고</th>
                        <th>최종 수정일</th>
                        <th>판매여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${product.content}" var="product">
                        <tr>
                            <td><input type="checkbox" class="selectProduct secondary"></td>
                            <td><img class="productImg" src="${product.productFileDTO.filePath}" alt="상품 이미지"></td>
                            <td>
                                <p>${product.productNumber}</p>
                                <p>${product.name}</p>
                            </td>
                            <td>${product.productCategoryDTO.name}</td>
                            <td>${product.quantity}</td>
                            <td>${product.stockDTO.quantity}</td>
                            <td>
                                <div class="stock-update-container" data-product-number="${product.productNumber}">
                                    <div class="stock-update-row">
                                        <select class="stock-action">
                                            <option value="IN">입고</option>
                                            <option value="OUT">출고</option>
                                        </select>
                                        <input type="number" class="stock-quantity" placeholder="수량">
                                    </div>
                                    <div class="stock-update-row">
                                        <input type="date" name="expirationDate" class="expirationDate">
                                    </div>
                                    <button class="stock-update-btn">적용</button>
                                </div>
                            </td>
                            <td>${product.stockDTO.formattedLastUpdated}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.salesPostDTO.status == 1}">판매중</c:when>
                                    <c:when test="${product.salesPostDTO.status == 2}">품절</c:when>
                                    <c:when test="${product.salesPostDTO.status == 3}">단종</c:when>
                                    <c:when test="${product.salesPostDTO.status == 4}">중지</c:when>
                                    <c:otherwise>알 수 없음</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:forEach begin="1" end="${pageCount}" var="i">
                        <li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
                            <a class="page-link" data-page="${i - 1}" data-size="${size}" data-url="/admin/stockManagement">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
        <button id="toggleMode" class="primary">Toggle Mode</button>
        <script src="<c:url value='/js/admin/main.js'/>"></script>
        <script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
    </div>
</body>
</html>
