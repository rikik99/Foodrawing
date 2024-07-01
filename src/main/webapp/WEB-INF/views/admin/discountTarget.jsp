<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/adminDiscount.css" />
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>할인 대상 관리</h1>
			<div class="search-bar">
				<div class="full-width">
					<div class="half-width">
						<label for="searchInput">검색어</label> <input type="text"
							class="searchInput" placeholder="제목, 상품명, 작성자를 입력하세요"
							id="searchInput" name="searchInput">
					</div>
				</div>
				<div class="full-width">
					<div class="half-width">
						<label for="radio-group">할인 유형</label>
						<div id="radio-group">
							<label><input type="radio" name="type" value="" checked>
								전체</label> <label><input type="radio" name="type" value="이벤트">
								이벤트</label> <label><input type="radio" name="type" value="쿠폰">
								쿠폰</label>
						</div>
					</div>
					<div class="half-width">
						<label for="radio-group">진행 상태</label>
						<div id="radio-group">
							<label><input type="radio" name="onsaleYn" value=""
								id="onsaleYn" checked> 전체</label> <label><input
								type="radio" id="onsaleYn" name="onsaleYn" value="Y">진행
								중</label> <label><input type="radio" name="onsaleYn"
								id="onsaleYn" value="N"> 종료</label>
						</div>
					</div>
				</div>
				<div class="full-width">
					<div class="half-width">
						<label for="radio-group">할인 대상</label>
						<div id="radio-group">
						<label><input type="radio" name="targetType" value=""
								checked>모두</label>
							<label><input type="radio" name="targetType" value="ALL">전체</label> <label><input type="radio"
								name="targetType" value="PRODUCT">상품</label> <label><input
								type="radio" name="targetType" value="MEMBER_RATING">등급</label> <label><input type="radio" name="targetType"
								value="CUSTOMER">회원</label> <label><input type="radio"
								name="targetType" value="CATEGORY">카테고리</label>
						</div>
					</div>
					<div class="half-width">
						<label for="radio-group">할인 종류</label>
						<div id="radio-group">
							<label><input type="radio" name="discountType" value=""
								checked> 전체</label> <label><input type="radio"
								name="discountType" value="P"> 퍼센트</label> <label><input
								type="radio" name="discountType" value="A"> 금액</label>
						</div>
					</div>
				</div>
				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="register_fr_date">할인 기간</label> <input type="date"
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
						data-url="/admin/discountTarget">검색</button>
					<button type="reset" class="secondary">초기화</button>
				</div>
			</div>
			<div class="full-width dark-mode between">
				<div class="product-list-header">
					<div>
						<span>조회된 할인 수: <strong>${totalElements}</strong>개
						</span>
					</div>
				</div>
				<div>
					<button type="button" id="addDiscountTarget" class="primary">할인 대상
						추가</button>
					<button type="button" id="editDiscount" class="primary">할인
						수정</button>
					<button id="deleteSelectedButton" class="danger"
						data-url="/admin/discountList" data-pageType="discountList">선택삭제</button>
				</div>
			</div>
			<table class="discount-table product-list dark-mode">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" class="secondary"></th>
						<th class="discount-name-column">할인명</th>
						<th class="discount-type-column">할인 유형</th>
						<th class="discount-category-column">할인 종류</th>
						<th class="discount-value-column">할인 값</th>
						<th class="discount-target-column">할인 대상</th>
						<th class="discount-targetName-column">대상 이름</th>
						<th class="start-date-column">시작 날짜</th>
						<th class="end-date-column">종료 날짜</th>
						<th class="status-column">진행 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${discounts.content}" var="discounts">
						<tr data-discountId=${discounts.id }>
							<td><input type="checkbox" class="selectProduct secondary"></td>
							<td class="discount-name-column">${discounts.name}</td>
							<td class="discount-type-column"><c:choose>
									<c:when test="${discounts.discountType == 'P'}">퍼센트</c:when>
									<c:when test="${discounts.discountType == 'A'}">금액</c:when>
									<c:otherwise>오류</c:otherwise>
								</c:choose></td>
							<td class="discount-category-column">${discounts.type}</td>
							<td class="discount-value-column"><c:choose>
									<c:when test="${discounts.discountType == 'P'}">${discounts.discountValue}%</c:when>
									<c:when test="${discounts.discountType == 'A'}">&#8361;${discounts.discountValue}</c:when>
									<c:otherwise>오류</c:otherwise>
								</c:choose></td>
							<td class="discount-target-column"><c:choose>
									<c:when
										test="${discounts.discountTargetDTO.targetType == 'ALL'}">
								전체 할인
								</c:when>
									<c:when
										test="${discounts.discountTargetDTO.targetType == 'PRODUCT'}">
								상품 할인
								</c:when>
									<c:when
										test="${discounts.discountTargetDTO.targetType == 'MEMBER_RATING'}">
								등급 할인
								</c:when>
									<c:when
										test="${discounts.discountTargetDTO.targetType == 'CUSTOMER'}">
								개별 할인
								</c:when>
									<c:when
										test="${discounts.discountTargetDTO.targetType == 'CATEGORY'}">
								카테고리 할인
								</c:when>
								</c:choose></td>
							<td class="discount-targetName-column">${discounts.discountTargetDTO.targetName}</td>
							<td class="start-date-column">${discounts.formattedStartDate}</td>
							<td class="end-date-column">${discounts.formattedEndDate}</td>
							<td class="status-column"><c:choose>
									<c:when test="${discounts.onsaleYn == 'N'}">
								종료
								</c:when>
									<c:when test="${discounts.onsaleYn == 'Y'}">
								진행 중
								</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" data-page="${i - 1}"
							data-url="/admin/discountTarget" data-size="${size}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<script src="<c:url value='/js/admin/main.js'/>"></script>
		<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
		<script src="<c:url value='/js/admin/openWindow.js'/>"></script>
		<script src="<c:url value='/js/admin/setDateRange.js'/>"></script>
	</div>
	<button id="toggleMode" class="primary">Toggle Mode</button>
</body>
</html>