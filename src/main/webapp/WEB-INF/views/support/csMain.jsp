<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/sidebar.css">
    <style>
        .content-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .search-bar input {
            width: 60%;
            border: 1px solid #ccc;
            border-right: none;
        }
        .search-bar button {
            border: 1px solid #ccc;
            background-color: #5dad52;
            margin-left: 10px;
        }
        .filter-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .filter-bar button {
            margin: 0 5px;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            padding: 10px 20px;
        }
        .filter-bar button.active {
            background-color: #5dad52;
            color: #fff;
        }
        .faq-item {
            cursor: pointer;
            border-bottom: 1px solid #e0e0e0;
            padding: 15px 10px;
            display: flex;
            flex-direction: column;
            background-color: #f8f8f8;
        }
        .faq-item h5 {
            margin: 0;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #000; /* 글씨 색상 유지 */
        }
        .faq-answer {
            display: none;
            padding: 10px 0;
            color: black;
        }
        .faq-item.active {
            background-color: #e0e0e0;
        }
        .faq-item.active .arrow {
            transform: rotate(-90deg); /* 위 화살표로 변경 */
        }
        .arrow {
            transform: rotate(90deg); /* 아래 화살표로 기본 상태 */
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
        .pagination .page-item.disabled .page-link {
            color: #ccc;
            pointer-events: none;
        }
        .arrow img {
            width: 20px;
        }
    </style>
</head>
<body>
<div class="header-wrap">
    <%@include file="/WEB-INF/include/header.jsp"%>
    <%@include file="/WEB-INF/include/nav.jsp"%>
</div>

<div class="content-wrapper">
    <div class="filter-bar">
        <button data-filter="제품">제품</button>
        <button data-filter="주문">주문/결제/정정</button>
        <button data-filter="결제">포인트/쿠폰</button>
        <button data-filter="배송">배송</button>
        <button data-filter="취소">취소/교환/반품</button>
        <button data-filter="교환">회원</button>
    </div>
    <div class="search-bar">
        <input type="text" id="searchQuery" class="form-control" placeholder="궁금하신 사항을 입력해주세요...">
        <button id="searchButton" class="btn btn-primary">검색</button>
    </div>
    <div id="faqList" class="list-group">
        <!-- FAQ 리스트가 여기에 비동기적으로 추가됩니다 -->
    </div>
    <nav aria-label="Page navigation">
        <ul id="pagination" class="pagination">
            <!-- 페이지네이션 버튼이 여기에 비동기적으로 추가됩니다 -->
        </ul>
    </nav>
</div>

<%@include file="/WEB-INF/include/sidebar.jsp"%>
<%@include file="/WEB-INF/include/footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/cs/faq.js"></script>
</body>
</html>
