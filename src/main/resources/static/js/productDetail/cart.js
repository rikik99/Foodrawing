document.addEventListener('DOMContentLoaded', function () {
        		const cartButton = document.querySelector('.cart-button');
            const buyButton = document.querySelector('.buy-button');
            const quantityInput = document.querySelector('.quantity');
            const productNumberInput = document.getElementById('product_number');
            
            cartButton.addEventListener('click', function () {
                const quantity = parseInt(quantityInput.value);
                const productNumber = productNumberInput.value; // 실제 제품 ID로 교체
                const customerId = 1; // 실제 사용자 ID로 교체

                checkStock(productNumber, quantity, customerId);
            });

            buyButton.addEventListener('click', function () {
                const quantity = parseInt(quantityInput.value);
                const productNumber = productNumberInput.value; // salesPostId로 교체
                const customerId = 1; // 실제 사용자 ID로 교체

                prepareDirectPurchase(productNumber, quantity, customerId);
            });

            function checkStock(productNumber, quantity, customerId) {
                const data = { productNumber, quantity, customerId };
                fetch('/cart/checkStock', {
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

            function addToCart(productNumber, quantity, customerId, updateCount) {
                const data = { productNumber, quantity, customerId };
                fetch('/cart/addToCart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data),
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('장바구니에 담겼습니다');
                        if (updateCount) {
                            updateCartCount(quantity);
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

                if (headerCartCount) {
                    const currentCount = parseInt(headerCartCount.textContent) || 0;
                    headerCartCount.textContent = currentCount + quantity;
                }

                if (cartBadge) {
                    const currentBadgeCount = parseInt(cartBadge.textContent) || 0;
                    cartBadge.textContent = currentBadgeCount + quantity;
                }
            }
            
            function prepareDirectPurchase(productNumber, quantity, customerId) {
                fetch('/order/prepareCheckoutAll', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ productNumber, quantity, customerId }),
                })
                .then(response => response.json())
                .then(data => {
                    if (!data.success) {
                        alert('결제 준비 중 오류가 발생했습니다.');
                        return;
                    }
                    // Create a form and submit it with POST method
                    var form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '/buy/checkoutPage';

                    var customerIdInput = document.createElement('input');
                    customerIdInput.type = 'hidden';
                    customerIdInput.name = 'customerId';
                    customerIdInput.value = customerId;
                    form.appendChild(customerIdInput);

                    var productNumberInput = document.createElement('input');
                    productNumberInput.type = 'hidden';
                    productNumberInput.name = 'productNumber'; // Change this line
                    productNumberInput.value = productNumber;
                    form.appendChild(productNumberInput);

                    var quantityInput = document.createElement('input');
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

            function checkoutAllItems() {
                var customerId = 1; // 고객 ID를 적절히 넣어야 합니다
                var cartItems = document.querySelectorAll('.order-cart-item');
                var productNumbers = Array.from(cartItems).map(item => item.getAttribute('data-item-id'));

                if (productNumbers.length === 0) {
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
                        productNumbers: productNumbers
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (!data.success) {
                        alert('품절된 상품이 있습니다.');
                        return;
                    }
                    // Create a form and submit it with POST method
                    var form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '/checkoutPage';

                    var customerIdInput = document.createElement('input');
                    customerIdInput.type = 'hidden';
                    customerIdInput.name = 'customerId';
                    customerIdInput.value = customerId;
                    form.appendChild(customerIdInput);

                    productNumbers.forEach(id => {
                        var productNumberInput = document.createElement('input');
                        productNumberInput.type = 'hidden';
                        productNumberInput.name = 'productNumbers'; // Change this line
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
        });