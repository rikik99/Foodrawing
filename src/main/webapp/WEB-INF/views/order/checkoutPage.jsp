<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/common.css"/>
    <link rel="stylesheet" href="/css/sidebar.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header h1 {
            font-size: 2em;
            margin-bottom: 20px;
        }

        .order-container {
            display: flex;
            justify-content: space-between;
        }

        .order-info, .order-summary-box {
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .order-info {
            width: 65%;
        }

        .order-summary-box {
            width: 30%;
            position: sticky;
            top: 20px;
            height: fit-content;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: .5rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: .5rem;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
        }

        .order-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        .order-details {
            flex-grow: 1;
            margin-left: 20px;
        }

        .order-details h2 {
            font-size: 1.5em;
            margin: 0;
        }

        .order-details p {
            margin: 5px 0 0;
            color: #777;
        }

        .price {
            font-size: 1.2em;
            color: #333;
        }

        .order-total {
            text-align: right;
            margin-top: 20px;
        }

        .order-total span {
            font-size: 1.5em;
            font-weight: bold;
        }

        .btn-pay {
            width: 100%;
            padding: 10px;
            font-size: 1.2em;
            margin-top: 20px;
        }

        .payment-methods {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .payment-method {
            flex: 1 1 calc(33.333% - 10px);
            background-color: #f1f1f1;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
            padding: 20px;
            cursor: pointer;
        }

        .payment-method.selected {
            border-color: #007bff;
            background-color: #e7f3ff;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/portone-js/dist/portone.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/nav.jsp"%>
<%@include file="/WEB-INF/include/sidebar.jsp"%>

<div class="container">
    <div class="header">
        <h1>주문하기</h1>
    </div>
    <div class="order-container">
        <div class="order-info">
            <!-- 주문자 정보 -->
            <div class="form-group">
                <label for="customerName">주문자 이름</label>
                <input type="text" id="customerName" name="customerName">
            </div>
            <div class="form-group">
                <label for="customerEmail">이메일</label>
                <input type="email" id="customerEmail" name="customerEmail">
            </div>
            <div class="form-group">
                <label for="customerPhone">휴대폰 번호</label>
                <input type="tel" id="customerPhone" name="customerPhone">
            </div>

            <!-- 배송지 설정 -->
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address">
            </div>
            <div class="form-group">
                <label for="detailAddress">상세 주소</label>
                <input type="text" id="detailAddress" name="detailAddress">
            </div>
            <div class="form-group">
                <label for="zipCode">우편번호</label>
                <input type="text" id="zipCode" name="zipCode">
            </div>

            <!-- 주문 상품 목록 -->
            <h3>주문 상품</h3>
            <c:forEach var="item" items="${cartItems}">
                <div class="order-item">
                    <img src="${item.filePath}" alt="상품 이미지">
                    <div class="order-details">
                        <h2>${item.name}</h2>
                        <p>${item.description}</p>
                    </div>
                    <div class="price">${item.price}원</div>
                </div>
            </c:forEach>
            
            <div class="order-summary">
        <h2>결제 수단 선택</h2>
        <div class="payment-methods">
            <div class="payment-method" data-method="card">신용카드</div>
            <div class="payment-method" data-method="trans">실시간 계좌이체</div>
            <div class="payment-method" data-method="vbank">가상계좌</div>
            <div class="payment-method" data-method="phone">휴대폰결제</div>
            <div class="payment-method" data-method="tosspayments">토스페이</div>
            <div class="payment-method" data-method="naverpay">네이버페이</div>
            <div class="payment-method" data-method="samsungpay">삼성페이</div>
            <div class="payment-method" data-method="payco">페이코</div>
            <div class="payment-method" data-method="kakaopay">카카오페이</div>
            <div class="payment-method" data-method="smilepay">스마일페이</div>
            <div class="payment-method" data-method="cjpay">CJ PAY</div>
        </div>
        <div class="form-group">
            <label for="cardType">카드 종류</label>
            <select id="cardType" name="cardType">
                <option value="">카드 선택</option>
                <!-- 카드 종류 옵션 추가 -->
            </select>
        </div>
        <div class="form-group">
            <label for="installment">할부 선택</label>
            <select id="installment" name="installment">
                <option value="0">일시불</option>
                <!-- 할부 옵션 추가 -->
            </select>
        </div>
    </div>
        </div>

        <div class="order-summary-box">
            <h3>최종 결제 정보</h3>
            <div class="order-summary">
                <div class="order-total">
                    <span>상품금액: </span>
                    <span id="totalPrice">${totalPrice}원</span>
                </div>
                <div class="order-total">
                    <span>할인금액: </span>
                    <span id="discountPrice">${discountPrice}원</span>
                </div>
                <div class="order-total total-price">
                    <span>최종 결제금액: </span>
                    <span id="finalPrice">${finalPrice}원</span>
                </div>
            </div>
            <button class="btn btn-primary btn-pay" onclick="pay()">결제하기</button>
        </div>
    </div>

    
</div>

<%@include file="/WEB-INF/include/footer.jsp"%>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var total = 0;
        var cartItems = document.querySelectorAll('.order-item .price');
        cartItems.forEach(function (priceElement) {
            var price = parseInt(priceElement.innerText.replace('원', '').replace(',', ''));
            total += price;
        });
        document.getElementById('totalPrice').innerText = total.toLocaleString() + '원';
        
        var discount = 0;  // 서버에서 제공한 할인 금액
        document.getElementById('discountPrice').innerText = discount.toLocaleString() + '원';
        
        var finalPrice = total - discount;
        document.getElementById('finalPrice').innerText = finalPrice.toLocaleString() + '원';
    });

    function pay() {
        const customerName = document.getElementById('customerName').value;
        const customerEmail = document.getElementById('customerEmail').value;
        const customerPhone = document.getElementById('customerPhone').value;
        const address = document.getElementById('address').value;
        const detailAddress = document.getElementById('detailAddress').value;
        const zipCode = document.getElementById('zipCode').value;
        const paymentMethod = document.querySelector('.payment-method.selected').getAttribute('data-method');
        const finalPrice = parseInt(document.getElementById('finalPrice').innerText.replace('원', '').replace(',', ''));

        if (paymentMethod === "tosspayments") {
            const userCode = "YOUR_USER_CODE"; // 고객사 식별코드로 변경해야 합니다
            IMP.init(userCode);

            IMP.request_pay({
                pg: "tosspayments",
                pay_method: "card",
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: '주문명:결제테스트',
                amount: finalPrice,
                buyer_email: customerEmail,
                buyer_name: customerName,
                buyer_tel: customerPhone,
                buyer_addr: address + ' ' + detailAddress,
                buyer_postcode: zipCode,
                m_redirect_url: "https://helloworld.com/payments/result", // 실제 리디렉션 URL로 변경해야 합니다
                notice_url: "https://helloworld.com/api/v1/payments/notice",
                confirm_url: "https://helloworld.com/api/v1/payments/confirm",
                currency: "KRW",
                locale: "ko",
                custom_data: { userId: 30930 },
                display: { card_quota: [0, 6] },
                appCard: false,
                useCardPoint: true,
                bypass: {
                    tosspayments: {
                        useInternationalCardOnly: true
                    }
                }
            }, function (rsp) {
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = '/orderSuccess';
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
        } else {
            // 다른 결제 방식 처리 로직 추가
        }
    }

    // 결제 수단 선택 처리
    document.querySelectorAll('.payment-method').forEach(function (method) {
        method.addEventListener('click', function () {
            document.querySelectorAll('.payment-method').forEach(function (m) {
                m.classList.remove('selected');
            });
            method.classList.add('selected');
        });
    });
</script>
</body>
</html>
