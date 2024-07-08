<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/adminMain.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/customStyles.css'/>">
</head>
<body class="dark-mode">
    <div class="dashboard-container">
        <%@ include file="/WEB-INF/views/admin/layout.jsp"%>
        <div class="main-content dark-mode" id="mainContent">
            <h1>관리자 메인 페이지</h1>

            <!-- 요약 정보 -->
            <div class="summary-row dark-mode">
                <!-- 전체 주문 현황 -->
                <div class="summary-box dark-mode">
                    <h2>전체 주문 현황</h2>
                    <table>
                        <tr>
                            <th>주문 수</th>
                            <th>주문 총액</th>
                        </tr>
                        <tr>
                            <td>${orderList.size()}</td>
                            <td>${totalOrderAmount != null ? totalOrderAmount : 0}</td>
                        </tr>
                    </table>
                </div>

                <!-- 주문 상태 현황 (테이블 1) -->
                <div class="summary-box dark-mode">
                    <h2>주문 상태 현황</h2>
                    <table>
                        <tr>
                            <th>결제 완료</th>
                            <th>상품 준비</th>
                            <th>배송 준비</th>
                            <th>배송 중</th>
                            <th>배송 완료</th>
                        </tr>
                        <c:forEach var="statusMap" items="${orderStatusCounts}">
                            <tr>
                                <td>${statusMap['결제 완료']}</td>
                                <td>${statusMap['상품 준비']}</td>
                                <td>${statusMap['배송 준비']}</td>
                                <td>${statusMap['배송 중']}</td>
                                <td>${statusMap['배송 완료']}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>

                <!-- 구매확정/클래임 현황 (테이블 2) -->
                <div class="summary-box dark-mode">
                    <h2>구매확정/클래임 현황</h2>
                    <table>
                        <tr>
                            <th>구매 확정 대기</th>
                            <th>취소</th>
                            <th>반품</th>
                            <th>교환</th>
                        </tr>
                        <c:forEach var="statusMap" items="${orderStatusCounts}">
                            <tr>
                                <td>${statusMap['구매 확정 대기']}</td>
                                <td>${statusMap['취소']}</td>
                                <td>${statusMap['반품']}</td>
                                <td>${statusMap['교환']}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>

            <!-- 최근 주문 내역 -->
            <div class="recent-orders dark-mode">
                <h2>최근 주문 내역</h2>
                <table>
                    <tr>
                        <th>주문 번호</th>
                        <th>고객 이름</th>
                        <th>주문 날짜</th>
                        <th>주문 상태</th>
                    </tr>
                    <!-- 최근 주문 데이터 -->
                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td>${order.orderNumber}</td>
                            <td>${order.customer.name}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.orderStatus.orderStatus}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <!-- 인기 상품 -->
            <div class="popular-products dark-mode">
                <h2>인기 상품</h2>
                <ul>
                    <li>상품 1</li>
                    <li>상품 2</li>
                    <li>상품 3</li>
                </ul>
            </div>

            <!-- 최근 가입 회원 -->
            <div class="recent-users dark-mode">
                <h2>최근 가입 회원</h2>
                <table>
                    <tr>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>성별</th>
                        <th>이메일</th>
                        <th>가입일</th>
                    </tr>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>${user.username}</td>
                            <td>${user.customer.name}</td>
                            <td>${user.customer.gender}</td>
                            <td>${user.customer.email}</td>
                            <td>${user.formattedCreatedDate}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <button id="toggleMode">Toggle Mode</button>
        <script src="<c:url value='/js/admin/productNumber.js'/>"></script>
        <script src="<c:url value='/js/admin/editDiscount.js'/>"></script>
        <script src="<c:url value='/js/admin/starRating.js'/>"></script>
        <script src="<c:url value='/js/admin/sortTable.js'/>"></script>
        <script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
        <script src="<c:url value='/js/admin/openWindow.js'/>"></script>
        <script src="<c:url value='/js/admin/main.js'/>"></script>
        <script src="<c:url value='/js/admin/ckeditor5/build/ckeditor.js'/>"></script>
        <script src="<c:url value='/js/admin/UploadAdapter.js'/>"></script>
    </div>
</body>
</html>
