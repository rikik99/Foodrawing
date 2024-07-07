//가격 계산
document.addEventListener('DOMContentLoaded', function() {


	var total = 0;
	var discount = 0;  // 서버에서 제공한 할인 금액
	var cartItems = document.querySelectorAll('.order-item');
	cartItems.forEach(function(item) {
		var priceElement = item.querySelector('.price');
		var quantityElement = item.querySelector('.quantity');
		var originalPrice = parseInt(document.getElementById('original-price').value);
		var discountPrice = parseInt(document.getElementById('discount-price').value);
		var quantity = parseInt(quantityElement.innerText.replace('수량: ', ''));
		//var maxDiscount = document.querySelector('.maxDiscount').value
		//var minPrice = document.querySelector('.minPrice').value
		var price = 0;

		//할인 계산
		if (discountPrice !== 0) {
			price = discountPrice
		} else {
			price = originalPrice
		}
		//alert('가격' + originalPrice + ', ' + discountPrice + ', ' + price);

		total += price * quantity;
		discount += originalPrice - discountPrice
	});
	document.getElementById('totalPrice').innerText = total.toLocaleString() + '원';

	document.getElementById('totalDiscountPrice').innerText = discount.toLocaleString() + '원';

	var finalPrice = total - discount;
	document.getElementById('finalPrice').innerText = finalPrice.toLocaleString() + '원';
});