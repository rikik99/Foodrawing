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
			<h1>판매글 문의 관리</h1>

			<!-- 검색창 -->
			<div class="search-bar">
				<div class="full-width">
					<div class="half-width">
						<label for="searchInput">검색어</label> <input type="text"
							class="searchInput" placeholder="제목, 상품명, 작성자를 입력하세요"
							id="searchInput" name="searchInput">
					</div>
				</div>

				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="register_fr_date">등록일</label> <input type="date"
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
				<div class="full-width">
					<div class="half-width">
						<label for="radio-group">해결 상태</label>
						<div id="radio-group">
							<label><input type="radio" name="resolvedYn" value=""
								id="resolvedYn" checked> 전체</label> <label><input
								type="radio" id="resolvedYn" name="resolvedYn" value="N">
								답변 대기</label> <label><input type="radio" name="resolvedYn"
								id="resolvedYn" value="Y"> 답변 완료</label>
						</div>
					</div>
				</div>
				<div class="search-buttons full-width">
					<button type="button" class="primary search-btn"
						data-url="/admin/salesInquiry">검색</button>
					<button type="reset" class="secondary">초기화</button>
				</div>
			</div>

			<!-- 상품 목록 -->
			<div class="product-list-header">
				<div>
					<span>조회된 판매글 수: <strong>${totalElements}</strong>개
					</span>
				</div>
			</div>
			<table class="product-list dark-mode">
				<thead>
					<tr>
						<th class="title-column">판매글 제목</th>
						<th class="product-name-column">상품 코드</th>
						<th class="customer-id-column">고객 아이디</th>
						<th class="inquiry-content-column">문의 내용</th>
						<th class="inquiry-date-column">문의 날짜</th>
						<th class="status-column">해결 상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${inquiries.content}" var="inquiries">
						<tr class="inquiryToggle"
							onclick="handleInquiryToggleClick(event);">
							<td class="title-column">${inquiries.salesPotDTO.title}</td>
							<td class="product-name-column">${inquiries.productDTO.productNumber}</td>
							<td class="customer-id-column">${inquiries.customerDTO.nickname}</td>
							<td class="inquiry-content-column">${inquiries.message}</td>
							<td class="inquiry-date-column">${inquiries.createdDate}</td>
							<td class="status-column"><c:choose>
									<c:when test="${inquiries.resolvedYn == 'Y'}">
								답변 완료
								</c:when>
									<c:when test="${inquiries.resolvedYn == 'N'}">
								답변 대기
								</c:when>
								</c:choose></td>
						</tr>
						<c:choose>
							<c:when test="${inquiries.resolvedYn == 'Y'}">
								<tr class="inquiryToggleMenu">
									<td colspan="6">
										<div class="response-form">
											<div class="responseTitle">
												<p>푸드로잉</p>
												<p>${inquiries.responseDTO.createdDate}</p>
											</div>
											<textarea id="message" class="response-textarea"  readonly="readonly">${inquiries.responseDTO.message}</textarea>
										</div>
									</td>
								</tr>
							</c:when>
							<c:when test="${inquiries.resolvedYn == 'N'}">
								<tr class="inquiryToggleMenu">
									<td colspan="6">
										<div class="response-form">
											<label for="response1" class="response-label">답변 작성</label>
											<textarea id="message" class="response-textarea"></textarea>
											<button type="button" class="primary responseBtn"
												data-inquiriesId="${ inquiries.id}">답변 보내기</button>
										</div>
									</td>
								</tr>
							</c:when>
						</c:choose>

					</c:forEach>

				</tbody>
			</table>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" data-page="${i - 1}"
							data-url="/admin/salesInquiry" data-size="${size}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
		<script src="<c:url value='/js/adminMain.js'/>"></script>
	</div>
</body>
</html>
