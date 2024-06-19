<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/adminSales.css" />
<style type="text/css">
.product-list .title-column {
    width: 150px; /* Adjust the width as needed */
}

.product-list .product-name-column {
    width: 150px; /* Adjust the width as needed */
}

.product-list .customer-id-column {
    width: 100px; /* Adjust the width as needed */
}

.product-list .inquiry-content-column {
    width: 300px; /* Adjust the width as needed */
    word-wrap: break-word;
    white-space: normal; /* Ensure text wraps within the cell */
}

.product-list .inquiry-date-column {
    width: 150px; /* Adjust the width as needed */
}

.product-list .status-column {
    width: 100px; /* Adjust the width as needed */
}

</style>
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>판매글 문의 관리</h1>

			<!-- 검색창 -->
			<form name="fsearch" id="fsearch" method="get">
				<div class="search-bar">
					<div class="full-width">
						<div class="half-width">
							<label for="searchInput">검색어</label> <input type="text" class="searchInput"
								placeholder="제목, 상품명, 작성자를 입력하세요" id="searchInput" name="searchInput">
						</div>
					</div>
					
					<div class="full-width dark-mode">
						<div class="date-group">
							<label for="fr_date">등록일</label> <input type="date"
								name="fr_date" id="fr_date" placeholder="시작일" class="secondary">
							<input type="date" name="to_date" id="to_date" placeholder="종료일"
								class="secondary"> <span class="btn_group"> <input
								type="button" onclick="setDateRange('today', 'register');"
								class="btn_small white primary" value="오늘"> <input
								type="button" onclick="setDateRange('yesterday', 'register');"
								class="btn_small white primary" value="어제"> <input
								type="button" onclick="setDateRange('week', 'register');"
								class="btn_small white primary" value="일주일"> <input
								type="button" onclick="setDateRange('month', 'register');"
								class="btn_small white primary" value="1개월"> <input
								type="button" onclick="setDateRange('3months', 'register');"
								class="btn_small white primary" value="3개월"> <input
								type="button" onclick="setDateRange('all', 'register');"
								class="btn_small white primary" value="전체">
							</span>
						</div>
					</div>
					<div class="full-width">
						<div class="half-width">
							<label for="radio-group">해결 상태</label>
							<div id="radio-group">
								<label><input type="radio" name="resolved_status" value=""
									checked> 전체</label> <label><input type="radio"
									name="resolved_status" value="N"> 답변 대기 중</label> <label><input
									type="radio" name="resolved_status" value="Y"> 답변 완료</label>
							</div>
						</div>

					</div>
					<div class="search-buttons full-width">
						<button type="submit" class="primary">검색</button>
						<button type="reset" class="secondary">초기화</button>
					</div>
				</div>
			</form>

			<!-- 상품 목록 -->
			<div class="product-list-header">
				<div>
					<span>조회된 판매글 수: <strong>10</strong>개
					</span>
				</div>
				<div class="search-buttons">
					<button id="deleteSelectedButton" class="danger">선택 삭제</button>
					<button id="addSalesButton" class="primary">판매글 등록</button>
				</div>
			</div>
<table class="product-list dark-mode">
    <thead>
        <tr>
            <th class="title-column">판매글 제목</th>
            <th class="product-name-column">상품 이름</th>
            <th class="customer-id-column">고객 아이디</th>
            <th class="inquiry-content-column">문의 내용</th>
            <th class="inquiry-date-column">문의 날짜</th>
            <th class="status-column">해결 상태</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="title-column">판매글 제목 1</td>
            <td class="product-name-column">상품 제목1</td>
            <td class="customer-id-column">tester01</td>
            <td class="inquiry-content-column">4월 29일에 주문한 제품이 아직도 도착을 안하고 있습니다. 주문 누락인가요? 빠른 처리 바랍니다.</td>
            <td class="inquiry-date-column">2024-06-15</td>
            <td class="status-column">답변 대기중</td>
        </tr>
        <tr>
            <td class="title-column">판매글 제목 2</td>
            <td class="product-name-column">상품 제목 2</td>
            <td class="customer-id-column">tester02</td>
            <td class="inquiry-content-column">4월 29일에 주문한 제품이 아직도 도착을 안하고 있습니다. 주문 누락인가요? 빠른 처리 바랍니다.</td>
            <td class="inquiry-date-column">2024-06-15</td>
            <td class="status-column">답변 완료</td>
        </tr>
    </tbody>
</table>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/adminMain.js'/>"></script>
	</div>
</body>
</html>
