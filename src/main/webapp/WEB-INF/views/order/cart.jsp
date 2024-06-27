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
            position: relative;
        }

        .order-cart-item .img-container {
            position: relative;
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
        .select-item {
            margin-right: 5px;
        }

        /* 품절 표시 스타일 */
        .sold-out-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100px;
            height: 100px;
            background: rgba(0, 0, 0, 0.5);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2em;
            border-radius: 5px;
        }
        
        .btn-container {
            display: flex;
            align-items: center;
        }

        .btn-placeholder {
            width: 80px;
            height: 20px;
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
            <input type="checkbox" class="select-item" onclick="toggleSelectItem()">
            <div class="img-container">
                <img src="${item.filePath}" alt="상품 이미지">
                <c:if test="${item.productQuantity == 0}">
                    <div class="sold-out-overlay">품절</div>
                </c:if>
            </div>
            <div class="order-details">
                <input type="hidden" id="salesPostId" class="salesPostId" name="salesPostId" value="${item.salesPostId}">
                <h2>${item.name}</h2>
                <p>${item.description}</p>
            </div>
            <div class="order-quantity">
                <button type="button" data-product-number="${item.productNumber}" onclick="changeQuantity(this, -1)">-</button>
                <input type="text" class="quantity" value="${item.quantity}" size="2" readonly>
                <input type="hidden" class="productQuantity" value="${item.productQuantity}">
                <button type="button" data-product-number="${item.productNumber}" onclick="changeQuantity(this, 1)">+</button>
            </div>
            <div class="price">${item.price}원</div>
            <div class="btn-container">
                <c:if test="${item.productQuantity > 0}">
                    <button class="btn-update" type="button" data-product-number="${item.productNumber}" data-product-quantity="${item.productQuantity}" onclick="updateCartItem(this)">수정</button>
                </c:if>
                <c:if test="${item.productQuantity == 0}">
                    <div class="btn-placeholder"></div>
                </c:if>
            </div>
            <button class="btn-delete" type="button" data-product-number="${item.productNumber}" onclick="deleteCartItem(this)">삭제</button>
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
    var productNumber = button.getAttribute('data-product-number');
    var quantityInput = document.querySelector('.order-cart-item[data-item-id="' + productNumber + '"] .order-quantity .quantity');
    if (quantityInput) {
        var newQuantity = parseInt(quantityInput.value) + amount;

        if (newQuantity < 1) {
            newQuantity = 1;
        }

        quantityInput.value = newQuantity;
    } else {
        console.error('수량 입력 필드를 찾을 수 없습니다: ' + productNumber);
    }
}

function updateCartItem(button) {
    var productNumber = button.getAttribute('data-product-number');
    var quantityInput = document.querySelector('.order-cart-item[data-item-id="' + productNumber + '"] .order-quantity .quantity');
    var productQuantity = parseInt(button.getAttribute('data-product-quantity'));

    if (quantityInput) {
        var newQuantity = parseInt(quantityInput.value);

        if (newQuantity > productQuantity) {
            alert('재고가 부족합니다.');
            return;
        }

        var customerId = 1; // 고객 ID를 적절히 넣어야 합니다

        fetch('/cart/updateCartItem', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                customerId: customerId,
                productNumber: productNumber,
                quantity: newQuantity
            }),
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('수량 업데이트 실패: ' + productNumber);
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
        console.error('수량 입력 필드를 찾을 수 없습니다: ' + productNumber);
    }
}

function deleteCartItem(button) {
    var productNumber = button.getAttribute('data-product-number');
    var customerId = 1; // 고객 ID를 적절히 넣어야 합니다

    fetch('/cart/deleteCartItem', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            customerId: customerId,
            productNumber: productNumber
        }),
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(data => {
                throw new Error(data.message || '장바구니에서 삭제 실패: ' + productNumber);
            });
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            var cartItem = document.querySelector('.order-cart-item[data-item-id="' + productNumber + '"]');
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
    var customerId = 1; // 고객 ID를 적절히 넣어야 합니다

    selectedItems.forEach(item => {
        var productNumber = item.closest('.order-cart-item').getAttribute('data-item-id');
        deleteCartItem(document.querySelector('.order-cart-item[data-item-id="' + productNumber + '"] .btn-delete'));
    });
}

function checkoutSelectedItems() {
    var selectedItems = document.querySelectorAll('.select-item:checked');
    var selectedIds = Array.from(selectedItems).map(item => item.closest('.order-cart-item').getAttribute('data-item-id'));
    var customerId = 1; // 고객 ID를 적절히 넣어야 합니다

    if (selectedIds.length === 0) {
        alert('선택된 항목이 없습니다.');
        return;
    }

    var soldOutItems = document.querySelectorAll('.order-cart-item .sold-out-overlay');
    var hasSoldOut = false;
    var insufficientStock = false;

    selectedItems.forEach(item => {
        var productNumber = item.closest('.order-cart-item').getAttribute('data-item-id');
        var productQuantity = parseInt(item.closest('.order-cart-item').querySelector('.productQuantity').value);
        var quantity = parseInt(item.closest('.order-cart-item').querySelector('.quantity').value);
        if (productQuantity == 0) {
            hasSoldOut = true;
        }
        if (quantity > productQuantity) {
            insufficientStock = true;
        }
    });

    if (hasSoldOut) {
        alert('품절된 상품이 있습니다.');
        return;
    }

    if (insufficientStock) {
        alert('재고가 부족한 상품이 있습니다.');
        return;
    }

    fetch('/order/prepareCheckout', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            customerId: customerId,
            productNumbers: selectedIds
        }),
    })
    .then(response => response.json())
    .then(data => {
        if (!data.success) {
            alert('품절된 상품이 있습니다.');
            return;
        }
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
    var customerId = 1; // 고객 ID를 적절히 넣어야 합니다
    var cartItems = document.querySelectorAll('.order-cart-item');
    var productNumber = Array.from(cartItems).map(item => item.getAttribute('data-item-id'));

    if (productNumber.length === 0) {
        alert('장바구니에 담긴 항목이 없습니다.');
        return;
    }

    var soldOutItems = document.querySelectorAll('.order-cart-item .sold-out-overlay');
    var hasSoldOut = false;
    var insufficientStock = false;

    cartItems.forEach(item => {
        var productQuantity = parseInt(item.querySelector('.productQuantity').value);
        var quantity = parseInt(item.querySelector('.quantity').value);
        if (productQuantity == 0) {
            hasSoldOut = true;
        }
        if (quantity > productQuantity) {
            insufficientStock = true;
        }
    });

    if (hasSoldOut) {
        alert('품절된 상품이 있습니다.');
        return;
    }

    if (insufficientStock) {
        alert('재고가 부족한 상품이 있습니다.');
        return;
    }

    fetch('/order/prepareCheckoutAll', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            customerId: customerId,
            productNumbers: productNumber
        })
    })
    .then(response => response.json())
    .then(data => {
        if (!data.success) {
            alert('품절된 상품이 있습니다.');
            return;
        }
        var params = new URLSearchParams();
        params.append('customerId', customerId);
        productNumber.forEach(id => params.append('productNumbers', id));
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

function toggleSelectItem() {
    const selectAllCheckbox = document.getElementById('select-all');
    const selectItems = document.querySelectorAll('.select-item');
    const allSelected = Array.from(selectItems).every(item => item.checked);
    selectAllCheckbox.checked = allSelected;
}

function calculateTotal() {
    var total = 0;
    var cartItems = document.querySelectorAll('.order-cart-item');
    cartItems.forEach(function (item) {
        var priceElement = item.querySelector('.price');
        var quantityElement = item.querySelector('.quantity');
        var price = parseInt(priceElement.innerText.replace('원', '').replace(',', ''));
        var quantity = parseInt(quantityElement.value);
        var productQuantity = parseInt(item.querySelector('.productQuantity').value)
        if(productQuantity > 0) {
            total += price * quantity;
        }
    });
    document.getElementById('total-price').innerText = '총 금액: ' + total.toLocaleString() + '원';
}

document.addEventListener('DOMContentLoaded', function () {
    calculateTotal();
    const selectItems = document.querySelectorAll('.select-item');
    selectItems.forEach(item => {
        item.addEventListener('click', toggleSelectItem);
    });
});
</script>
</body>
</html>
