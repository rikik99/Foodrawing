<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/common.css"/>
    <link rel="stylesheet" href="/css/sidebar.css"/>
    <style>
        .order-container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            border-radius: 10px;
        }

        .header h1 {
            font-size: 2em;
            margin-bottom: 20px;
        }

        .order-cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
        }

        .order-cart-item img {
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

        .order-quantity {
            display: flex;
            align-items: center;
        }

        .order-quantity button {
            width: 30px;
            height: 30px;
            background-color: #fff;
            border: none;
            cursor: pointer;
        }

        .order-quantity input {
            width: 50px;
            text-align: center;
            border: 1px solid #ccc;
            margin: 0 10px;
        }

        .price {
            font-size: 1.2em;
            color: #333;
            margin-right: 10px;
        }

        .btn-update, .btn-delete {
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn-update {
            background-color: #007bff;
            color: #fff;
            margin-right: 10px;
        }

        .btn-delete {
            background-color: #dc3545;
            color: #fff;
        }

        .order-total, .order-actions {
            text-align: right;
            margin-top: 20px;
        }

        .order-total span {
            font-size: 1.5em;
            font-weight: bold;
        }

        .order-recently-viewed {
            margin-top: 40px;
        }

        .order-recently-viewed h2 {
            font-size: 1.8em;
            margin-bottom: 20px;
        }

        .order-recently-viewed .order-item {
            display: inline-block;
            width: 23%;
            margin: 1%;
            text-align: center;
        }

        .order-recently-viewed .order-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp"%>
<%@include file="/WEB-INF/include/nav.jsp"%>
<%@include file="/WEB-INF/include/sidebar.jsp"%>

<div class="order-container">
    <div class="header">
        <h1>장바구니</h1>
    </div>

    <!-- 모두 선택 체크박스 -->
    <div>
        <input type="checkbox" id="select-all" onclick="toggleSelectAll(this)"> 모두 선택
    </div>

    <!-- 장바구니 아이템 -->
    <c:forEach var="item" items="${cartItems}">
        <div class="order-cart-item" data-item-id="${item.productNumber}">
            <input type="checkbox" class="select-item">
            <img src="${item.filePath}" alt="상품 이미지">
            <div class="order-details">
                <h2>${item.name}</h2>
                <p>${item.description}</p>
            </div>
            <div class="order-quantity">
                <button type="button" data-product-id="${item.productNumber}" onclick="changeQuantity(this, -1)">-</button>
                <input type="text" value="${item.quantity}" size="2" readonly>
                <button type="button" data-product-id="${item.productNumber}" onclick="changeQuantity(this, 1)">+</button>
            </div>
            <div class="price">${item.price}원</div>
            <button class="btn-update" type="button" data-product-id="${item.productNumber}" onclick="updateCartItem(this)">수정</button>
            <button class="btn-delete" type="button" data-product-id="${item.productNumber}" onclick="deleteCartItem(this)">삭제</button>
        </div>
    </c:forEach>

    <!-- 합계 -->
    <div class="order-total">
        <span id="total-price">총 금액: 0원</span>
    </div>

    <!-- 결제 및 삭제 버튼 -->
    <div class="order-actions">
        <button class="btn btn-danger" onclick="deleteSelectedItems()">선택 삭제</button>
        <button class="btn btn-primary" onclick="checkoutSelectedItems()">선택 결제</button>
        <button class="btn btn-success" onclick="checkoutAllItems()">전체 주문</button>
    </div>

    <!-- 최근 본 상품 -->
    <div class="order-recently-viewed">
        <h2>최근 본 상품</h2>
        <c:forEach var="item" items="${sessionScope.recentViewedProducts}">
            <div class="order-item">
                <a href="/product/${item.id}">
                    <img src="${item.imagePath}" alt="${item.name}">
                    <p>${item.name}</p>
                </a>
            </div>
        </c:forEach>
    </div>

    <%@include file="/WEB-INF/include/footer.jsp"%>

</div>

<script>
function changeQuantity(button, amount) {
    var productId = button.getAttribute('data-product-id');
    var quantityInput = document.querySelector('.order-cart-item[data-item-id="' + productId + '"] .order-quantity input');
    if (quantityInput) {
        var newQuantity = parseInt(quantityInput.value) + amount;

        if (newQuantity < 1) {
            newQuantity = 1;
        }

        quantityInput.value = newQuantity;
    } else {
        console.error('수량 입력 필드를 찾을 수 없습니다: ' + productId);
    }
}

function updateCartItem(button) {
    var productId = button.getAttribute('data-product-id');
    var quantityInput = document.querySelector('.order-cart-item[data-item-id="' + productId + '"] .order-quantity input');
    if (quantityInput) {
        var newQuantity = parseInt(quantityInput.value);
        var customerId = 1/* 고객 ID를 적절히 넣어야 합니다 */;

        fetch('/cart/updateCartItem', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                customerId: customerId,
                productNumber: productId,
                quantity: newQuantity
            }),
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('수량 업데이트 실패: ' + productId);
            }
            return response.json();
        })
        .then(data => {
            alert('수량이 성공적으로 업데이트되었습니다.');
            calculateTotal();
        })
        .catch(error => {
            console.error('수량 업데이트 오류:', error);
            alert('수량 업데이트 중 오류가 발생했습니다.');
        });
    } else {
        console.error('수량 입력 필드를 찾을 수 없습니다: ' + productId);
    }
}

function deleteCartItem(button) {
    var productId = button.getAttribute('data-product-id');
    var customerId = 1; // 고객 ID를 적절히 넣어야 합니다
    
    fetch('/cart/deleteCartItem', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            customerId: customerId,
            productNumber: productId
        }),
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(data => {
                throw new Error(data.message || '장바구니에서 삭제 실패: ' + productId);
            });
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            var cartItem = document.querySelector('.order-cart-item[data-item-id="' + productId + '"]');
            cartItem.remove();
            alert('항목이 성공적으로 삭제되었습니다.');
            calculateTotal();
        } else {
            throw new Error(data.message || '삭제에 문제가 발생했습니다.');
        }
    })
    .catch(error => {
        console.error('삭제 오류:', error);
        alert('항목 삭제 중 오류가 발생했습니다. 에러 메시지: ' + error.message);
    });
}

function deleteSelectedItems() {
    var selectedItems = document.querySelectorAll('.select-item:checked');
    var customerId = 1/* 고객 ID를 적절히 넣어야 합니다 */;
    selectedItems.forEach(item => {
        var productId = item.closest('.order-cart-item').getAttribute('data-item-id');
        deleteCartItem(productId);
    });
}

function checkoutSelectedItems() {
    var selectedItems = document.querySelectorAll('.select-item:checked');
    var selectedIds = Array.from(selectedItems).map(item => item.closest('.order-cart-item').getAttribute('data-item-id'));
    var customerId = 1; // 고객 ID를 적절히 넣어야 합니다

    fetch('/order/prepareCheckout', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            customerId: customerId,
            productIds: selectedIds
        }),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('선택된 항목 결제 준비 실패');
        }
        return response.json();
    })
    .then(data => {
        // GET 요청에 필요한 URL 파라미터를 구성
        var params = new URLSearchParams();
        params.append('customerId', customerId);
        selectedIds.forEach(id => params.append('productIds', id));
        window.location.href = '/checkoutPage?' + params.toString();
    })
    .catch(error => {
        console.error('결제 준비 오류:', error);
        alert('결제 준비 중 오류가 발생했습니다.');
    });
}

function checkoutAllItems() {
<<<<<<< HEAD
    var customerId = 1/* 고객 ID를 적절히 넣어야 합니다 */;
=======
    var customerId = 1; // 고객 ID를 적절히 넣어야 합니다
    var cartItems = document.querySelectorAll('.order-cart-item');
    var productIds = Array.from(cartItems).map(item => item.getAttribute('data-item-id'));
    
    if (productIds.length === 0) {
        alert('장바구니에 담긴 항목이 없습니다.');
        return;
    }

>>>>>>> branch 'develop' of https://github.com/rikik99/Foodrawing.git
    fetch('/order/prepareCheckoutAll', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            customerId: customerId,
            productIds: productIds
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('전체 항목 결제 준비 실패');
        }
        return response.json().catch(() => ({}));  // 빈 JSON 응답을 허용
    })
    .then(data => {
        var params = new URLSearchParams();
        params.append('customerId', customerId);
        productIds.forEach(id => params.append('productIds', id));
        window.location.href = '/checkoutPage?' + params.toString();
    })
    .catch(error => {
        console.error('결제 준비 오류:', error);
        alert('결제 준비 중 오류가 발생했습니다.');
    });
}

function toggleSelectAll(selectAllCheckbox) {
    const selectItems = document.querySelectorAll('.select-item');
    selectItems.forEach(item => {
        item.checked = selectAllCheckbox.checked;
    });
}

function calculateTotal() {
    var total = 0;
    var cartItems = document.querySelectorAll('.order-cart-item');
    cartItems.forEach(function (item) {
        var priceElement = item.querySelector('.price');
        var quantityElement = item.querySelector('.order-quantity input');
        var price = parseInt(priceElement.innerText.replace('원', '').replace(',', ''));
        var quantity = parseInt(quantityElement.value);
        total += price * quantity;
    });
    document.getElementById('total-price').innerText = '총 금액: ' + total.toLocaleString() + '원';
}

document.addEventListener('DOMContentLoaded', function () {
    calculateTotal();
});
</script>
</body>
</html>
