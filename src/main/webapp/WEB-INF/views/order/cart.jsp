<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/common.css" />
<link rel="stylesheet" href="/css/sidebar.css" />
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

.original-price {
	font-size: 1em;
	color: gray;
	text-decoration: line-through;
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

.product-card {
	display: inline-block;
	width: 23%;
	margin: 1%;
	text-align: center;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 5px;
	overflow: hidden;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	position: relative;
}

.product-card .product-top {
	position: relative;
}

.product-card img {
	width: 100%;
	height: auto;
}

.product-card .badge {
	position: absolute;
	top: 10px;
	left: 10px;
	background-color: #f00;
	color: #fff;
	padding: 5px;
	border-radius: 5px;
	font-size: 0.9em;
}

.product-card .cart-icon {
	position: absolute;
	bottom: 10px;
	right: 10px;
	width: 40px;
	height: 40px;
	background-color: white;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.product-card .cart-icon:hover {
	cursor: pointer;
}

.product-card .cart-icon img {
	width: 60%;
	height: 60%;
}

.product-card .product-details {
	padding: 10px;
}

.product-card .product-title {
	font-size: 1.1em;
	margin-bottom: 5px;
}

.product-card .product-price {
	font-size: 1.2em;
	color: #333;
}

.product-card .product-old-price {
	font-size: 1em;
	color: gray;
	text-decoration: line-through;
}

.product-card .product-discount {
	font-size: 1em;
	color: #f00;
}

.product-card .product-rating {
	font-size: 0.9em;
	color: #777;
}

.product-card .delivery-info {
	font-size: 0.9em;
	color: #555;
}

.product-card .refrigeration-info {
	font-size: 0.9em;
	color: #555;
}
</style>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="js/guestorder/guestid.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%@include file="/WEB-INF/include/nav.jsp"%>
	<%@include file="/WEB-INF/include/sidebar.jsp"%>

	<input type="hidden" id="loginCustomerId" class="loginCustomerId"
		name="loginCustomerId" value="${customer.id}">

	<div class="order-container">
		<div class="header">
			<h1>장바구니</h1>
		</div>

		<!-- 모두 선택 체크박스 -->
		<div>
			<input type="checkbox" id="select-all"
				onclick="toggleSelectAll(this)"> 모두 선택
		</div>

		<!-- 장바구니 아이템 -->
		<c:forEach var="item" items="${cartItems}">
			<input type="hidden" id="salesPostId" class="salesPostId"
				name="salesPostId" value="${item.salesPostId}">
			<div class="order-cart-item" data-item-id="${item.productNumber}">
				<input type="checkbox" class="select-item"
					onclick="toggleSelectItem()">
				<div class="img-container">
					<img src="${item.filePath}" alt="상품 이미지">
					<c:if test="${item.productQuantity == 0}">
						<div class="sold-out-overlay">품절</div>
					</c:if>
				</div>
				<div class="order-details">
					<input type="hidden" id="salesPostId" class="salesPostId"
						name="salesPostId" value="${item.salesPostId}">
					<h2>${item.name}</h2>
					<p>${item.description}</p>
				</div>
				<div class="order-quantity">
					<button type="button" data-product-number="${item.productNumber}"
						onclick="changeQuantity(this, -1)">-</button>
					<input type="text" class="quantity" value="${item.quantity}"
						size="2" readonly> <input type="hidden"
						class="productQuantity" value="${item.productQuantity}">
					<button type="button" data-product-number="${item.productNumber}"
						onclick="changeQuantity(this, 1)">+</button>
				</div>
				<div class="price-container">
					<c:choose>
						<c:when test="${item.discountPrice == 0}">
							<div class="price">
								<fmt:formatNumber type="number" value="${item.price}" />
								원
							</div>
						</c:when>
						<c:otherwise>
							<div class="original-price">
								<fmt:formatNumber type="number" value="${item.price}" />
							</div>
							<div class="price">
								<fmt:formatNumber type="number" value="${item.discountPrice}" />
								원
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="btn-container">
					<c:if test="${item.productQuantity > 0}">
						<button class="btn-update" type="button"
							data-product-number="${item.productNumber}"
							data-product-quantity="${item.productQuantity}"
							onclick="updateCartItem(this)">수정</button>
					</c:if>
					<c:if test="${item.productQuantity == 0}">
						<div class="btn-placeholder"></div>
					</c:if>
				</div>
				<button class="btn-delete" type="button"
					data-product-number="${item.productNumber}"
					onclick="deleteCartItem(this)">삭제</button>
			</div>
		</c:forEach>

		<!-- 합계 -->
		<div class="order-total">
			<span id="total-price">총 금액: 0원</span>
		</div>

		<!-- 결제 및 삭제 버튼 -->
		<div class="order-actions">
			<button class="btn btn-danger" onclick="deleteSelectedItems()">선택
				삭제</button>
			<button class="btn btn-primary" onclick="checkoutSelectedItems()">선택
				결제</button>
			<button class="btn btn-success" onclick="checkoutAllItems()">전체
				주문</button>
		</div>

		<!-- 최근 본 상품 -->
		<div class="order-recently-viewed">
			<h2>최근 본 상품</h2>
			<c:forEach var="product" items="${recentViewedProducts}"
				varStatus="status">
				<a>
					<div class="product-card">
						<div class="product-top">
							<input type="hidden" id="salesPostId" class="salesPostId"
								name="salesPostId" value="${product.salesPostId}"> <input
								type="hidden" id="productNumber" class="productNumber"
								name="productNumber" value="${product.productNumber}"> <img
								src="${product.filePath}" alt="Product Image">
							<div class="cart-icon"
								data-product-number="${product.productNumber}">
								<img src="/images/basket-icon.png" alt="Cart Icon">
							</div>
						</div>
						<div class="product-details">
							<div class="product-title">${product.name}</div>
							<div class="product-price">
								<c:choose>
									<c:when test="${product.discountPrice != 0}">
										<span class="product-old-price"><fmt:formatNumber
												type="number" value="${product.originalPrice}" />원</span>
										<fmt:formatNumber type="number" value="${product.price}" />원
	                            </c:when>
									<c:otherwise>
										<fmt:formatNumber type="number" value="${product.price}" />원
	                            </c:otherwise>
								</c:choose>
							</div>
							<div class="refrigeration-info">
								<!-- 냉장 정보는 필요시 추가 -->
							</div>
						</div>
					</div>
				</a>
			</c:forEach>
		</div>

		<%@include file="/WEB-INF/include/footer.jsp"%>

	</div>

	<script>
function ensureGuestId() {
    const loginCustomerId = document.getElementById('loginCustomerId').value;
    let cookieGuestId = getCookie('guestId');
    
    if (!loginCustomerId && !cookieGuestId) {
        return getGuestId().then(guestId => {
            console.log('Generated guestId:', guestId);
            cookieGuestId = guestId;
            setCookie('guestId', guestId, 7);
            return guestId;
        });
    }
    return Promise.resolve(cookieGuestId);
}

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
    const loginCustomerId = document.getElementById('loginCustomerId').value;
    let cookieGuestId = getCookie('guestId');

    if (quantityInput) {
        var newQuantity = parseInt(quantityInput.value);

        if (newQuantity > productQuantity) {
            alert('재고가 부족합니다.');
            return;
        }

        if (!loginCustomerId && !cookieGuestId) {
            ensureGuestId().then(guestId => {
                updateCartItemRequest(productNumber, newQuantity, guestId, true);
            });
        } else {
            const customerId = loginCustomerId || cookieGuestId;
            updateCartItemRequest(productNumber, newQuantity, customerId, !loginCustomerId);
        }
    } else {
        console.error('수량 입력 필드를 찾을 수 없습니다: ' + productNumber);
    }
}

function updateCartItemRequest(productNumber, quantity, customerId, isGuest) {
    const data = isGuest ? { guestId: customerId, productNumber, quantity } : { customerId, productNumber, quantity };
    const url = isGuest ? '/guest/cart/updateCartItem' : '/cart/updateCartItem';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        const contentType = response.headers.get('content-type');
        if (!contentType || !contentType.includes('application/json')) {
            return response.text().then(text => { throw new Error('Invalid content type: ' + contentType + '\nResponse: ' + text) });
        }
        return response.json();
    })
    .then(data => {
        if (!data.success) {
            alert('수량 업데이트 중 오류가 발생했습니다.');
            return;
        }
        alert('수량이 성공적으로 업데이트되었습니다.');
        calculateTotal();
    })
    .catch(error => {
        console.error('수량 업데이트 오류:', error);
        alert('수량 업데이트 중 오류가 발생했습니다.');
    });
}

function deleteCartItem(button) {
    var productNumber = button.getAttribute('data-product-number');
    const loginCustomerId = document.getElementById('loginCustomerId').value;
    let cookieGuestId = getCookie('guestId');

    if (!loginCustomerId && !cookieGuestId) {
        ensureGuestId().then(guestId => {
            deleteCartItemRequest(productNumber, guestId, true);
        });
    } else {
        const customerId = loginCustomerId || cookieGuestId;
        deleteCartItemRequest(productNumber, customerId, !loginCustomerId);
    }
}

function deleteCartItemRequest(productNumber, customerId, isGuest) {
    const data = isGuest ? { guestId: customerId, productNumber } : { customerId, productNumber };
    const url = isGuest ? '/guest/cart/deleteCartItem' : '/cart/deleteCartItem';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        const contentType = response.headers.get('content-type');
        if (!contentType || !contentType.includes('application/json')) {
            return response.text().then(text => { throw new Error('Invalid content type: ' + contentType + '\nResponse: ' + text) });
        }
        return response.json();
    })
    .then(data => {
        if (!data.success) {
            alert('삭제에 문제가 발생했습니다.');
            return;
        }
        var cartItem = document.querySelector('.order-cart-item[data-item-id="' + productNumber + '"]');
        cartItem.remove();
        alert('항목이 성공적으로 삭제되었습니다.');
        calculateTotal();
        updateCartCount(-1); // 삭제된 항목 수만큼 배지를 감소시킴
    })
    .catch(error => {
        console.error('삭제 오류:', error);
        alert('항목 삭제 중 오류가 발생했습니다. 에러 메시지: ' + error.message);
    });
}

function checkoutSelectedItems() {
    var selectedItems = document.querySelectorAll('.select-item:checked');
    var selectedIds = Array.from(selectedItems).map(item => item.closest('.order-cart-item').getAttribute('data-item-id'));
    const loginCustomerId = document.getElementById('loginCustomerId').value;
    let cookieGuestId = getCookie('guestId');

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

    if (!loginCustomerId && !cookieGuestId) {
        ensureGuestId().then(guestId => {
            checkoutSelectedItemsRequest(selectedIds, guestId, true);
        });
    } else {
        const customerId = loginCustomerId || cookieGuestId;
        checkoutSelectedItemsRequest(selectedIds, customerId, !loginCustomerId);
    }
}

function checkoutSelectedItemsRequest(selectedIds, customerId, isGuest) {
    const data = isGuest ? { guestId: customerId, productNumbers: selectedIds } : { customerId, productNumbers: selectedIds };
    const url = isGuest ? '/guest/order/prepareCheckout' : '/order/prepareCheckout';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        const contentType = response.headers.get('content-type');
        if (contentType && contentType.includes('application/json')) {
            return response.json();
        } else {
            throw new Error('Invalid content type: ' + contentType);
        }
    })
    .then(data => {
        if (!data.success) {
            alert('품절된 상품이 있습니다.');
            return;
        }
        // Create a form and submit it with POST method
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = isGuest ? '/guest/checkoutPage' : '/checkoutPage';

        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = isGuest ? 'guestId' : 'customerId';
        idInput.value = customerId;
        form.appendChild(idInput);

        selectedIds.forEach(id => {
            var productNumberInput = document.createElement('input');
            productNumberInput.type = 'hidden';
            productNumberInput.name = 'productNumbers';
            productNumberInput.value = id;
            form.appendChild(productNumberInput);
        });

        document.body.appendChild(form);
        form.submit();
    })
    .catch(error => {
        console.error('결제 준비 오류:', error);
        alert('결제 준비 중 오류가 발생했습니다.');
    });
}

function checkoutAllItems() {
    const loginCustomerId = document.getElementById('loginCustomerId').value;
    let cookieGuestId = getCookie('guestId');
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

    if (!loginCustomerId && !cookieGuestId) {
        ensureGuestId().then(guestId => {
            checkoutAllItemsRequest(productNumber, guestId, true);
        });
    } else {
        const customerId = loginCustomerId || cookieGuestId;
        checkoutAllItemsRequest(productNumber, customerId, !loginCustomerId);
    }
}

function checkoutAllItemsRequest(productNumber, customerId, isGuest) {
    const data = isGuest ? { guestId: customerId, productNumbers: productNumber } : { customerId, productNumbers: productNumber };
    const url = isGuest ? '/guest/order/prepareCheckoutAll' : '/order/prepareCheckoutAll';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
    })
    .then(response => {
        const contentType = response.headers.get('content-type');
        if (contentType && contentType.includes('application/json')) {
            return response.json();
        } else {
            throw new Error('Invalid content type: ' + contentType);
        }
    })
    .then(data => {
        if (!data.success) {
            alert('품절된 상품이 있습니다.');
            return;
        }
        // Create a form and submit it with POST method
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = isGuest ? '/guest/checkoutPage' : '/checkoutPage';

        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = isGuest ? 'guestId' : 'customerId';
        idInput.value = customerId;
        form.appendChild(idInput);

        productNumber.forEach(id => {
            var productNumberInput = document.createElement('input');
            productNumberInput.type = 'hidden';
            productNumberInput.name = 'productNumbers';
            productNumberInput.value = id;
            form.appendChild(productNumberInput);
        });

        document.body.appendChild(form);
        form.submit();
    })
    .catch(error => {
        console.error('결제 준비 오류:', error);
        alert('결제 준비 중 오류가 발생했습니다.');
    });
}

function updateCartCount(quantityChange) {
    const headerCartCount = document.getElementById('headerCartCount');
    const cartBadge = document.querySelector('.cart-link .badge');
    const sidebarBadge = document.querySelector('.sidebar .cart-link .sidebar-badge');

    if (headerCartCount) {
        const currentCount = parseInt(headerCartCount.textContent) || 0;
        headerCartCount.textContent = Math.max(0, currentCount + quantityChange);
    }

    if (cartBadge) {
        const currentBadgeCount = parseInt(cartBadge.textContent) || 0;
        cartBadge.textContent = Math.max(0, currentBadgeCount + quantityChange);
    }

    if (sidebarBadge) {
        const currentBadgeCount = parseInt(sidebarBadge.textContent) || 0;
        sidebarBadge.textContent = Math.max(0, currentBadgeCount + quantityChange);
    }
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

	<script>
document.addEventListener('DOMContentLoaded', function () {
    const cartButtons = document.querySelectorAll('.cart-icon');

    cartButtons.forEach(cartButton => {
        cartButton.addEventListener('click', function () {
            var productNumber = cartButton.getAttribute('data-product-number');
            const customerId = 1;
            const quantity = 1;
            
            console.log('Product Number:', productNumber);
            
            checkStock(productNumber, quantity, customerId);
        });
    });

    function checkStock(productNumber, quantity, customerId) {
        const loginCustomerId = document.getElementById('loginCustomerId').value;
        let cookieGuestId = getCookie('guestId');
        
        if (!loginCustomerId && !cookieGuestId) {
            ensureGuestId().then(guestId => {
                checkStockRequest(productNumber, quantity, guestId, true);
            });
        } else {
            const customerId = loginCustomerId || cookieGuestId;
            checkStockRequest(productNumber, quantity, customerId, !loginCustomerId);
        }
    }

    function checkStockRequest(productNumber, quantity, customerId, isGuest) {
        const data = isGuest ? { guestId: customerId, productNumber, quantity } : { customerId, productNumber, quantity };
        const url = isGuest ? '/guest/cart/checkStock' : '/cart/checkStock';

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data),
        })
        .then(response => {
            const contentType = response.headers.get('content-type');
            if (contentType && contentType.includes('application/json')) {
                return response.json();
            } else {
                throw new Error('Invalid content type: ' + contentType);
            }
        })
        .then(data => {
            if (data.success) {
                if (data.stockAvailable) {
                    if (data.inCart) {
                        if (confirm('장바구니에 이미 있는 상품입니다. 수량을 추가하시겠습니까?')) {
                            addToCart(productNumber, quantity, customerId, false);
                        }
                    } else {
                        addToCart(productNumber, quantity, customerId);
                    }
                } else {
                    alert('재고가 부족합니다.');
                }
            } else {
                alert('장바구니에 담는데 문제가 발생했습니다');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('장바구니에 담는데 문제가 발생했습니다');
        });
    }

    function addToCart(productNumber, quantity, customerId, updateCount = true) {
        const loginCustomerId = document.getElementById('loginCustomerId').value;
        let cookieGuestId = getCookie('guestId');
        
        if (!loginCustomerId && !cookieGuestId) {
            ensureGuestId().then(guestId => {
                addToCartRequest(productNumber, quantity, guestId, true, updateCount);
            });
        } else {
            const customerId = loginCustomerId || cookieGuestId;
            addToCartRequest(productNumber, quantity, customerId, !loginCustomerId, updateCount);
        }
    }

    function addToCartRequest(productNumber, quantity, customerId, isGuest, updateCount = true) {
        const data = isGuest ? { guestId: customerId, productNumber, quantity } : { customerId, productNumber, quantity };
        const url = isGuest ? '/guest/cart/addToCart' : '/cart/addToCart';

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data),
        })
        .then(response => {
            const contentType = response.headers.get('content-type');
            if (contentType && contentType.includes('application/json')) {
                return response.json();
            } else {
                throw new Error('Invalid content type: ' + contentType);
            }
        })
        .then(data => {
            if (data.success) {
                alert('장바구니에 담겼습니다');
                if (updateCount) {
                    updateCartCount(1); // 상품이 새로 추가될 때마다 수량을 1씩 증가
                }
                location.reload(); // 장바구니에 담기 후 페이지 새로고침
            } else {
                alert('장바구니에 담는데 문제가 발생했습니다');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('장바구니에 담는데 문제가 발생했습니다');
        });
    }
});

function updateCartCount(quantity) {
    const headerCartCount = document.getElementById('headerCartCount');
    const cartBadge = document.querySelector('.cart-link .badge');
    const sidebarBadge = document.querySelector('.sidebar .cart-link .sidebar-badge')

    if (headerCartCount) {
        const currentCount = parseInt(headerCartCount.textContent) || 0;
        headerCartCount.textContent = currentCount + quantity;
    }

    if (cartBadge) {
        const currentBadgeCount = parseInt(cartBadge.textContent) || 0;
        cartBadge.textContent = currentBadgeCount + quantity;
    }
    
    if (sidebarBadge) {
        const currentBadgeCount = parseInt(sidebarBadge.textContent) || 0;
        sidebarBadge.textContent = currentBadgeCount + quantity;
    }
}
</script>

</body>
</html>
