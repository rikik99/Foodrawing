<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
/* 사이드바 스타일 */
.sidebar {
    width: 200px;
    height: 100vh;
    position: absolute;
    background-color: white;
    padding-top: 50px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    top: 200px; /* header와 nav의 높이를 고려해서 조정 */
    left: 0;
    z-index: 1000; /* 다른 요소 위에 오도록 z-index 조정 */
}

.sidebar .list-group-item {
    margin-bottom: 10px;
}

.sidebar a {
    text-decoration: none;
}
</style>

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
