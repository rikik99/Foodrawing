<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/insertCoupon.css" />
<script>
    const couponDetailsJson = ${couponDetailsJson}; // 쿠폰 상세 정보를 JSON으로 가져오기
</script>
<script src="<c:url value='/js/admin/couponForm.js'/>"></script>
</head>
<body class="dark-mode">
    <div class="coupon-form-container">
        <form id="couponForm" method="post" action="/admin/insertCoupon" class="coupon-form">
            <h1>쿠폰 발행</h1>
            <table class="form-table">
                <tr>
                    <td><label for="couponName">쿠폰명</label></td>
                    <td>
                        <select id="couponName" name="couponName" onchange="updateCouponDetails()" required>
                            <option value="">쿠폰을 선택하세요</option>
                            <c:forEach items="${coupon}" var="coupon">
                                <option value="${coupon.id}">${coupon.name}</option>
                            </c:forEach>
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
                        <label><input type="radio" name="targetType" value="customers" onclick="showTargetInput()"> 개인</label>
                        <label><input type="radio" name="targetType" value="rating" onclick="showTargetInput()"> 회원등급</label>
                        <label><input type="radio" name="targetType" value="all" onclick="showTargetInput()"> 전체</label>
                    </td>
                </tr>
                <tr id="customers" style="display: none;">
                    <td colspan="2"><label for="individualIds">회원 정보</label></td>
                </tr>
                <tr id="customerList" style="display: none;">
                    <td colspan="2">
                        <table class="customer-list-table">
                            <thead>
                                <tr>
                                    <th>아이디</th>
                                    <th>생년월일</th>
                                    <th>회원등급</th>
                                    <th>가입일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customer}" var="customer">
                                    <tr data-customerId="${customer.id}" onclick="selectCustomer(this)">
                                        <td>${customer.userDTO.username}</td>
                                        <td>${customer.formattedBirthDate}</td>
                                        <td>${customer.member.rating}</td>
                                        <td>${customer.userDTO.formattedCreatedDate}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr id="selectedcustomers" style="display: none;">
                    <td colspan="2"><label for="selectedIndividualIds">선택된 회원 정보</label></td>
                </tr>
                <tr id="selectedcustomerList" style="display: none;">
                    <td colspan="2">
                        <table class="customer-list-table">
                            <thead>
                                <tr>
                                    <th>아이디</th>
                                    <th>생년월일</th>
                                    <th>회원등급</th>
                                    <th>가입일</th>
                                </tr>
                            </thead>
                            <tbody id="selectedCustomerTbody">
                                <!-- 선택된 회원 정보가 여기에 추가됩니다 -->
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr id="membershipInput" style="display: none;">
                    <td><label for="membershipLevels">회원 등급</label></td>
                    <td>
                        <label><input type="checkbox" name="membershipLevels" value="1"> 일반</label>
                        <label><input type="checkbox" name="membershipLevels" value="2"> 우수</label>
                        <label><input type="checkbox" name="membershipLevels" value="3"> 프리미엄</label>
                        <label><input type="checkbox" name="membershipLevels" value="4"> VIP</label>
                        <label><input type="checkbox" name="membershipLevels" value="5"> VVIP</label>
                    </td>
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
