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
            <h1>관리자 관리</h1>
            <div class="search-bar">
                <div class="full-width">
                    <div class="half-width">
                        <label for="searchInput">검색어</label>
                        <input type="text" class="searchInput" placeholder="아이디, 이름을 입력하세요"
                            id="searchInput" name="searchInput">
                    </div>
                    <div class="half-width">
                        <label for="accessLevel">관리자 레벨</label>
                        <select id="accessLevel" name="accessLevel" class="secondary">
                            <option value="">전체</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                        </select>
                    </div>
                </div>
                <div class="full-width dark-mode">
                    <div class="date-group">
                        <label for="register_fr_date">계정 생성일</label>
                        <input type="date" name="register_fr_date" id="register_fr_date" placeholder="시작일"
                            class="secondary">
                        <input type="date" name="register_to_date" id="register_to_date" placeholder="종료일"
                            class="secondary">
                        <span class="btn_group">
                            <input type="button" class="btn_small white primary date-range-btn"
                                data-range="today" data-group="register" value="오늘">
                            <input type="button" class="btn_small white primary date-range-btn"
                                data-range="yesterday" data-group="register" value="어제">
                            <input type="button" class="btn_small white primary date-range-btn"
                                data-range="week" data-group="register" value="일주일">
                            <input type="button" class="btn_small white primary date-range-btn"
                                data-range="month" data-group="register" value="1개월">
                            <input type="button" class="btn_small white primary date-range-btn"
                                data-range="3months" data-group="register" value="3개월">
                            <input type="button" class="btn_small white primary date-range-btn"
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
                        <span>조회된 관리자 수: <strong>${totalElements}</strong>명
                        </span>
                    </div>
                </div>
                <div>
                    <button type="button" id="addAdmin" class="primary">관리자 추가</button>
                    <button type="button" id="editAdmin" class="primary">관리자 수정</button>
                    <button id="deleteSelectedButton" class="danger" data-url="/admin/adminManagement" data-pageType="adminManagement">선택삭제</button>
                </div>
            </div>
            <table class="admin-table custom-table dark-mode">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll" class="secondary"></th>
                        <th class="admin-id-column">아이디</th>
                        <th class="admin-name-column">이름</th>
                        <th class="admin-level-column">관리자 레벨</th>
                        <th class="created-date-column">계정 생성일</th>
                        <th class="deleted-yn-column">탈퇴 여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${admins.content}" var="admin">
                        <tr data-adminId=${admin.id}>
                            <td><input type="checkbox" class="selectAdmin secondary"></td>
                            <td class="admin-id-column">${admin.user.username}</td>
                            <td class="admin-name-column">${admin.name}</td>
                            <td class="admin-level-column">${admin.accessLevel}</td>
                            <td class="created-date-column">${admin.user.createdDate}</td>
                            <td class="deleted-yn-column">${admin.user.deletedYn}</td>
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
