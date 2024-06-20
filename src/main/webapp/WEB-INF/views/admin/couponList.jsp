<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <h1>쿠폰 관리</h1>

            <!-- 검색창 -->
            <form name="fsearch" id="fsearch" method="get">
                <div class="search-bar">
                    <div class="full-width">
                        <div class="half-width">
                            <label for="searchCouponNumber">쿠폰번호</label> 
                            <input type="text" class="searchInput" placeholder="쿠폰번호를 입력하세요" id="searchCouponNumber" name="searchCouponNumber">
                        </div>
                    </div>
                    <div class="full-width">
                        <div class="date-group">
                            <label for="searchIssuedDateFrom">발행 날짜</label>
                            <input type="date" name="searchIssuedDateFrom" id="searchIssuedDateFrom" placeholder="시작일" class="secondary">
                            <input type="date" name="searchIssuedDateTo" id="searchIssuedDateTo" placeholder="종료일" class="secondary">
                            <span class="btn_group">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="today" data-group="searchIssuedDate" value="오늘">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="yesterday" data-group="searchIssuedDate" value="어제">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="week" data-group="searchIssuedDate" value="일주일">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="month" data-group="searchIssuedDate" value="1개월">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="3months" data-group="searchIssuedDate" value="3개월">
                                <input type="button" class="btn_small white primary date-range-btn" data-range="all" data-group="searchIssuedDate" value="전체">
                            </span>
                        </div>
                    </div>
                    <div class="full-width">
                        <div class="half-width">
                            <label for="searchDiscountType">할인 종류</label>
                            <div id="radio-group">
                                <label><input type="radio" name="searchDiscountType" value="" checked> 전체</label>
                                <label><input type="radio" name="searchDiscountType" value="퍼센트"> 퍼센트</label>
                                <label><input type="radio" name="searchDiscountType" value="금액"> 금액</label>
                            </div>
                        </div>
                    </div>
                    <div class="full-width">
                        <div class="half-width">
                            <label for="minPurchaseValueFrom">최소 구매 값</label>
                            <input type="number" name="minPurchaseValueFrom" id="minPurchaseValueFrom" placeholder="최소값" class="secondary">
                            <input type="number" name="minPurchaseValueTo" id="minPurchaseValueTo" placeholder="최대값" class="secondary">
                        </div>
                        <div class="half-width">
                            <label for="maxDiscountValueFrom">최대 할인 값</label> 
                            <input type="number" name="maxDiscountValueFrom" id="maxDiscountValueFrom" placeholder="최소값" class="secondary">
                            <input type="number" name="maxDiscountValueTo" id="maxDiscountValueTo" placeholder="최대값" class="secondary">
                        </div>
                    </div>
                    <div class="full-width">
                        <div class="half-width">
                            <label for="discountDateFrom">할인 기간</label>
                            <input type="date" name="discountDateFrom" id="discountDateFrom" placeholder="시작일" class="secondary">
                            <input type="date" name="discountDateTo" id="discountDateTo" placeholder="종료일" class="secondary">
                            <span class="btn_group"> 
                                <button type="button" class="btn_small white primary date-range-btn" data-range="today" data-group="discountDate">오늘</button> 
                                <button type="button" class="btn_small white primary date-range-btn" data-range="yesterday" data-group="discountDate">어제</button> 
                                <button type="button" class="btn_small white primary date-range-btn" data-range="week" data-group="discountDate">일주일</button> 
                                <button type="button" class="btn_small white primary date-range-btn" data-range="month" data-group="discountDate">1개월</button> 
                                <button type="button" class="btn_small white primary date-range-btn" data-range="3months" data-group="discountDate">3개월</button> 
                                <button type="button" class="btn_small white primary date-range-btn" data-range="all" data-group="discountDate">전체</button>
                            </span>
                        </div>
                    </div>
                    <div class="full-width">
                        <div class="half-width">
                            <label for="searchExpired">만료 여부</label>
                            <div id="radio-group">
                                <label><input type="radio" name="searchExpired" value="" checked> 전체</label>
                                <label><input type="radio" name="searchExpired" value="Y"> 만료</label>
                                <label><input type="radio" name="searchExpired" value="N"> 유효</label>
                            </div>
                        </div>
                        <div class="half-width">
                            <label for="searchUsed">사용 여부</label>
                            <div id="radio-group">
                                <label><input type="radio" name="searchUsed" value="" checked> 전체</label>
                                <label><input type="radio" name="searchUsed" value="Y"> 사용됨</label>
                                <label><input type="radio" name="searchUsed" value="N"> 사용 안됨</label>
                            </div>
                        </div>
                    </div>
                    <div class="search-buttons full-width">
                        <button type="submit" class="primary">검색</button>
                        <button type="reset" class="secondary">초기화</button>
                    </div>
                    <div>
                        <button type="button" id="addCounpon" class="primary">쿠폰 발행</button>
                    </div>
                </div>
            </form>

            <!-- 상품 목록 -->
            <div class="product-list-header">
                <div>
                    <span>조회된 할인 수: <strong>10</strong>개</span>
                </div>
            </div>
            <table class="product-list dark-mode" id="discountTable">
                <thead>
                    <tr>
                        <th class="discount-name-column">쿠폰번호</th>
                        <th class="discount-description-column">발행 날짜</th>
                        <th class="discount-category-column">할인 종류</th>
                        <th class="discount-value-column">할인 값</th>
                        <th class="min-purchase-value-column">최소 구매 값</th>
                        <th class="max-discount-value-column">최대 할인 값</th>
                        <th class="start-date-column">시작 날짜</th>
                        <th class="end-date-column">종료 날짜</th>
                        <th class="status-column">만료 여부</th>
                        <th class="status-column">사용 여부</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="discount-name-column">123456789</td>
                        <td class="discount-description-column">2024-07-01</td>
                        <td class="discount-category-column">퍼센트</td>
                        <td class="discount-value-column">10%</td>
                        <td class="min-purchase-value-column">₩10,000</td>
                        <td class="max-discount-value-column">₩50,000</td>
                        <td class="start-date-column">2024-07-01</td>
                        <td class="end-date-column">2024-07-31</td>
                        <td class="status-column">유효</td>
                        <td class="status-column">사용 안됨</td>
                    </tr>
                    <tr>
                        <td class="discount-name-column">987654321</td>
                        <td class="discount-description-column">2024-06-01</td>
                        <td class="discount-category-column">금액</td>
                        <td class="discount-value-column">₩5,000</td>
                        <td class="min-purchase-value-column">₩20,000</td>
                        <td class="max-discount-value-column">₩30,000</td>
                        <td class="start-date-column">2024-06-01</td>
                        <td class="end-date-column">2024-06-30</td>
                        <td class="status-column">유효</td>
                        <td class="status-column">사용됨</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <button id="toggleMode" class="primary">Toggle Mode</button>
        <script src="<c:url value='/js/admin/main.js'/>"></script>
        <script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
        <script src="<c:url value='/js/admin/openDiscountAddWindow.js'/>"></script>
    </div>
</body>
</html>
