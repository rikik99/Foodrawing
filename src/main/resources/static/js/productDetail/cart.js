document.addEventListener('DOMContentLoaded', function () {
    function checkStock(productNumber, quantity, customerId, isGuest) {
        const data = isGuest ? { guestId: customerId, productNumber, quantity } : { customerId, productNumber, quantity };
        const url = isGuest ? '/guest/cart/checkStock' : '/cart/checkStock';

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data),
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                if (data.stockAvailable) {
                    if (data.inCart) {
                        if (confirm('장바구니에 이미 있는 상품입니다. 수량을 추가하시겠습니까?')) {
                            addToCart(productNumber, quantity, customerId, isGuest, false);
                        }
                    } else {
                        addToCart(productNumber, quantity, customerId, isGuest);
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

    function addToCart(productNumber, quantity, customerId, isGuest, updateCount = true) {
    const data = isGuest ? { guestId: customerId, productNumber, quantity } : { customerId, productNumber, quantity };
    const url = isGuest ? '/guest/cart/addToCart' : '/cart/addToCart';
    console.log(url);

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        console.log(data);
        if (data.success) {
            alert('장바구니에 담겼습니다');
            if (updateCount) {
                updateCartCount(1);
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


    function updateCartCount(quantity) {
        const headerCartCount = document.getElementById('headerCartCount');
        const cartBadge = document.querySelector('.cart-link .badge');
        const sidebarBadge = document.querySelector('.sidebar .cart-link .sidebar-badge');

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

    function prepareDirectPurchase(productNumber, quantity, customerId, isGuest) {
        const url = isGuest ? '/guest/order/prepareCheckoutAll' : '/order/prepareCheckoutAll';

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ productNumber, quantity, customerId }),
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
                alert('결제 준비 중 오류가 발생했습니다.');
                return;
            }

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = isGuest ? '/guest/buy/checkoutPage' : '/buy/checkoutPage';

            if (isGuest) {
                const guestIdInput = document.createElement('input');
                guestIdInput.type = 'hidden';
                guestIdInput.name = 'guestId';
                guestIdInput.value = customerId; // Assuming customerId is guestId for guest users
                form.appendChild(guestIdInput);
            } else {
                const customerIdInput = document.createElement('input');
                customerIdInput.type = 'hidden';
                customerIdInput.name = 'customerId';
                customerIdInput.value = customerId;
                form.appendChild(customerIdInput);
            }

            const productNumberInput = document.createElement('input');
            productNumberInput.type = 'hidden';
            productNumberInput.name = 'productNumber';
            productNumberInput.value = productNumber;
            form.appendChild(productNumberInput);

            const quantityInput = document.createElement('input');
            quantityInput.type = 'hidden';
            quantityInput.name = 'quantity';
            quantityInput.value = quantity;
            form.appendChild(quantityInput);

            document.body.appendChild(form);
            form.submit();
        })
        .catch(error => {
            console.error('결제 준비 오류:', error);
            alert('결제 준비 중 오류가 발생했습니다.');
        });
    }


    const cartButtons = document.querySelectorAll('.cart-button');
    const buyButtons = document.querySelectorAll('.buy-button');
    const quantityInputs = document.querySelectorAll('.quantity');
    const productNumberInput = document.getElementById('product_number');
    const loginCustomerId = document.getElementById('loginCustomerId').value;
    let cookieGuestId = getCookie('guestId');

    cartButtons.forEach(cartButton => {
        cartButton.addEventListener('click', function () {
            const quantity = parseInt(quantityInputs[0].value);
            const productNumber = productNumberInput.value;

            if (!loginCustomerId && !cookieGuestId) {
                getGuestId().then(guestId => {
                    console.log('Generated guestId:', guestId);
                    cookieGuestId = guestId;
                    setCookie('guestId', guestId, 7);
                    checkStock(productNumber, quantity, guestId, true);
                });
            } else {
                const customerId = loginCustomerId || cookieGuestId;
                checkStock(productNumber, quantity, customerId, !loginCustomerId);
            }
        });
    });

    buyButtons.forEach(buyButton => {
        buyButton.addEventListener('click', function () {
            const quantity = parseInt(quantityInputs[0].value);
            const productNumber = productNumberInput.value;

            if (!loginCustomerId && !cookieGuestId) {
                getGuestId().then(guestId => {
                    console.log('Generated guestId:', guestId);
                    cookieGuestId = guestId;
                    setCookie('guestId', guestId, 7);
                    prepareDirectPurchase(productNumber, quantity, guestId, true);
                });
            } else {
                const customerId = loginCustomerId || cookieGuestId;
                prepareDirectPurchase(productNumber, quantity, customerId, !loginCustomerId);
            }
        });
    });
});
