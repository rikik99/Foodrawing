<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/discountAdd.css" />
</head>
<body class="dark-mode">
    <div class="discount-form-container">
        <form id="discountForm" method="post" action="/admin/discountManagement" class="discount-form">
            <h1>할인 등록</h1>
            <table class="form-table">
                <tr>
                    <td><label for="name">할인명</label></td>
                    <td><input type="text" id="name" name="name" required></td>
                </tr>
                <tr>
                    <td><label for="description">할인 설명</label></td>
                    <td><textarea id="description" name="description" required></textarea></td>
                </tr>
                <tr>
                    <td><label for="type">할인 유형</label></td>
                    <td><select id="type" name="type" required>
                            <option value="이벤트">이벤트</option>
                            <option value="쿠폰">쿠폰</option>
                    </select></td>
                </tr>
                <tr>
                    <td><label for="discountType">할인 종류</label></td>
                    <td><select id="discountType" name="discountType" required>
                            <option value="P">퍼센트</option>
                            <option value="A">금액</option>
                    </select></td>
                </tr>
                <tr>
                    <td><label for="discountValue">할인 값</label></td>
                    <td><input type="number" id="discountValue" name="discountValue" required></td>
                </tr>
                <tr>
                    <td><label for="minPrice">최소 구매 금액</label></td>
                    <td><input type="number" id="minPrice" name="minPrice" required></td>
                </tr>
                <tr>
                    <td><label for="maxDiscount">최대 할인 금액</label></td>
                    <td><input type="number" id="maxDiscount" name="maxDiscount" required></td>
                </tr>
                <tr>
                    <td><label for="startDate">시작 날짜</label></td>
                    <td><input type="date" id="startDate" name="startDate" required></td>
                </tr>
                <tr>
                    <td><label for="endDate">종료 날짜</label></td>
                    <td><input type="date" id="endDate" name="endDate" required></td>
                </tr>
                <tr>
                    <td><label for="onsaleYn">진행 상태</label></td>
                    <td><select id="onsaleYn" name="onsaleYn" required>
                            <option value="Y">진행중</option>
                            <option value="N">종료</option>
                    </select></td>
                </tr>
                <tr>
                    <td colspan="2"><button type="submit" class="primary">등록</button></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
