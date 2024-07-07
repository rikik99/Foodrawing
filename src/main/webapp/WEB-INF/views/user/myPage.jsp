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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
    cursor: pointer; /* 클릭 가능하도록 커서 추가 */
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
<script>
$(document).ready(function() {
    $('#couponBox').click(function() {
        var couponDetails = "<table class='table table-bordered'><thead><tr><th>쿠폰 번호</th><th>할인명</th><th>발행일</th></tr></thead><tbody>";
        <c:forEach var="coupon" items="${availableCoupons}">
            couponDetails += "<tr><td>${coupon.couponNumber}</td><td>${coupon.discountName}</td><td>${coupon.issuedAt}</td></tr>";
        </c:forEach>
        couponDetails += "</tbody></table>";
        $('#couponModal .modal-body').html(couponDetails);
        $('#couponModal').modal('show');
    });
});
</script>
</head>
<body>

<div style="position: relative;">
    <!-- 페이지 내용 -->
    <div class="main-content">
        <h1 style="text-align:center">${customer.name}님 반갑습니다</h1>
        <section>
            <div class="box">
                <div class="three-box-container">
                    <div class="three-box">
                        회원등급
                        <div class="three-box-number">1</div>
                    </div>
                    <div class="three-box">
                        적립금
                        <div class="three-box-number">${totalReserves}</div>
                    </div>
                    <div class="three-box" id="couponBox">
                        쿠폰
                        <div class="three-box-number">${couponCount}</div>
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

<!-- Bootstrap Modal -->
<div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="couponModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="couponModalLabel">사용 가능한 쿠폰</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- 쿠폰 내용이 여기 삽입됩니다 -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

</body>
<%@ include file="/WEB-INF/include/footer.jsp"%>
</html>
