<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/adminSalesInquiries.css" />

</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>판매글 리뷰 관리</h1>

			<!-- 검색창 -->
<form name="fsearch" id="fsearch" method="get">
    <div class="search-bar">
        <div class="full-width">
            <div class="half-width">
                <label for="searchInput">검색어</label>
                <input type="text" class="searchInput" placeholder="제목, 상품명, 작성자를 입력하세요" id="searchInput" name="searchInput">
            </div>
        </div>

        <div class="full-width dark-mode">
            <div class="date-group">
                <label for="fr_date">등록일</label>
                <input type="date" name="fr_date" id="fr_date" placeholder="시작일" class="secondary">
                <input type="date" name="to_date" id="to_date" placeholder="종료일" class="secondary">
                <span class="btn_group">
                    <input type="button" onclick="setDateRange('today', 'register');" class="btn_small white primary" value="오늘">
                    <input type="button" onclick="setDateRange('yesterday', 'register');" class="btn_small white primary" value="어제">
                    <input type="button" onclick="setDateRange('week', 'register');" class="btn_small white primary" value="일주일">
                    <input type="button" onclick="setDateRange('month', 'register');" class="btn_small white primary" value="1개월">
                    <input type="button" onclick="setDateRange('3months', 'register');" class="btn_small white primary" value="3개월">
                    <input type="button" onclick="setDateRange('all', 'register');" class="btn_small white primary" value="전체">
                </span>
            </div>
        </div>
        <div class="full-width">
            <div class="half-width">
                <label for="rating">평점</label>
                <div class="star-rating">
                    <span class="star" data-value="1">&#9733;</span>
                    <span class="star" data-value="2">&#9733;</span>
                    <span class="star" data-value="3">&#9733;</span>
                    <span class="star" data-value="4">&#9733;</span>
                    <span class="star" data-value="5">&#9733;</span>
                </div>
                <input type="hidden" id="rating" name="rating" value="">
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
					<tr class="toggle-row">
						<td class="title-column">판매글 제목 1</td>
						<td class="product-name-column">상품 제목1</td>
						<td class="customer-id-column">tester01</td>
						<td class="inquiry-content-column">4월 29일에 주문한 제품이 아직도 도착을
							안하고 있습니다. 주문 누락인가요? 빠른 처리 바랍니다.</td>
						<td class="inquiry-date-column">2024-06-15</td>
						<td class="status-column">답변 대기중</td>
					</tr>
					<tr class="collapse-content">
						<td colspan="6">
							<div class="response-form">
								<form>
									<label for="response1" class="response-label">답변 작성</label>
									<textarea id="response1" class="response-textarea"></textarea>
									<button type="submit" class="primary">답변 보내기</button>
								</form>
							</div>
						</td>
					</tr>
					<tr class="toggle-row">
						<td class="title-column">판매글 제목 2</td>
						<td class="product-name-column">상품 제목 2</td>
						<td class="customer-id-column">tester02</td>
						<td class="inquiry-content-column">4월 29일에 주문한 제품이 아직도 도착을
							안하고 있습니다. 주문 누락인가요? 빠른 처리 바랍니다.</td>
						<td class="inquiry-date-column">2024-06-15</td>
						<td class="status-column">답변 완료</td>
					</tr>
					<tr class="collapse-content">
						<td colspan="6">
							<div class="response-form">
								<form>
									<label for="response2" class="response-label">답변 작성</label>
									<textarea id="response2" class="response-textarea"></textarea>
									<button type="submit" class="primary">답변 보내기</button>
								</form>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/adminMain.js'/>"></script>
	</div>
</body>
</html>
