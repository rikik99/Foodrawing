<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/adminReviews.css" />
</head>
<body class="dark-mode">
	<div class="dashboard-container">
		<jsp:include page="/WEB-INF/views/admin/layout.jsp" />
		<div class="main-content dark-mode" id="mainContent">
			<h1>판매글 리뷰 관리</h1>

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
						<label for="rating">평점</label>
						<div class="star-rating">
							<span class="star" data-value="1">&#9733;</span> <span
								class="star" data-value="2">&#9733;</span> <span class="star"
								data-value="3">&#9733;</span> <span class="star" data-value="4">&#9733;</span>
							<span class="star" data-value="5">&#9733;</span>
						</div>
						<input type="hidden" id="rating" name="rating" value="">
					</div>
					<div class="half-width">
						<label for="radio-group">해결 상태</label>
						<div id="radio-group">
							<label><input type="radio" name="replyYn" value=""
								id="replyYn" checked> 전체</label> <label><input
								type="radio" id="replyYn" name="replyYn" value="N"> 답변
								대기</label> <label><input type="radio" name="replyYn"
								id="replyYn" value="Y"> 답변 완료</label>
						</div>
					</div>
				</div>
				<div class="search-buttons full-width">
					<button type="button" class="primary search-btn"
						data-url="/admin/salesReview">검색</button>
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
						<th class="review-content-column">리뷰 내용</th>
						<th class="review-rating-column">리뷰 평점</th>
						<th class="inquiry-date-column">작성 날짜</th>
						<th class="status-column">답변 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${reviews.content}" var="reviews">
						<tr class="reviewToggle" onclick="handleReviewToggleClick(event);">
							<td class="title-column">${reviews.salesPotDTO.title}</td>
							<td class="product-name-column">${reviews.productDTO.productNumber}</td>
							<td class="customer-id-column">${reviews.customerDTO.nickname}</td>
							<td class="review-content-column">${reviews.message}</td>
							<td class="review-rating-column">⭐ ${reviews.rating}</td>
							<td class="review-date-column">${reviews.formattedCreatedDate}</td>
							<td class="status-column"><c:choose>
									<c:when test="${reviews.replyYn == 'Y'}">
								답변 완료
								</c:when>
									<c:when test="${reviews.replyYn == 'N'}">
								답변 대기
								</c:when>
								</c:choose></td>
						</tr>
						<c:choose>
							<c:when test="${reviews.replyYn == 'Y'}">
								<tr class="reviewToggleMenu">
									<td colspan="7">
										<div class="reply-form">
											<div class="replyTitle">
												<p>푸드로잉</p>
												<p>${reviews.reviewsReplyDTO.formattedCreatedDate}</p>
											</div>
											<textarea id="message" class="reply-textarea"
												readonly="readonly">${reviews.reviewsReplyDTO.message}</textarea>
										</div>
									</td>
								</tr>
							</c:when>
							<c:when test="${reviews.replyYn == 'N'}">
								<tr class="reviewToggleMenu">
									<td colspan="7">
										<div class="reply-form">
											<label for="message" class="reply-label">답변 작성</label>
											<textarea id="message" class="reply-textarea"></textarea>
											<button type="button" class="primary replyBtn"
												data-reviewsId="${ reviews.id}">답변 보내기</button>
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
							data-url="/admin/salesReview" data-size="${size}">${i}</a>
						</li>
					</c:forEach>
				</ul>
			</nav>
			<script src="<c:url value='/js/admin/main.js'/>"></script>
			<script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
			<script src="<c:url value='/js/admin/starRating.js'/>"></script>
		</div>
		<button id="toggleMode" class="primary">Toggle Mode</button>
	</div>
</body>
</html>