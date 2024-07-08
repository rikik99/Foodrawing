<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/admin/common.css" />
<link rel="stylesheet" href="/css/admin/consolidated.css" />
<script src="<c:url value='/js/admin/adminForm.js'/>"></script>
</head>
<body class="dark-mode">
    <div class="admin-form-container">
        <form id="adminForm" method="post" action="/admin/createAdmin" class="adminForm">
            <h1>관리자 추가</h1>
            <table class="form-table">
                <tr>
                    <td><label for="username">아이디</label></td>
                    <td><input type="text" id="username" name="username" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><div id="usernameFeedback" class="feedback"></div></td>
                </tr>
                <tr>
                    <td><label for="password">비밀번호</label></td>
                    <td><input type="password" id="password" name="password" required></td>
                </tr>
                <tr>
                    <td><label for="confirmPassword">비밀번호 확인</label></td>
                    <td><input type="password" id="confirmPassword" name="confirmPassword" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><div id="passwordFeedback" class="feedback"></div></td>
                </tr>
                <tr>
                    <td><label for="name">이름</label></td>
                    <td><input type="text" id="name" name="name" required></td>
                </tr>
                <tr>
                    <td><label for="accessLevel">관리자 레벨</label></td>
                    <td>
                        <select id="accessLevel" name="accessLevel" required>
                            <option value="">선택하세요</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><button type="submit" id="submitButton" class="primary" disabled>관리자 추가</button></td>
                </tr>
            </table>
        </form>
    </div>
     <script src="<c:url value='/js/admin/productNumber.js'/>"></script>
</body>
</html>
