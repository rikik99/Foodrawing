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

        .quantity {
            font-size: 1em;
            color: #777;
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
        
        .order-summary {
        	margin-top: 20px;
        }
        
        .sameAsOrder-elements {
            display: flex;
            align-items: center; /* 수직 정렬 */
            margin-top: 5px;
        }
        .sameAsOrder-elements label {
            margin-left: 8px; /* 체크박스와 레이블 사이의 간격 */
            margin-bottom: 0;
            padding: 0;
        }
        .sameAsOrder-elements input {
            width: 20px;
        }
        
        .extra-request {
            display: none;
            margin-top: 10px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/portone-js/dist/portone.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
            <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
            
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- iamport.payment.js -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipCode').value = data.zonecode;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                document.getElementById("address").value = roadAddr + " (" + data.jibunAddress + ")";
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
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
            <!-- 주문 정보 -->
            <!-- 주문자 정보 -->
            <div>
            <h3>주문자 정보</h3>
            <div class="form-group">
                <label for="customerName">주문자 이름</label>
                <input type="text" id="customerName" name="customerName" required>
            </div>
            <div class="form-group">
                <label for="customerPhone">휴대폰 번호</label>
                <input type="text" id="customerPhone" name="customerPhone" value="010-" required>
            </div>
            <div class="form-group">
                <label for="customerEmail">이메일</label>
                <input type="email" id="customerEmail" name="customerEmail" required>
            </div>
            </div>

            <!-- 배송지 설정 -->
            <div>
            <h3>배송지 설정</h3>
            <div class="form-group">
                <label for="deliverName">받는 분</label>
                <input type="text" id="deliverName" name="deliverName" required>
                <div class="sameAsOrder-elements">
	                <input type="checkbox" id="sameAsOrderer">
	                <label for="sameAsOrderer">주문자와 동일</label>
                </div>
            </div>
            <div class="form-group">
                <label for="zipCode">우편번호</label>
                <input type="text" id="zipCode" name="zipCode" placeholder="우편번호" required>
                <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
            </div>
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" placeholder="도로명주소" required>
            </div>
            <div class="form-group">
                <label for="detailAddress">상세 주소</label>
                <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" required>
            </div>
            <div class="form-group">
                <label for="customerPhone">휴대폰 번호</label>
                <input type="text" id="deliverPhone" name="deliverPhone" value="010-" required>
            </div>
            <div class="form-group">
                <label for="deliveryRequest">배송 요청 사항</label>
                <select id="deliveryRequest" name="deliveryRequest">
                    <option value="">선택하세요</option>
                    <option value="front">문 앞에 놔주세요</option>
                    <option value="security">경비실에 맡겨주세요</option>
                    <option value="call">배송 전에 전화주세요</option>
                    <option value="other">기타</option>
                </select>
            </div>
            <div class="form-group extra-request" id="extraRequest">
                <input type="text" id="extraRequestInput" name="extraRequestInput" placeholder="기타 요청 사항">
            </div>
            
<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
<span id="guide" style="color:#999;display:none"></span>
<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
            
            </div>

            <!-- 주문 상품 목록 -->
            <h3>주문 상품</h3>
            <c:forEach var="item" items="${cartItems}">
      					<input type="hidden" id="productNumber" name="productNumber" class="productNumber" value="${item.productNumber}">
                <div class="order-item">
                    <img src="${item.filePath}" alt="상품 이미지">
                    <div class="order-details">
                        <h2>${item.name}</h2>
                        <p>${item.description}</p>
                        <p class="quantity">수량: ${item.quantity}</p>
                    </div>
                    <div class="price">${item.price}원</div>
                    <c:if test="${item.discountType}">
                    	<div class="discountValue">할인: ${item.discountValue}원</div>
                    </c:if>
                    <input type="hidden" class="discountType" value="${item.discountType}">
                    <input type="hidden" class="discountValue" value="${item.discountValue}">
                    <input type="hidden" class="maxDiscount" value="${item.maxDiscount}">
                    <input type="hidden" class="minPrice" value="${item.minPrice}">
                </div>
            </c:forEach>
            
            <div class="order-summary">
                <h3>결제 수단 선택</h3>
                <div class="payment-methods">
                    <div class="payment-method" data-method="card">신용카드</div>
                    <div class="payment-method" data-method="vbank">가상계좌</div>
                    <div class="payment-method" data-method="phone">휴대폰 결제</div>
                    <div class="payment-method" data-method="tosspayments">토스페이</div>
                    <div class="payment-method" data-method="payco">페이코</div>
                    <div class="payment-method" data-method="kakaopay">카카오페이</div>
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
        var discount = 0;  // 서버에서 제공한 할인 금액
        var cartItems = document.querySelectorAll('.order-item');
        cartItems.forEach(function (item) {
            var priceElement = item.querySelector('.price');
            var quantityElement = item.querySelector('.quantity');
            var price = parseInt(priceElement.innerText.replace('원', '').replace(',', ''));
            var quantity = parseInt(quantityElement.innerText.replace('수량: ', ''));
            var discountType = document.querySelector('.discountType').value
    				var discountValue = document.querySelector('.discountValue').value
    				var maxDiscount = document.querySelector('.maxDiscount').value
    				var minPrice = document.querySelector('.minPrice').value
    				
    				//할인 계산
    				if (discountType === 'P') {
    					if(price * (discountValue * 0.01) > maxDiscount && maxDiscount != null) {
    						discount += maxDiscount
    					} else {
    						discount += price * (discountValue * 0.01)
    					}
    				} else if (discountType === 'A') {
    					discount += discountValue
    				}
    				
            total += price * quantity;
        });
        document.getElementById('totalPrice').innerText = total.toLocaleString() + '원';
        
        document.getElementById('discountPrice').innerText = discount.toLocaleString() + '원';
        
        var finalPrice = total - discount;
        document.getElementById('finalPrice').innerText = finalPrice.toLocaleString() + '원';
    });
    
    const userCode = "imp16305777"; // 고객사 식별코드로 변경해야 합니다
    IMP.init(userCode);

    function pay() {
    	var customerName = document.getElementById('customerName').value;
        var deliverName = document.getElementById('deliverName').value;
        const customerEmail = document.getElementById('customerEmail').value;
        var customerPhone = document.getElementById('customerPhone').value;
        var deliverPhone = document.getElementById('deliverPhone').value;
        const address = document.getElementById('address').value;
        const detailAddress = document.getElementById('detailAddress').value;
        const zipCode = document.getElementById('zipCode').value;
        const paymentMethod = document.querySelector('.payment-method.selected').getAttribute('data-method');
        const finalPrice = parseInt(document.getElementById('finalPrice').innerText.replace('원', '').replace(',', ''));
        var productNumbers = Array.from(document.querySelectorAll('.productNumber')).map(input => input.value);
        var discount = parseInt(document.getElementById('discountPrice').innerText.replace('원', '').replace(',', ''));


        if (paymentMethod === "card") {
        		const pgProviders = ["uplus.tlgdacomxpay", "danal_tpay.9810030929", "nice_v2.iamport00m", 'kicc.T5102001']; // Add other PG providers as needed
            var randomPgProvider = pgProviders[Math.floor(Math.random() * pgProviders.length)];

            IMP.request_pay({
            		//pg: randomPgProvider,
                pg: "kicc.T5102001",
                pay_method: "card",
                merchant_uid: 'merchant_' + new Date().getTime(),
                name: '주문명:결제테스트',
                amount: 500,
                buyer_email: customerEmail,
                buyer_name: customerName,
                buyer_tel: customerPhone,
                buyer_addr: address + ' ' + detailAddress,
                buyer_postcode: zipCode,
                m_redirect_url:  "{모바일에서 결제 완료 후 리디렉션 될 URL}", // 실제 리디렉션 URL로 변경해야 합니다
                appCard: true,
            }, function (rsp) {
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    console.log(rsp);
                    //window.location.href = '/orderSuccess';
                    
                    fetch('/payment/result', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            customerName: customerName,
                            deliverName: deliverName,
                            productNumbers: productNumbers,
                            customerEmail: customerEmail,
                            customerPhone: customerPhone,
                            deliverPhone: deliverPhone,
                            address: address,
                            detailAddress: detailAddress,
                            zipCode: zipCode,
                            paymentMethod: paymentMethod,
                            finalPrice: finalPrice,
                            discount: discount,
                        }),
                    })
                    .then(response => {
                        return response.text().then(text => {
                            try {
                                const json = JSON.parse(text);
                                return json;
                            } catch (error) {
                                console.error('서버 응답이 유효한 JSON이 아닙니다:', text);
                                throw new Error('서버 응답이 유효한 JSON이 아닙니다');
                            }
                        });
                    })
                    .then(data => {
                        console.log('주문 저장 성공:', data);
                    })
                    .catch(error => {
                        console.error('주문 저장 오류:', error);
                        alert('주문 저장 중 오류가 발생했습니다. 에러 메시지: ' + error.message);
                    });
                    
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                    console.log(rsp);
                }
            });
        } if (paymentMethod === "vbank") {
            var today = new Date();

            var year = today.getFullYear();
            var month = ('0' + (today.getMonth() + 1)).slice(-2);
            var day = ('0' + today.getDate()).slice(-2);

            var dateString = year + '-' + month  + '-' + day;

            IMP.request_pay(
            		  {
            		    pg: "nice_v2.iamport03m",
            		    pay_method: "vbank",
            		    merchant_uid: "orderNo0001",
            		    name: "주문명:결제테스트",
            		    amount: finalPrice,
            		    buyer_email: customerEmail,
                    buyer_name: customerName,
                    buyer_tel: customerPhone,
                    buyer_addr: address + ' ' + detailAddress,
                    buyer_postcode: zipCode,
            		    m_redirect_url: "{모바일에서 결제 완료 후 리디렉션 될 URL}",
            		    vbank_due: dateString,
            }, function (rsp) {
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = '/orderSuccess';
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
        } else if (paymentMethod === "phone") {
            const userCode = "imp16305777"; // 고객사 식별코드로 변경해야 합니다
            IMP.init(userCode);

            IMP.request_pay(
            		  {
            		    pg: "danal.A010002002",
            		    pay_method: "phone",
            		    merchant_uid: "order_no_0001", // 상점에서 생성한 고유 주문번호
            		    name: "주문명:결제테스트",
            		    amount: finalPrice,
            		    buyer_email: customerEmail,
                    buyer_name: customerName,
                    buyer_tel: customerPhone,
                    buyer_addr: address + ' ' + detailAddress,
                    buyer_postcode: zipCode,
            }, function (rsp) {
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = '/orderSuccess';
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
        } else if (paymentMethod === "tosspayments") {
            IMP.request_pay(
            		  {
            		    pg: "tosspay",
            		    pay_method: "card",
            		    merchant_uid: "order_no_0001", // 상점에서 생성한 고유 주문번호
            		    name: "주문명:결제테스트", // 필수 파라미터 입니다.
            		    amount: finalPrice,
            		    buyer_email: customerEmail,
                    buyer_name: customerName,
                    buyer_tel: customerPhone,
                    buyer_addr: address + ' ' + detailAddress,
                    buyer_postcode: zipCode,
            		    m_redirect_url: "{결제 완료 후 리디렉션 될 URL}",
            }, function (rsp) {
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = '/orderSuccess';
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
        } else if (paymentMethod === "payco") {
            IMP.request_pay(
            		  {
            		    pg: "payco.PARTNERTEST",
            		    merchant_uid: "order_no_0001", // 상점에서 관리하는 주문 번호
            		    name: "주문명:결제테스트",
            		    amount: finalPrice,
            		    buyer_email: customerEmail,
                    buyer_name: customerName,
                    buyer_tel: customerPhone,
                    buyer_addr: address + ' ' + detailAddress,
                    buyer_postcode: zipCode,
            }, function (rsp) {
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = '/orderSuccess';
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
        } else if (paymentMethod === "kakaopay") {
            IMP.request_pay(
            		  {
            		    pg: "kakaopay.TC0ONETIME",
            		    pay_method: "card", // 생략가
            		    merchant_uid: "order_no_0001", // 상점에서 생성한 고유 주문번호
            		    name: "주문명:결제테스트",
            		    amount: finalPrice,
            		    buyer_email: customerEmail,
                    buyer_name: customerName,
                    buyer_tel: customerPhone,
                    buyer_addr: address + ' ' + detailAddress,
                    buyer_postcode: zipCode,
            		    m_redirect_url: "{모바일에서 결제 완료 후 리디렉션 될 URL}",
            }, function (rsp) {
                if (rsp.success) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = '/orderSuccess';
                } else {
                    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
                }
            });
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
    
    //핸드폰 번호 처리   
    var customerPhoneEl = document.getElementById('customerPhone');
    var deliverPhoneEl = document.getElementById('deliverPhone');
        
    customerPhoneEl.addEventListener('input', function() {
    	var value = customerPhone.value.replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거

        if (value.length > 0 && !value.startsWith('010')) {
            value = '010' + value;
        }

        if (value.length > 3 && value.length <= 7) {
            value = value.slice(0, 3) + '-' + value.slice(3);
        } else if (value.length > 7) {
            value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7);
        }

        customerPhone.value = value;
    });
    
    deliverPhoneEl.addEventListener('input', function() {
    	var value = deliverPhone.value.replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거

        if (value.length > 0 && !value.startsWith('010')) {
            value = '010' + value;
        }

        if (value.length > 3 && value.length <= 7) {
            value = value.slice(0, 3) + '-' + value.slice(3);
        } else if (value.length > 7) {
            value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7);
        }

        deliverPhone.value = value;
    });
    
 // 주문자와 동일 체크박스 처리
    document.getElementById('sameAsOrderer').addEventListener('change', function () {
        if (this.checked) {
            document.getElementById('deliverName').value = document.getElementById('customerName').value;
            document.getElementById('deliverPhone').value = document.getElementById('customerPhone').value;
        } else {
            document.getElementById('deliverName').value = '';
            document.getElementById('deliverPhone').value = '010-';
        }
    });
 
 // 배송 요청 사항 기타 선택 시 텍스트 입력란 표시
    document.getElementById('deliveryRequest').addEventListener('change', function () {
        const extraRequest = document.getElementById('extraRequest');
        if (this.value === 'other') {
            extraRequest.style.display = 'block';
        } else {
            extraRequest.style.display = 'none';
        }
    });
</script>
</body>
</html>
