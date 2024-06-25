<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css"
    href="<c:url value='/css/admin/adminMain.css'/>">
<link rel="stylesheet" type="text/css"
    href="<c:url value='/css/admin/common.css'/>">
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
                            <th>주문액</th>
                            <th>입금전</th>
                            <th>입금완료</th>
                            <th>배송중</th>
                            <th>배송완료</th>
                            <th>구매확정</th>
                        </tr>
                        <tr>
                            <td>36</td>
                            <td>2,487,220</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                            <td>1</td>
                            <td>0</td>
                        </tr>
                    </table>
                </div>

                <!-- 주문 상태 현황 -->
                <div class="summary-box dark-mode">
                    <h2>주문 상태 현황</h2>
                    <table>
                        <tr>
                            <th>주문번호</th>
                            <th>주문자명</th>
                            <th>주문상태</th>
                            <th>처리상태</th>
                            <th>배송상태</th>
                        </tr>
                        <tr>
                            <td>#12345</td>
                            <td>홍길동</td>
                            <td>결제완료</td>
                            <td>배송중</td>
                            <td>배송준비</td>
                        </tr>
                        <tr>
                            <td>#12344</td>
                            <td>김철수</td>
                            <td>결제완료</td>
                            <td>배송중</td>
                            <td>배송준비</td>
                        </tr>
                    </table>
                </div>

                <!-- 구매확정/클레임 현황 -->
                <div class="summary-box dark-mode">
                    <h2>구매확정/클레임 현황</h2>
                    <table>
                        <tr>
                            <th>구매확정</th>
                            <th>취소</th>
                            <th>환불</th>
                            <th>반품</th>
                            <th>교환</th>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>2</td>
                            <td>1</td>
                            <td>0</td>
                            <td>0</td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- 실시간 알림 -->
            <div class="notifications dark-mode">
                <h2>실시간 알림</h2>
                <div class="notification-box dark-mode">
                    <p>재고가 부족한 상품이 있습니다.</p>
                </div>
                <div class="notification-box dark-mode">
                    <p>새로운 고객 문의가 있습니다.</p>
                </div>
                <div class="notification-box dark-mode">
                    <p>새로운 주문이 접수되었습니다.</p>
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
                    <tr>
                        <td>#12345</td>
                        <td>홍길동</td>
                        <td>2024-06-16</td>
                        <td>처리 중</td>
                    </tr>
                    <tr>
                        <td>#12344</td>
                        <td>김철수</td>
                        <td>2024-06-15</td>
                        <td>완료</td>
                    </tr>
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
