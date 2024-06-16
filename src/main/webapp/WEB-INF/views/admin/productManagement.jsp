<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/admin/common.css'/>">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/admin/adminProducts.css'/>">
</head>
<body>
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>상품 관리</h1>

			<!-- 검색창 -->
			<form name="fsearch" id="fsearch" method="get">
    <div class="search-bar">
        <div class="full-width">
            <div class="half-width">
                <label for="searchInput">검색어</label>
                <input type="text" placeholder="상품명을 입력하세요" id="searchInput" name="searchInput">
            </div>
            <div class="half-width">
                <label for="category">카테고리</label>
                <select id="category" name="category">
                    <option value="">전체</option>
                    <option value="001">패션의류/잡화/뷰티</option>
                    <option value="002">식품/생필품</option>
                    <option value="003">출산/유아동</option>
                    <option value="004">생활/건강</option>
                    <option value="005">가구/인테리어</option>
                    <option value="006">가전/디지털/컴퓨터</option>
                    <option value="007">스포츠/레저/자동차/공구</option>
                    <option value="008">도서/여행/e쿠폰/취미</option>
                </select>
            </div>
        </div>
        <div class="full-width">
            <label for="fr_date">기간 검색</label>
            <div class="date-group">
                <input type="date" name="fr_date" id="fr_date" placeholder="시작일">
                <input type="date" name="to_date" id="to_date" placeholder="종료일">
                <span class="btn_group">
                    <input type="button" onclick="setDateRange('today');" class="btn_small white" value="오늘">
                    <input type="button" onclick="setDateRange('yesterday');" class="btn_small white" value="어제">
                    <input type="button" onclick="setDateRange('week');" class="btn_small white" value="일주일">
                    <input type="button" onclick="setDateRange('month');" class="btn_small white" value="1개월">
                    <input type="button" onclick="setDateRange('3months');" class="btn_small white" value="3개월">
                    <input type="button" onclick="setDateRange('all');" class="btn_small white" value="전체">
                </span>
            </div>
        </div>
        <div class="full-width">
            <div class="half-width number-group">
                <label for="stock_min">상품 재고</label>
                <input type="number" name="stock_min" id="stock_min" placeholder="이상">
                <input type="number" name="stock_max" id="stock_max" placeholder="이하">
            </div>
            <div class="half-width number-group">
                <label for="price_min">판매 가격</label>
                <input type="number" name="price_min" id="price_min" placeholder="이상">
                <input type="number" name="price_max" id="price_max" placeholder="이하">
            </div>
        </div>
        <div class="full-width">
            <div class="half-width number-group">
                <label for="cost_min">원가 가격</label>
                <input type="number" name="cost_min" id="cost_min" placeholder="이상">
                <input type="number" name="cost_max" id="cost_max" placeholder="이하">
            </div>
            <div class="half-width">
                <label>판매 여부</label>
                <div>
                    <label><input type="radio" name="sale_status" value="" checked> 전체</label>
                    <label><input type="radio" name="sale_status" value="sale"> 판매중</label>
                    <label><input type="radio" name="sale_status" value="soldout"> 품절</label>
                    <label><input type="radio" name="sale_status" value="discontinued"> 단종</label>
                    <label><input type="radio" name="sale_status" value="stopped"> 중지</label>
                </div>
            </div>
        </div>
        <div class="search-buttons full-width">
            <button type="submit">검색</button>
            <button type="reset">초기화</button>
        </div>
    </div>
</form>

			<!-- 상품 목록 -->
			<div class="product-list-header">
				<div>
					<span>조회된 상품 개수: <strong>10</strong>개
					</span>
				</div>
				<div>
					<button id="deleteSelectedButton">선택삭제</button>
				</div>
			</div>
			<table class="product-list">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>이미지</th>
						<th>상품 코드</th>
						<th>상품명</th>
						<th>카테고리</th>
						<th>등록일</th>
						<th>재고</th>
						<th>가격</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" class="selectProduct"></td>
						<td><img src="http://example.com/image1.jpg" alt="상품1 이미지"></td>
						<td>001</td>
						<td>상품 1</td>
						<td>카테고리 1</td>
						<td>2024-06-17</td>
						<td>50</td>
						<td>₩10,000</td>
						<td><button class="editButton">수정</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" class="selectProduct"></td>
						<td><img src="http://example.com/image2.jpg" alt="상품2 이미지"></td>
						<td>002</td>
						<td>상품 2</td>
						<td>카테고리 2</td>
						<td>2024-06-18</td>
						<td>30</td>
						<td>₩20,000</td>
						<td><button class="editButton">수정</button></td>
					</tr>
				</tbody>
			</table>
		</div>
		<button id="toggleMode">Toggle Mode</button>
		<script src="<c:url value='/js/adminMain.js'/>"></script>
		<script>
        function setDateRange(range) {
            var today = new Date();
            var fromDate, toDate;
            switch (range) {
                case 'today':
                    fromDate = toDate = today.toISOString().split('T')[0];
                    break;
                case 'yesterday':
                    fromDate = toDate = new Date(today.setDate(today.getDate() - 1)).toISOString().split('T')[0];
                    break;
                case 'week':
                    fromDate = new Date(today.setDate(today.getDate() - 7)).toISOString().split('T')[0];
                    toDate = new Date().toISOString().split('T')[0];
                    break;
                case 'month':
                    fromDate = new Date(today.setMonth(today.getMonth() - 1)).toISOString().split('T')[0];
                    toDate = new Date().toISOString().split('T')[0];
                    break;
                case '3months':
                    fromDate = new Date(today.setMonth(today.getMonth() - 3)).toISOString().split('T')[0];
                    toDate = new Date().toISOString().split('T')[0];
                    break;
                case 'all':
                    fromDate = toDate = '';
                    break;
            }
            document.getElementById("fr_date").value = fromDate;
            document.getElementById("to_date").value = toDate;
        }

        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('selectAll').addEventListener('change', function () {
                const checkboxes = document.querySelectorAll('.selectProduct');
                checkboxes.forEach(checkbox => checkbox.checked = this.checked);
            });

            document.getElementById('fsearch').addEventListener('reset', function () {
                document.querySelectorAll('input[type="text"], input[type="date"], input[type="number"]').forEach(input => input.value = '');
                document.querySelectorAll('select').forEach(select => select.selectedIndex = 0);
                document.querySelector('input[type="radio"][value=""]').checked = true;
            });
        });
    </script>
	</div>

</body>
</html>
