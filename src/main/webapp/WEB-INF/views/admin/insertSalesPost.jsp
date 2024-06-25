<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/admin/common.css" />
    <link rel="stylesheet" href="/css/admin/salesPostAdd.css" />
    <script src="https://cdn.ckeditor.com/ckeditor5/35.0.1/classic/ckeditor.js"></script>
</head>
<body class="dark-mode">
    <div class="dashboard-container">
        <jsp:include page="/WEB-INF/views/admin/layout.jsp" />
        <div class="main-content dark-mode" id="mainContent">
            <form id="insertSalsePostForm" method="post" action="/admin/insertSalesPost" class="insertSalsePostForm dark-mode" enctype="multipart/form-data">
                <h1>판매글 등록</h1>
                <div class="full-width dark-mode">
                    <table class="form-table">
                        <tr>
                            <td><label for="productList">상품 카테고리</label></td>
                            <td>
                                <select id="productList" name="productList" class="productList">
                                    <option value="">전체</option>
                                    <c:forEach items="${productList}" var="product">
                                        <option value="${product.name}">${product.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="productNumber">상품 코드</label></td>
                            <td><input type="text" id="productNumber" name="productNumber" required="required" readonly="readonly" value="상품코드"></td>
                        </tr>
                        <tr>
                            <td><label for="title">제목</label></td>
                            <td><input type="text" id="title" name="title" required="required" value="" placeholder="제목을 입력해주세요."></td>
                        </tr>
                        <tr>
                            <td><label for="startPostDate">판매 개시 날짜</label></td>
                            <td><input type="date" id="startPostDate" name="startPostDate" required="required" value=""></td>
                        </tr>
                        <tr>
                            <td><label for="lastPostDate">판매 종료 날짜</label></td>
                            <td><input type="date" id="lastPostDate" name="lastPostDate" required="required" value=""></td>
                        </tr>
                        <tr>
                            <td><label for="preview">상품 미리보기</label></td>
                            <td><img alt="사진 미리보기" src="/images/FooDrawing_Logo.png" class="previewArea" style="height: 120px; width: auto;"></td>
                        </tr>
                        <tr>
                            <td><label for="description">상품 설명</label></td>
                            <td><textarea name="description" id="description" rows="10" cols="100" required="required"></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="2"><button type="submit" class="primary addBtn">상품 등록</button></td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
    </div>
    <button id="toggleMode" class="primary">Toggle Mode</button>
    <script src="<c:url value='/js/admin/productNumber.js'/>"></script>
    <script src="<c:url value='/js/admin/main.js'/>"></script>
    <script src="<c:url value='/js/admin/toggleMode.js'/>"></script>
    <script src="<c:url value='/js/admin/starRating.js'/>"></script>
    	<script src="<c:url value='/js/admin/UploadAdapter.js'/>"></script>
</body>
</html>
