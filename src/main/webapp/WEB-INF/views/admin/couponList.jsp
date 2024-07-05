<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/consolidated.css" />
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>쿠폰 관리</h1>
			<div class="search-bar">
				<div class="full-width">
					<div class="half-width">
						<label for="searchInput">검색어</label> <input type="text"
							class="searchInput" placeholder="할인명, 고객 아이디, 쿠폰 번호를 입력하세요"
							id="searchInput" name="searchInput">
					</div>
				</div>
				<div class="full-width">
					<div class="half-width">
						<label for="radio-group">할인 종류</label>
						<div id="radio-group">
							<label><input type="radio" name="discountType" value=""
								checked> 전체</label> <label><input type="radio"
								name="discountType" value="P"> 퍼센트</label> <label><input
								type="radio" name="discountType" value="A"> 금액</label>
						</div>
					</div>
					<div class="half-width">
						<label for="radio-group">사용 여부</label>
						<div id="radio-group">
							<label><input type="radio" name="usedYn" value=""
								id="usedYn" checked> 전체</label> <label><input
								type="radio" id="usedYn" name="usedYn" value="Y">사용</label> <label><input
								type="radio" name="onsaleYn" id="usedYn" value="N">미사용</label>
						</div>
					</div>
				</div>
				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="discount_fr_date">할인 기간</label> <input type="date"
							name="discount_fr_date" id="discount_fr_date" placeholder="시작일"
							class="secondary"> <input type="date"
							name="discount_to_date" id="discount_to_date" placeholder="종료일"
							class="secondary"> <span class="btn_group"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="today" data-group="discount" value="오늘"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="yesterday" data-group="discount" value="어제">
							<input type="button"
							class="btn_small white primary date-range-btn" data-range="week"
							data-group="discount" value="일주일"> <input type="button"
							class="btn_small white primary date-range-btn" data-range="month"
							data-group="discount" value="1개월"> <input type="button"
							class="btn_small white primary date-range-btn"
							data-range="3months" data-group="discount" value="3개월"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="all" data-group="discount" value="전체">
						</span>
					</div>
				</div>
				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="register_fr_date">발행 날짜</label> <input type="date"
							name="register_fr_date" id="register_fr_date" placeholder="시작일"
							class="secondary"> <input type="date"
							name="register_to_date" id="register_to_date" placeholder="종료일"
							class="secondary"> <span class="btn_group"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="today" data-group="register" value="오늘"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="yesterday" data-group="register" value="어제">
							<input type="button"
							class="btn_small white primary date-range-btn" data-range="week"
							data-group="register" value="일주일"> <input type="button"
							class="btn_small white primary date-range-btn" data-range="month"
							data-group="register" value="1개월"> <input type="button"
							class="btn_small white primary date-range-btn"
							data-range="3months" data-group="register" value="3개월"> <input
							type="button" class="btn_small white primary date-range-btn"
							data-range="all" data-group="register" value="전체">
						</span>
					</div>
				</div>
				<div class="search-buttons full-width">
					<button type="button" class="primary search-btn"
						data-url="/admin/couponList">검색</button>
					<button type="reset" class="secondary">초기화</button>
				</div>
				     <div class="insertordelete full-width">
                        <button type="button" id="addCounpon" class="primary">쿠폰 발행</button>
                        <button id="deleteSelectedButton" class="danger"
						data-url="/admin/couponList" data-pageType="couponList">선택삭제</button>
                    </div>
			</div>


			<!-- 상품 목록 -->
			<div class="custom-table-header">
				<div>
					<span>조회된 쿠폰 수: <strong>${totalElements}</strong>개
					</span>
				</div>
			</div>
			<table class="custom-table dark-mode" id="discountTable">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" class="secondary"></th>
						<th class="discount-name-column">할인명</th>
						<th class="discount-name-column">고객 아이디</th>
						<th class="discount-description-column">쿠폰 번호</th>
						<th class="discount-category-column">할인 유형</th>
						<th class="discount-value-column">할인 값</th>
						<th class="start-date-column">시작 날짜</th>
						<th class="end-date-column">종료 날짜</th>
						<th class="status-column">발행 날짜</th>
						<th class="status-column">사용 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${couponIssuances.content}" var="couponIssuances">
						<tr data-issuanceId=${couponIssuances.id }>
							<td><input type="checkbox" class="selectProduct secondary"></td>
							<td class="discount-name-column">${couponIssuances.discountDTO.name}</td>
							<td class="discount-name-column">${couponIssuances.username}</td>
							<td class="discount-name-column">${couponIssuances.couponNumber}</td>
							<td class="discount-name-column"><c:choose>
									<c:when
										test="${couponIssuances.discountDTO.discountType == 'P'}">퍼센트</c:when>
									<c:when
										test="${couponIssuances.discountDTO.discountType == 'A'}">금액</c:when>
									<c:otherwise>오류</c:otherwise>
								</c:choose></td>
							<td class="discount-value-column"><c:choose>
									<c:when
										test="${couponIssuances.discountDTO.discountType == 'P'}">${couponIssuances.discountDTO.discountValue}%</c:when>
									<c:when
										test="${couponIssuances.discountDTO.discountType == 'A'}">&#8361;${couponIssuances.discountDTO.discountValue}</c:when>
									<c:otherwise>오류</c:otherwise>
								</c:choose></td>
							<td class="discount-name-column">${couponIssuances.discountDTO.formattedStartDate}</td>
							<td class="discount-name-column">${couponIssuances.discountDTO.formattedEndDate}</td>
							<td class="discount-name-column">${couponIssuances.formattedIssuedAt}</td>
							<td class="discount-name-column">${couponIssuances.usedYn}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" data-page="${i - 1}"
							data-url="/admin/couponList" data-size="${size}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
		<script src="<c:url value='/js/admin/openWindow.js'/>"></script>
	</div>
</body>
</html>
