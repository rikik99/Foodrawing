function setupToggleMode(toggleModeButton, body) {
	toggleModeButton.addEventListener('click', function() {
		body.classList.toggle('dark-mode');
		body.classList.toggle('light-mode');
		const elements = document.querySelectorAll('.sidebar, .main-content, .summary-row, .summary-box, .notifications, .product-list, .recent-orders, .popular-products, .customer-reviews, .notification-box');
		elements.forEach(el => {
			el.classList.toggle('dark-mode');
			el.classList.toggle('light-mode');
		});
	});
}
