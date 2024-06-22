document.addEventListener('DOMContentLoaded', function() {
	const mainContent = document.querySelector('.main-content');
	const toggleModeButton = document.getElementById('toggleMode');
	const body = document.body;

	// 페이지별 초기화 함수 호출
	if (typeof setupEditDiscount === 'function') setupEditDiscount();
	if (typeof setupToggleMode === 'function') setupToggleMode(toggleModeButton, body);
	if (typeof setupStarRating === 'function') setupStarRating();
	if (typeof setupSortTable === 'function') setupSortTable();
	if (typeof setupOpenDiscountAddWindow === 'function') setupOpenDiscountAddWindow();
	if (typeof setupOpenCounponAddWindow === 'function') setupOpenCounponAddWindow();

	// 공통 초기화 함수 호출
	setupNavigation();
	setupCheckboxEventListeners(); // 추가된 함수 호출

	// 초기 로드 설정
	const pathSegments = window.location.pathname.split('/');
	const initialPage = pathSegments[pathSegments.length - 1];
	if (initialPage && initialPage !== 'admin') {
		loadContent(`/admin/${initialPage}`, initialPage);
	} else {
		loadContent('/admin/mainContent', 'mainContent');
	}
});

document.addEventListener('click', function(e) {
	if (e.target.classList.contains('date-range-btn')) {
		const range = e.target.getAttribute('data-range');
		const group = e.target.getAttribute('data-group');
		setDateRange(range, group);
	}
});

document.addEventListener('click', function(e) {
            if (e.target.classList.contains('search-btn')) {
                const searchInput = document.getElementById('searchInput').value;
                const category = document.getElementById('category').value;
                const fr_date = document.getElementById('fr_date').value;
                const to_date = document.getElementById('to_date').value;
                const stock_min = document.getElementById('stock_min').value;
                const stock_max = document.getElementById('stock_max').value;
                const price_min = document.getElementById('price_min').value;
                const price_max = document.getElementById('price_max').value;
                const radioButtons = document.getElementsByName('sale_status');
                let selectedValue;
                
                for (const radioButton of radioButtons) {
                    if (radioButton.checked) {
                        selectedValue = radioButton.value;
                        break;
                    }
                }

                const data = {
                    searchInput: searchInput,
                    category: category,
                    fr_date: fr_date,
                    to_date: to_date,
                    stock_min: stock_min,
                    stock_max: stock_max,
                    price_min: price_min,
                    price_max: price_max,
                    sale_status: selectedValue
                };

                console.log(JSON.stringify(data, null, 2));
            }
        });


function setupNavigation() {
	const dropdownToggles = document.querySelectorAll('.sidebar .dropdown-toggle');

	dropdownToggles.forEach(toggle => {
		toggle.removeEventListener('click', handleDropdownClick);
		toggle.addEventListener('click', handleDropdownClick);
	});

	const links = document.querySelectorAll('.sidebar ul li a');

	links.forEach(link => {
		link.removeEventListener('click', handleLinkClick);
		link.addEventListener('click', handleLinkClick);
	});
}

function handleDropdownClick(event) {
	event.preventDefault();
	const dropdownMenu = this.parentElement.parentElement.nextElementSibling;
	const arrowIcon = this.querySelector('.arrow-icon');
	if (dropdownMenu) {
		dropdownMenu.classList.toggle('visible');
		arrowIcon.classList.toggle('rotate');
	}
}
function loadPage(event, page, size) {
	event.preventDefault(); // 기본 동작(링크 이동) 방지
	const target = event.target.getAttribute('data-target');
	const url = `/admin/productManagement?page=${page}&size=${size}`;
	loadContent(url, target, page);
}

function handleLinkClick(event) {
	const target = this.getAttribute('data-target');
	if (!target) return;

	const url = `/admin/${target}`;
	event.preventDefault();
	history.pushState({ target: target }, '', url);
	loadContent(url, target);
}

function highlightMenu(target) {
	const links = document.querySelectorAll('.sidebar ul li');
	links.forEach(link => {
		link.classList.remove('active');
	});

	const activeLink = document.querySelector(`.sidebar ul li a[data-target="${target}"]`);
	if (activeLink) {
		activeLink.parentElement.classList.add('active');
	}
}

function loadContent(url, target, page = 0) {
	const mainContent = document.querySelector('.main-content');

	fetch(url)
		.then(response => response.text())
		.then(html => {
			const tempDiv = document.createElement('div');
			tempDiv.innerHTML = html;
			const newMainContent = tempDiv.querySelector('.main-content');
			const newStyles = tempDiv.querySelectorAll('link[rel="stylesheet"]');

			if (newMainContent) {
				newStyles.forEach(style => {
					const existingLink = Array.from(document.head.querySelectorAll('link[rel="stylesheet"]')).find(link => link.href === style.href);
					if (!existingLink) {
						document.head.appendChild(style.cloneNode(true));
					}
				});

				mainContent.style.opacity = '0';
				setTimeout(() => {
					mainContent.innerHTML = newMainContent.innerHTML;
					mainContent.className = newMainContent.className;
					mainContent.style.opacity = '1';
					setupNavigation();
					highlightMenu(target);
					setupCheckboxEventListeners();

					// 각 페이지별 추가 초기화 함수 호출
					if (typeof setupPageSpecificFunction === 'function') setupPageSpecificFunction();
				}, 100);
			}
		})
		.catch(error => console.error('Error loading content:', error));
}

function setupCheckboxEventListeners() {
	document.querySelectorAll('.select-all').forEach(function(selectAllCheckbox) {
		selectAllCheckbox.addEventListener('change', function() {
			const group = this.getAttribute('data-group');
			const checkboxes = document.querySelectorAll(`.checkbox-group[data-group="${group}"] input[type="checkbox"]`);

			checkboxes.forEach(function(checkbox) {
				checkbox.checked = selectAllCheckbox.checked;
			});
		});
	});

	document.querySelectorAll('.checkbox-group input[type="checkbox"]').forEach(function(checkbox) {
		checkbox.addEventListener('change', function() {
			const group = this.closest('.checkbox-group').getAttribute('data-group');
			const selectAllCheckbox = document.querySelector(`.select-all[data-group="${group}"]`);
			const checkboxes = document.querySelectorAll(`.checkbox-group[data-group="${group}"] input[type="checkbox"]:not(.select-all)`);

			if (checkbox.checked === false) {
				selectAllCheckbox.checked = false;
			} else {
				const allChecked = Array.from(checkboxes).every(chk => chk.checked);
				selectAllCheckbox.checked = allChecked;
			}
		});
	});
}

function setDateRange(range, dateGroupName) {
	const today = new Date();
	let startDate, endDate;

	switch (range) {
		case 'today':
			startDate = endDate = today.toISOString().split('T')[0];
			break;
		case 'yesterday':
			today.setDate(today.getDate() - 1);
			startDate = endDate = today.toISOString().split('T')[0];
			break;
		case 'week':
			endDate = today.toISOString().split('T')[0];
			today.setDate(today.getDate() - 7);
			startDate = today.toISOString().split('T')[0];
			break;
		case 'month':
			endDate = today.toISOString().split('T')[0];
			today.setMonth(today.getMonth() - 1);
			startDate = today.toISOString().split('T')[0];
			break;
		case '3months':
			endDate = today.toISOString().split('T')[0];
			today.setMonth(today.getMonth() - 3);
			startDate = today.toISOString().split('T')[0];
			break;
		case 'all':
			startDate = endDate = '';
			break;
	}

	const startDateInput = document.querySelector(`input[name="${dateGroupName}From"]`);
	const endDateInput = document.querySelector(`input[name="${dateGroupName}To"]`);

	if (startDateInput && endDateInput) {
		startDateInput.value = startDate;
		endDateInput.value = endDate;
	}
}

window.setDateRange = setDateRange;
