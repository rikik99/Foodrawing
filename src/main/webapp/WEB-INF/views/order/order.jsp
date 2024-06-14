<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/common.css" />
    <link rel="stylesheet" href="/css/sidebar.css" />
    <style>

        .order-container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
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
            border: 1px solid #ccc;
            background-color: #fff;
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
                    <button onclick="changeQuantity(${item.productNumber}, -1)">-</button>
                    <input type="text" value="${item.quantity}" size="2" readonly>
                    <button onclick="changeQuantity(${item.productNumber}, 1)">+</button>
                </div>
                <div class="price">${item.price}원</div>
                <button class="btn-update" onclick="updateCartItem(${item.productNumber})">수정</button>
                <button class="btn-delete" onclick="deleteCartItem(${item.productNumber})">삭제</button>
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
        </div>
        
        <!-- 최근 본 상품 -->
        <div class="order-recently-viewed">
            <h2>최근 본 상품</h2>
            <c:forEach var="item" items="${recentlyViewedItems}">
                <div class="order-item">
                    <img src="${item.image}" alt="상품 이미지">
                    <p>${item.title}</p>
                </div>
            </c:forEach>
        </div>
        
        <%@include file="/WEB-INF/include/footer.jsp" %>
        
    </div>

    <script>
    function changeQuantity(itemId, amount) {
        const quantityInput = document.querySelector(`.order-cart-item[data-item-id='${itemId}'] .order-quantity input`);
        if (quantityInput) {
            let newQuantity = parseInt(quantityInput.value) + amount;

            if (newQuantity < 1) {
                newQuantity = 1;
            }

            quantityInput.value = newQuantity;
        } else {
            console.error('수량 입력 필드를 찾을 수 없습니다: ' + itemId);
        }
    }

    function updateCartItem(itemId) {
        const quantityInput = document.querySelector(`.order-cart-item[data-item-id='${itemId}'] .order-quantity input`);
        if (quantityInput) {
            const newQuantity = parseInt(quantityInput.value);

            fetch('/updateCartItem', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    itemId: itemId,
                    quantity: newQuantity
                }),
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('수량 업데이트 실패: ' + itemId);
                }
                return response.json();
            })
            .then(data => {
                calculateTotal();
            })
            .catch(error => {
                console.error('수량 업데이트 오류:', error);
            });
        } else {
            console.error('수량 입력 필드를 찾을 수 없습니다: ' + itemId);
        }
    }

    function deleteCartItem(itemId) {
        fetch('/deleteCartItem', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                itemId: itemId
            }),
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('장바구니에서 삭제 실패: ' + itemId);
            }
            return response.json();
        })
        .then(data => {
            const cartItem = document.querySelector(`.order-cart-item[data-item-id='${itemId}']`);
            cartItem.remove();
            calculateTotal();
        })
        .catch(error => {
            console.error('삭제 오류:', error);
        });
    }

    function deleteSelectedItems() {
        const selectedItems = document.querySelectorAll('.select-item:checked');
        selectedItems.forEach(item => {
            const itemId = item.closest('.order-cart-item').getAttribute('data-item-id');
            deleteCartItem(itemId);
        });
    }

    function checkoutSelectedItems() {
        const selectedItems = document.querySelectorAll('.select-item:checked');
        const selectedIds = Array.from(selectedItems).map(item => item.closest('.order-cart-item').getAttribute('data-item-id'));

        fetch('/checkout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                itemIds: selectedIds
            }),
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('선택된 항목 결제 실패');
            }
            return response.json();
        })
        .then(data => {
            window.location.href = '/checkoutSuccess';
        })
        .catch(error => {
            console.error('결제 오류:', error);
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
        cartItems.forEach(function(item) {
            var priceElement = item.querySelector('.price');
            var quantityElement = item.querySelector('.order-quantity input');
            var price = parseInt(priceElement.innerText.replace('원', '').replace(',', ''));
            var quantity = parseInt(quantityElement.value);
            total += price * quantity;
        });
        document.getElementById('total-price').innerText = '총 금액: ' + total.toLocaleString() + '원';
    }

    document.addEventListener('DOMContentLoaded', function() {
        calculateTotal();
    });
    </script>
  
</body>
</html>
