//가격 계산
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