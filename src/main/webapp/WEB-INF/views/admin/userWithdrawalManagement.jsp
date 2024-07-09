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
			<h1>회원 탈퇴 관리</h1>
			<div class="search-bar">
				<div class="full-width">
					<div class="half-width">
						<label for="searchInput">검색어</label> <input type="text"
							class="searchInput" placeholder="아이디, 이름을 입력하세요" id="searchInput"
							name="searchInput">
					</div>
				</div>
				<div class="full-width dark-mode">
					<div class="date-group">
						<label for="register_fr_date">탈퇴 요청일</label> <input type="date"
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
						data-url="/admin/adminManagement">검색</button>
					<button type="reset" class="secondary">초기화</button>
				</div>
			</div>
			<div class="full-width dark-mode between">
				<div class="custom-table-header">
					<div>
						<span>탈퇴 요청 수: <strong>${totalElements}</strong>명
						</span>
					</div>
				</div>
			</div>
			<table class="admin-table custom-table dark-mode">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll" class="secondary"></th>
						<th class="user-id-column">아이디</th>
						<th class="username-column">이름</th>
						<th class="user-role-column">유저 타입</th>
						<th class="created-date-column">계정 생성일</th>
						<th class="deleted-yn-date-column">탈퇴 요청일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${user.content}" var="user">
						<tr data-user-id="${user.id}">
							<td><input type="checkbox" class="selectUser secondary"></td>
							<td class="user-id-column">${user.username}</td>
							<td class="username-column"><c:choose>
									<c:when test="${user.role == 1}">
                                        ${user.customer.name}
                                    </c:when>
									<c:otherwise>
                                        ${user.admin.name}
                                    </c:otherwise>
								</c:choose></td>
							<td class="user-role-column"><c:choose>
									<c:when test="${user.role == 1}">
                                        구매자
                                    </c:when>
									<c:otherwise>
                                        관리자
                                    </c:otherwise>
								</c:choose></td>
							<td class="created-date-column">${user.formattedCreatedDate}</td>
							<td class="deleted-yn-date-column">${user.formattedDeletedDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:forEach begin="1" end="${pageCount}" var="i">
						<li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
							<a class="page-link" data-page="${i - 1}"
							data-url="/admin/adminManagement" data-size="${size}">${i}</a>
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
