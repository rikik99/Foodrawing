document.addEventListener('DOMContentLoaded', function() {
	const mainContent = document.querySelector('.main-content');
	const toggleModeButton = document.getElementById('toggleMode');
	const body = document.body;

	// 페이지별 초기화 함수 호출
	if (typeof setupEditDiscount === 'function') setupEditDiscount();
	if (typeof setupToggleMode === 'function') setupToggleMode(toggleModeButton, body);
	if (typeof setupStarRating === 'function') setupStarRating();
	if (typeof setupOpenDiscountAddWindow === 'function') setupOpenDiscountAddWindow();
	if (typeof setupOpenCounponAddWindow === 'function') setupOpenCounponAddWindow();

	// 공통 초기화 함수 호출
	setupNavigation();
	setupCheckboxEventListeners();
	setupPaginationLinks();
	initializeCKEditor();
	// 초기 로드 설정
	const pathSegments = window.location.pathname.split('/');
	const initialPage = pathSegments[pathSegments.length - 1];
	if (initialPage && initialPage !== 'admin') {
		loadContent(`/admin/${initialPage}`, initialPage, false);
	} else {
		loadContent('/admin/mainContent', 'mainContent', false);
	}
});

window.addEventListener('beforeunload', function() {
	// 로컬 저장소에서 fileDTOList 항목 삭제
	localStorage.removeItem('fileDTOList');
});

// popstate 이벤트 리스너를 전역 범위에서 한 번만 추가
window.addEventListener('popstate', function(event) {
	if (event.state && event.state.url) {
		loadContent(event.state.url, event.state.target, false);
	}
});

document.addEventListener('click', function(e) {

	if (e.target.classList.contains('date-range-btn')) {
		const range = e.target.getAttribute('data-range');
		const group = e.target.getAttribute('data-group');
		console.log(range);
		console.log(group);
		setDateRange(range, group);
	}
	if (e.target.classList.contains('search-btn')) {
		const urlPath = e.target.getAttribute('data-url');
		performSearch(urlPath);
	}
	if (e.target.id === 'addSalesButton') {
		const url = '/admin/insertSalesPost'
		const target = e.target.getAttribute('data-target');
		loadContent(url, target, true);
	}
	if (e.target.classList.contains('page-link')) {
		const page = e.target.getAttribute('data-page');
		const size = e.target.getAttribute('data-size');
		const urlPath = e.target.getAttribute('data-url');
		loadPage(page, size, urlPath);
	}
	if (e.target.id === 'deleteSelectedButton') {
		const urlPath = e.target.getAttribute('data-url');
		const pageType = e.target.getAttribute('data-pageType');
		deleteSelectedProducts(urlPath, pageType);
	}
	if (e.target.id === 'progressButton') {
		const urlPath = e.target.getAttribute('data-url');
		progressSelectedOrder(urlPath);
	}
	if (e.target.classList.contains('stock-range-btn')) {
		const stockType = e.target.getAttribute('data-stock');
		const stockMinInput = document.getElementById('stock_min');
		const stockMaxInput = document.getElementById('stock_max');
		switch (stockType) {
			case 'all':
				stockMinInput.value = '';
				stockMaxInput.value = '';
				break;
			case 'out':
				stockMinInput.value = 0;
				stockMaxInput.value = 0;
				break;
			case 'low':
				stockMinInput.value = 1;
				stockMaxInput.value = 80;
				break;
			case 'enough':
				stockMinInput.value = 100;
				stockMaxInput.value = '';
				break;
		}
	}
	if (e.target.classList.contains('stock-update-btn')) {
		const container = e.target.closest('.stock-update-container');
		const productNumber = container.getAttribute('data-product-number');
		const stockAction = container.querySelector('.stock-action').value;
		const stockQuantity = container.querySelector('.stock-quantity').value;
		const expirationDate = container.querySelector('.expirationDate').value;

		const stockData = {
			productNumber: productNumber,
			type: stockAction,
			quantity: stockQuantity,
			expirationDate: expirationDate
		};

		fetch('/admin/updateStock', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify(stockData),
		})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					alert(data.message);
					loadContent('/admin/stockManagement', 'stockManagement', true);
				} else {
					alert('재고 업데이트에 실패했습니다.');
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('재고 업데이트 중 오류가 발생했습니다.');
			});
	}
	if (e.target.classList.contains(('responseBtn'))) {
		const inquiriesId = e.target.getAttribute('data-inquiriesId');
		const message = e.target.closest('tr').querySelector('.response-textarea').value;
		const responseData = {
			inquiriesId: inquiriesId,
			message: message
		};
		fetch('/admin/salesResponse', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify(responseData),
		})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					alert(data.message);
					loadContent('/admin/salesInquiry', 'salesInquiry', true);
				} else {
					alert('답변 작성에 실패했습니다.');
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('답변 작성 중 오류가 발생했습니다.');
			});
	}
	if (e.target.classList.contains(('replyBtn'))) {
		const reviewId = e.target.getAttribute('data-reviewsId');
		const message = e.target.closest('tr').querySelector('.reply-textarea').value;
		const replyData = {
			reviewId: reviewId,
			message: message
		};
		fetch('/admin/reviewReply', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify(replyData),
		})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					alert(data.message);
					loadContent('/admin/salesReview', 'salesReview', true);
				} else {
					alert('답변 작성에 실패했습니다.');
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('답변 작성 중 오류가 발생했습니다.');
			});
	}
	if (e.target.classList.contains(('editButton'))) {
		const productNumber = e.target.getAttribute('data-productNumber');
		openWindow(`/admin/updateProduct/${productNumber}`, 'EditWindow');
	}

    if (e.target.classList.contains('discount-status-column')) {
        let discountId = e.target.closest('tr').getAttribute('data-discountId');
        let currentStatus = e.target.innerText.trim();
        let newStatus = (currentStatus === 'Y') ? 'N' : 'Y';
        fetch('/admin/updateDiscountStatus', {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ discountId: discountId, onsaleYn: newStatus })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('진행 여부 변경에 성공했습니다.');
                loadContent('/admin/discountList', 'discountList', true);
            } else {
                alert('진행 여부 변경에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('진행 여부 변경 중 오류가 발생했습니다.');
        });
    }

});

document.addEventListener('click', async function(event) {
	if (event.target.classList.contains('salesAddBtn')) {
		const insertSalsePostForm = document.querySelector('.insertSalsePostForm');
		// CKEditor의 내용을 textarea 요소로 업데이트
		if (window.editor) {
			insertSalsePostForm.querySelector('#description').value = window.editor.getData();
		}

		// 각 요소의 값을 수집하여 객체에 저장
		const data = {
			productList: document.getElementById('productList').value,
			productNumber: document.getElementById('productNumber').value,
			title: document.getElementById('title').value,
			startPostDate: document.getElementById('startPostDate').value,
			lastPostDate: document.getElementById('lastPostDate').value,
			description: document.getElementById('description').value,
			status: document.querySelector('input[name="status"]:checked').value, // 라디오 버튼 값 추가
			fileDTOList: JSON.parse(localStorage.getItem('fileDTOList')) || []
		};

		// 객체를 JSON 문자열로 변환
		const jsonData = JSON.stringify(data);

		try {
			const response = await fetch('/admin/insertSalesPost', {
				method: 'POST',
				body: jsonData,
				headers: {
					'Content-Type': 'application/json'
				}
			});

			if (response.ok) {
				const message = await response.text();
				alert(message);

				// salesPost 페이지로 이동
				loadContent('/admin/salesPost', 'salesPost', true);
				localStorage.removeItem('fileDTOList'); // 파일 리스트 초기화
			} else {
				console.error('Failed to submit form');
			}
		} catch (error) {
			console.error('Error:', error);
		}
	}
	else if (event.target.classList.contains('salesUpdateBtn')) {
		const insertSalsePostForm = document.querySelector('.updateSalsePostForm');
		// CKEditor의 내용을 textarea 요소로 업데이트
		if (window.editor) {
			insertSalsePostForm.querySelector('#description').value = window.editor.getData();
		}

		// 각 요소의 값을 수집하여 객체에 저장
		const data = {
			salesPostId: document.getElementById('salesPostId').value,
			productList: document.getElementById('updateProductList').value,
			productNumber: document.getElementById('productNumber').value,
			title: document.getElementById('title').value,
			startPostDate: document.getElementById('startPostDate').value,
			lastPostDate: document.getElementById('lastPostDate').value,
			description: document.getElementById('description').value,
			status: document.querySelector('input[name="status"]:checked').value, // 라디오 버튼 값 추가
			fileDTOList: JSON.parse(localStorage.getItem('fileDTOList')) || []
		};

		// 객체를 JSON 문자열로 변환
		const jsonData = JSON.stringify(data);

		try {
			const response = await fetch('/admin/updateSalesPost', {
				method: 'PUT',
				body: jsonData,
				headers: {
					'Content-Type': 'application/json'
				}
			});

			if (response.ok) {
				const message = await response.text();
				alert(message);

				// salesPost 페이지로 이동
				loadContent('/admin/salesPost', 'salesPost', true);
				localStorage.removeItem('fileDTOList'); // 파일 리스트 초기화
			} else {
				console.error('Failed to submit form');
			}
		} catch (error) {
			console.error('Error:', error);
		}
	}
});

document.addEventListener('change', function(e) {
	if (e.target && e.target.id === 'productList') {
		console.log("상품명 선택했어요");
		updateProductDetails('productList');
	} else if (e.target && e.target.id === 'updateProductList') {
		console.log("수정할 상품명 선택");
		const productName = e.target.value;
		if (productName) {
			fetchProductInfo(productName);
		}
	}
});

function fetchProductInfo(productName) {
	fetch('/admin/getProductInfo', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ name: productName })
	})
		.then(response => response.json())
		.then(data => fillFormFields(data))
		.catch(error => console.error('Error fetching product info:', error));
}

function fillFormFields(data) {
	document.getElementById('productNumber').value = data.productNumber || '';
	document.getElementById('title').value = data.title || '';
	document.getElementById('startPostDate').value = data.startPostDate || '';
	document.getElementById('lastPostDate').value = data.lastPostDate || '';
	document.getElementById('salesPostId').value = data.salesPostId || '';

	const statusRadio = document.querySelector(`input[name="status"][value="${data.status}"]`);
	if (statusRadio) {
		statusRadio.checked = true;
	}

	if (window.editorInstance) {
		window.editorInstance.setData(data.description || '');
	}

	const previewArea = document.querySelector('.previewArea');
	previewArea.src = data.imagePath || '/images/FooDrawing_Logo.png';
}

document.addEventListener('blur', function(e) {
	if (e.target.id === 'lastPostDate' || e.target.id === 'startPostDate') {
		adjustDate(e.target);
	}
}, true);

function adjustDate(input) {
	const today = new Date();
	let date = new Date(input.value);
	const maxYear = 2099;

	if (isNaN(date.getTime())) {
		date = new Date();
		date.setFullYear(maxYear);
	}

	if (date < today) {
		date = today;
	}

	if (date.getFullYear() > maxYear) {
		date.setFullYear(maxYear);
	}

	input.value = date.toISOString().split('T')[0];
}


function performSearch(urlPath) {
	const params = new URLSearchParams();

	const fields = [
		{ id: 'searchInput', name: 'searchInput' },
		{ id: 'category', name: 'category' },
		{ id: 'fr_date', name: 'fr_date' },
		{ id: 'to_date', name: 'to_date' },
		{ id: 'stock_min', name: 'stock_min' },
		{ id: 'stock_max', name: 'stock_max' },
		{ id: 'price_min', name: 'price_min' },
		{ id: 'price_max', name: 'price_max' },
		{ id: 'last_fr_date', name: 'last_fr_date' },
		{ id: 'last_to_date', name: 'last_to_date' },
		{ id: 'discount_fr_date', name: 'discount_fr_date' },
		{ id: 'discount_to_date', name: 'discount_to_date' },
		{ id: 'order_fr_date', name: 'order_fr_date' },
		{ id: 'order_to_date', name: 'order_to_date' },
		{ id: 'Issued_fr_date', name: 'Issued_fr_date' },
		{ id: 'Issued_to_date', name: 'Issued_to_date' },
		{ id: 'register_fr_date', name: 'register_fr_date' },
		{ id: 'register_to_date', name: 'register_to_date' },
		{ id: 'fr_min', name: 'fr_min' },
		{ id: 'to_min', name: 'to_min' },
		{ id: 'fr_max', name: 'fr_max' },
		{ id: 'to_max', name: 'to_max' }
	];

	fields.forEach(field => {
		const elem = document.getElementById(field.id);
		if (elem) {
			const value = elem.value.trim();
			if (value) {
				params.append(field.name, value);
			}
		}
	});

	const radioButtonGroups = [
		{ name: 'resolvedYn', paramName: 'resolvedYn' },
		{ name: 'replyYn', paramName: 'replyYn' },
		{ name: 'discountType', paramName: 'discountType' },
		{ name: 'sale_status', paramName: 'sale_status' },
		{ name: 'onsaleYn', paramName: 'onsaleYn' },
		{ name: 'type', paramName: 'type' },
		{ name: 'usedYn', paramName: 'usedYn' },
		{ name: 'targetType', paramName: 'targetType' }
	];

	radioButtonGroups.forEach(group => {
		const radioButtons = document.getElementsByName(group.name);
		let selectedValue = '';
		for (const radioButton of radioButtons) {
			if (radioButton.checked) {
				selectedValue = radioButton.value;
				break;
			}
		}
		if (selectedValue) params.append(group.paramName, selectedValue);
	});

	// Adding rating parameter
	const ratingButtons = document.querySelectorAll('.star-rating .star');
	let ratingValue = '';
	for (const radioButton of ratingButtons) {
		if (radioButton.classList.contains('checked')) {
			ratingValue = radioButton.getAttribute('data-value');
			break;
		}
	}
	if (ratingValue) params.append('rating', ratingValue);

	// Adding checkbox parameters
	const checkboxGroups = [
		{ name: 'orderStatus', paramName: 'orderStatus' },
		{ name: 'paymentType', paramName: 'paymentType' }
	];

	checkboxGroups.forEach(group => {
		const checkboxes = document.querySelectorAll(`input[name="${group.name}"]:checked`);
		checkboxes.forEach(checkbox => {
			if (checkbox.value !== 'all') {
				params.append(group.paramName, checkbox.value);
			}
		});
	});

	params.append('page', '0'); // 검색 시 첫 페이지로 이동
	params.append('size', '5'); // 기본 페이지 크기 설정

	const url = `${urlPath}?${params.toString()}`;
	fetch(url)
		.then(response => response.text())
		.then(html => {
			const tempDiv = document.createElement('div');
			tempDiv.innerHTML = html;
			const newContent = tempDiv.querySelector('.main-content');
			document.querySelector('.main-content').innerHTML = newContent.innerHTML;
			setupPaginationLinks();
			setupCheckboxEventListeners();
			initializeCKEditor();
			history.pushState({ url: url, target: urlPath.split('/').pop() }, '', url);
		})
		.catch(error => console.error('Error:', error));
}




function loadPage(page, size, urlPath) {
	const params = new URLSearchParams(window.location.search);
	params.set('page', page);
	params.set('size', size);

	const url = `${urlPath}?${params.toString()}`;
	fetch(url)
		.then(response => response.text())
		.then(html => {
			const tempDiv = document.createElement('div');
			tempDiv.innerHTML = html;
			const newContent = tempDiv.querySelector('.main-content');
			document.querySelector('.main-content').innerHTML = newContent.innerHTML;
			setupPaginationLinks();
			setupCheckboxEventListeners();
			initializeCKEditor();
			history.pushState({ url: url, target: urlPath.split('/').pop() }, '', url);
		})
		.catch(error => console.error('Error:', error));
}

function setupPaginationLinks() {
	document.querySelectorAll('.page-link').forEach(function(link) {
		link.addEventListener('click', function(event) {
			event.preventDefault();
			const page = this.getAttribute('data-page');
			const size = this.getAttribute('data-size');
			const urlPath = this.getAttribute('data-url');
			loadPage(page, size, urlPath);
		});
	});
}

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

function handleLinkClick(event) {
	const target = this.getAttribute('data-target');
	if (!target) return;

	const url = `/admin/${target}`;
	event.preventDefault();
	loadContent(url, target, true);
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

function loadContent(url, target, pushState = true) {
	const mainContent = document.querySelector('.main-content');
	localStorage.removeItem('fileDTOList');
	fetch(url)
		.then(response => response.text())
		.then(html => {
			const tempDiv = document.createElement('div');
			tempDiv.innerHTML = html;
			const newMainContent = tempDiv.querySelector('.main-content');
			const newStyles = tempDiv.querySelectorAll('link[rel="stylesheet"]');

			if (newMainContent) {
				// 기존의 모든 CSS 링크 태그 임시 저장
				const existingStyles = Array.from(document.querySelectorAll('link[rel="stylesheet"]'));

				// 새로운 CSS 링크 태그 추가
				newStyles.forEach(style => {
					document.head.appendChild(style.cloneNode(true));
				});

				mainContent.style.opacity = '0';
				setTimeout(() => {
					// 컨텐츠 업데이트
					mainContent.innerHTML = newMainContent.innerHTML;
					mainContent.className = newMainContent.className;

					// 기존의 CSS 링크 태그 제거
					existingStyles.forEach(link => link.remove());

					mainContent.style.opacity = '1';
					setupNavigation();
					highlightMenu(target);
					setupCheckboxEventListeners();
					initializeCKEditor();
				}, 100);

				if (pushState) {
					history.pushState({ url: url, target: target }, '', url);
				} else {
					history.replaceState({ url: url, target: target }, '', url);
				}
			} else if (url === '/admin/mainContent') {
				mainContent.innerHTML = '<p>메인 콘텐츠</p>';
			}
		})
		.catch(error => console.error('Error loading content:', error));
}

function setupCheckboxEventListeners() {
	const selectAllCheckbox = document.getElementById('selectAll');
	const orderCheckboxes = document.querySelectorAll('.selectOrder');
	const productCheckboxes = document.querySelectorAll('.selectProduct');

	if (selectAllCheckbox) {
		selectAllCheckbox.addEventListener('change', function() {
			orderCheckboxes.forEach(function(checkbox) {
				checkbox.checked = selectAllCheckbox.checked;
			});
			productCheckboxes.forEach(function(checkbox) {
				checkbox.checked = selectAllCheckbox.checked;
			});
		});
	}

	const updateSelectAllCheckboxState = function() {
		const allChecked = Array.from(orderCheckboxes).every(chk => chk.checked) && Array.from(productCheckboxes).every(chk => chk.checked);
		selectAllCheckbox.checked = allChecked;
	};

	orderCheckboxes.forEach(function(checkbox) {
		checkbox.addEventListener('change', function() {
			if (!checkbox.checked) {
				selectAllCheckbox.checked = false;
			} else {
				updateSelectAllCheckboxState();
			}
		});
	});

	productCheckboxes.forEach(function(checkbox) {
		checkbox.addEventListener('change', function() {
			if (!checkbox.checked) {
				selectAllCheckbox.checked = false;
			} else {
				updateSelectAllCheckboxState();
			}
		});
	});
}

function deleteSelectedProducts(urlPath, pageType) {
	const productCheckboxes = document.querySelectorAll('.selectProduct:checked');
	let selectedItems;
	let bodyContent;

	if (pageType === 'productManagement') {
		const selectedProductNumbers = Array.from(productCheckboxes).map(checkbox => {
			return checkbox.closest('tr').querySelector('td:nth-child(3) p').textContent;
		});
		selectedItems = selectedProductNumbers;
		bodyContent = { productNumbers: selectedItems };
	} else if (pageType === 'discountList') {
		const selectedDiscountIds = Array.from(productCheckboxes).map(checkbox => {
			return checkbox.closest('tr').getAttribute('data-discountId');
		});
		selectedItems = selectedDiscountIds;
		bodyContent = { discountIds: selectedItems };
	} else if (pageType === 'discountTarget') {
		const selectedDiscountTargetIds = Array.from(productCheckboxes).map(checkbox => {
			return checkbox.closest('tr').getAttribute('data-discountId');
		});
		selectedItems = selectedDiscountTargetIds;
		bodyContent = { discountTargetIds: selectedItems };
	} else if (pageType === 'couponList') {
		const selectedCouponListIds = Array.from(productCheckboxes).map(checkbox => {
			return checkbox.closest('tr').getAttribute('data-issuanceId');
		});
		selectedItems = selectedCouponListIds;
		bodyContent = { couponIssuanceIds: selectedItems };
	}

	if (selectedItems.length > 0) {
		const endpoint = pageType === 'productManagement' ? '/admin/deleteProducts' :
			pageType === 'discountList' ? '/admin/deleteDiscounts' :
				pageType === 'discountTarget' ? '/admin/discountTarget' : '/admin/deleteCoupons';

		fetch(endpoint, {
			method: 'DELETE',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(bodyContent)
		})
			.then(response => response.ok ? response.text() : Promise.reject('Failed to delete items'))
			.then(message => {
				alert(message);
				loadContent(urlPath, urlPath.split('/').pop(), false);
			})
			.catch(error => console.error('Error:', error));
	} else {
		alert('삭제할 항목을 선택해주세요.');
	}
}

function progressSelectedOrder(urlPath) {
	const productCheckboxes = document.querySelectorAll('.selectOrder:checked');

	let selectedItems = Array.from(productCheckboxes).map(checkbox => {
		return checkbox.closest('tr').getAttribute('data-orderId');
	});
	let progress = document.querySelector('.selectOrder:checked').closest('tr').getAttribute('data-progress');

	if (selectedItems.length > 0) {
		const bodyContent = { orderIds: selectedItems, progress: progress };

		fetch('/admin/progressOrder', {
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(bodyContent)
		})
			.then(response => response.ok ? response.text() : Promise.reject('Failed to update items'))
			.then(message => {
				alert(message);
				loadContent(urlPath, urlPath.split('/').pop(), false);
			})
			.catch(error => console.error('Error:', error));
	} else {
		alert('변경할 항목을 선택해주세요.');
	}

}

function setDateRange(range, group) {
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

	const startDateInput = document.querySelector(`input[name="${group}_fr_date"]`);
	const endDateInput = document.querySelector(`input[name="${group}_to_date"]`);

	if (startDateInput && endDateInput) {
		startDateInput.value = startDate;
		endDateInput.value = endDate;
	}
}

window.setDateRange = setDateRange;

function MyCustomUploadAdapterPlugin(editor) {
	editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
		return new UploadAdapter(loader);
	}
}

function initializeCKEditor() {
	const descriptionElement = document.querySelector('#description');
	if (descriptionElement) {
		descriptionElement.removeAttribute('required'); // required 속성 제거

		ClassicEditor.create(descriptionElement, {
			language: 'ko',
			extraPlugins: [MyCustomUploadAdapterPlugin]
		}).then(editor => {
			window.editor = editor;
		}).catch(error => {
			console.error(error);
		});
	}
}

document.addEventListener('DOMContentLoaded', initializeCKEditor);

function handleInquiryToggleClick(event) {
	event.preventDefault();
	const inquiryToggle = event.target.closest('.inquiryToggle');
	const inquiryToggleMenu = inquiryToggle.nextElementSibling;
	if (inquiryToggleMenu && inquiryToggleMenu.classList.contains('inquiryToggleMenu')) {
		inquiryToggleMenu.classList.toggle('visible');
	}
}
function handleReviewToggleClick(event) {
	event.preventDefault();
	const reviewToggle = event.target.closest('.reviewToggle');
	const reviewToggleMenu = reviewToggle.nextElementSibling;
	if (reviewToggleMenu && reviewToggleMenu.classList.contains('reviewToggleMenu')) {
		reviewToggleMenu.classList.toggle('visible');
	}
}
