<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 첫화면</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ include file="/WEB-INF/include/header.jsp"%>
<%@ include file="/WEB-INF/include/nav.jsp"%>
<%@ include file="/WEB-INF/include/mypageSidebar.jsp"%>
<style>
/* 메인 컨텐츠 */
.main-content {
    margin-left: 220px; /* 사이드바 너비 + 여백 */
    padding: 20px;
    position: relative;
}

.circle-container {
    display: flex;
    padding-left: 50px;
    align-items: center;
    margin-top: 50px;
}

.circle-item {
    text-align: center;
    margin: 0 15px;
}

.circle {
    width: 70px;
    height: 70px;
    background-color: gray;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-size: 18px;
    font-weight: bold;
    margin-top: 10px; /* 텍스트와 동그라미 사이의 간격 */
}

.box {
    display: flex;
    flex-direction: column; /* 세로 배치로 변경 */
    align-items: center;
    width: 100%; /* 전체 너비 사용 */
}

.three-box-container {
    display: flex;
    justify-content: space-between;
    width: 50%; /* 적당한 너비로 조정 */
    margin-top: 50px;
    padding-left: 50px;
}

.three-box {
    width: 30%;
    height: 100px;
    background-color: white;
    border: 1px solid #ccc;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    font-size: 16px;
    position: relative;
}

.three-box-number {
    margin-top: 10px;
    font-size: 24px;
    font-weight: bold;
    color: gray;
}

.section-divider {
    border: 0;
    height: 1px;
    background: #ccc;
    margin: 40px 0; /* 위 아래로 여백을 줘서 좀 더 분리된 느낌 */
}
</style>
</head>
<body>

<div style="position: relative;">
    <!-- 페이지 내용 -->
    <div class="main-content">
        <h1>${customer.name}님 반갑습니다</h1>
        <section>
            <div class="box">
                <div class="three-box-container">
                    <div class="three-box">
                        회원등급
                        <div class="three-box-number">1</div>
                    </div>
                    <div class="three-box">
                        적립금
                        <div class="three-box-number">2</div>
                    </div>
                    <div class="three-box">
                        쿠폰
                        <div class="three-box-number">3</div>
                    </div>
                </div>
                <div class="circle-container">
                    <div class="circle-item">
                        <div>입금대기</div>
                        <div class="circle">1</div>
                    </div>
                    <div class="circle-item">
                        <div>결제완료</div>
                        <div class="circle">2</div>
                    </div>
                    <div class="circle-item">
                        <div>배송준비중</div>
                        <div class="circle">3</div>
                    </div>
                    <div class="circle-item">
                        <div>배송중</div>
                        <div class="circle">4</div>
                    </div>
                    <div class="circle-item">
                        <div>배송완료</div>
                        <div class="circle">5</div>
                    </div>
                </div>
            </div>
        </section>
        
        <hr class="section-divider">
        
        <section>
            <div style="text-align:center;">여기다 위시리스트</div>
        </section>
    </div>
</div>

</body>
<%@ include file="/WEB-INF/include/footer.jsp"%>
</html>
