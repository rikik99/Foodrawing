<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 첫화면</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%@ include file="/WEB-INF/include/header.jsp" %>
    <%@ include file="/WEB-INF/include/nav.jsp" %>
<style>
/* 사이드바 스타일 */
.sidebar {
    width: 200px;
    height: 100vh;
    background-color: white;
    padding-top: 150px;
    box-shadow: 2px 0 5px rgba(0,0,0,0.1);
    position: absolute;
    top: 0;
    left: 0;
}
.sidebar .list-group-item {
    margin-bottom: 10px;
}
.sidebar a {
    text-decoration: none;
}

/* 메인 컨텐츠 */
.main-content {
    margin-left: 220px; /* 사이드바 너비 + 여백 */
    padding: 20px;
    position: relative;
}
</style>
</head>
<body>
<div style="position: relative;">
    <!-- 사이드 바 -->
    <div class="sidebar">
        <div class="list-group">
            <a href="/Users/Info?user_id=${ sessionScope.plogin.user_id }"
                class="list-group-item shadow">개인정보</a>
            <a href="/Users/ResumeForm?user_id=${ sessionScope.plogin.user_id }"
                class="list-group-item shadow">주문/배송조회</a>
            <a href="/Users/ApplyList?user_id=${ sessionScope.plogin.user_id }"
                class="list-group-item shadow">취소/교환/반품</a>
            <a href="/Users/BookmarkList?user_id=${ sessionScope.plogin.user_id }"
                class="list-group-item shadow">설정/알림</a>
        </div>
    </div> 

    <!-- 페이지 내용 -->
    <div class="main-content">
        <h1>${customer.name}님 반갑습니다</h1>
    </div>
</div>

<%@ include file="/WEB-INF/include/footer.jsp" %>

</body>
</html>
