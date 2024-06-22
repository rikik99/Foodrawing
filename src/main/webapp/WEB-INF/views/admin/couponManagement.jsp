<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/discountAdd.css" />
<script src="<c:url value='/js/admin/couponForm.js'/>"></script>
</head>
<body class="dark-mode">
    <div class="discount-form-container">
        <form id="couponForm" method="post" action="/admin/couponManagement" class="discount-form">
            <h1>쿠폰 발행</h1>
            <table class="form-table">
                <tr>
                    <td><label for="couponName">쿠폰명</label></td>
                    <td>
                        <select id="couponName" name="couponName" onchange="updateCouponDetails()" required>
                            <option value="">쿠폰을 선택하세요</option>
                            <option value="Summer Sale">Summer Sale</option>
                            <option value="Winter Sale">Winter Sale</option>
                            <option value="Black Friday">Black Friday</option>
                            <option value="New Year Coupon">New Year Coupon</option>
                            <option value="Ongoing Discount">Ongoing Discount</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="couponDetails" class="coupon-details"></div>
                    </td>
                </tr>
                <tr>
                    <td><label>발행 대상</label></td>
                    <td>
                        <label><input type="radio" name="targetType" value="individual" onclick="showTargetInput()"> 개인</label>
                        <label><input type="radio" name="targetType" value="membership" onclick="showTargetInput()"> 회원등급</label>
                        <label><input type="radio" name="targetType" value="all" onclick="showTargetInput()"> 전체</label>
                    </td>
                </tr>
                <tr id="individualInput" style="display: none;">
                    <td><label for="individualIds">회원 ID</label></td>
                    <td><input type="text" id="individualIds" name="individualIds" placeholder="쉼표로 구분하여 여러 회원 ID 입력"></td>
                </tr>
                <tr id="membershipInput" style="display: none;">
                    <td><label for="membershipLevels">회원 등급</label></td>
                    <td>
                        <label><input type="checkbox" name="membershipLevels" value="normal"> 일반</label>
                        <label><input type="checkbox" name="membershipLevels" value="premium"> 프리미엄</label>
                        <label><input type="checkbox" name="membershipLevels" value="vip"> VIP</label>
                    </td>
                </tr>
                <tr>
                    <td><label for="couponCode">쿠폰 코드</label></td>
                    <td><input type="text" id="couponCode" name="couponCode" required></td>
                </tr>
                <tr>
                    <td><label for="issueCount">발행 개수</label></td>
                    <td><input type="number" id="issueCount" name="issueCount" required></td>
                </tr>
                <tr>
                    <td colspan="2"><button type="submit" class="primary">발행</button></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
