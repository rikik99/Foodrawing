function setupEditDiscount() {
	document.addEventListener('click', function(e) {
		if (e.target.id === 'editDiscount') {
			const rows = document.querySelectorAll('.discount-table tbody tr');
			rows.forEach(row => {
				const cells = row.querySelectorAll('td');
				cells.forEach((cell, index) => {
					let value = cell.innerText.trim();
					cell.innerHTML = '';

					if (index === 2) { // 할인 종류
						const button = document.createElement('button');
						button.type = 'button';
						button.innerText = value === '퍼센트' ? '%' : '₩';
						button.className = 'discount-button primary';
						button.addEventListener('click', function() {
							button.innerText = button.innerText === '%' ? '₩' : '%';
						});
						cell.appendChild(button);
					} else if (index === 3) { // 할인 유형
						const button = document.createElement('button');
						button.type = 'button';
						button.innerText = value;
						button.className = 'type-button primary';
						button.addEventListener('click', function() {
							button.innerText = button.innerText === '이벤트' ? '쿠폰' : '이벤트';
						});
						cell.appendChild(button);
					} else if (index === 9) { // 진행 여부
						const button = document.createElement('button');
						button.type = 'button';
						button.innerText = value;
						button.className = 'status-button primary';
						button.addEventListener('click', function() {
							button.innerText = button.innerText === '진행 중' ? '종료' : '진행 중';
						});
						cell.appendChild(button);
					} else {
						const input = document.createElement('input');
						if (index === 7 || index === 8) { // 시작 날짜 또는 종료 날짜
							input.type = 'date';
							if (value) {
								const dateParts = value.split('.');
								const formattedDate = `20${dateParts[0]}-${dateParts[1]}-${dateParts[2].split(' ')[0]}`;
								input.value = formattedDate;
							}
						} else {
							input.type = 'text';
							input.value = value;
						}
						input.className = 'table-input';
						cell.appendChild(input);
					}
				});
			});

			e.target.id = 'saveDiscount';
			e.target.innerText = '수정 완료';
		} else if (e.target && e.target.id === 'saveDiscount') {
			const rows = document.querySelectorAll('.discount-table tbody tr');
			const data = [];
			let isValid = true;

			rows.forEach(row => {
				const cells = row.querySelectorAll('td');
				const rowData = {};
				rowData.id = row.getAttribute('data-discountId');

				cells.forEach((cell, index) => {
					const input = cell.querySelector('input');
					const button = cell.querySelector('button');

					switch (index) {
						case 0:
							rowData.name = input ? input.value : cell.innerText;
							break;
						case 1:
							rowData.description = input ? input.value : cell.innerText;
							break;
						case 2:
							rowData.discountType = button ? (button.innerText === '%' ? 'P' : 'A') : cell.innerText;
							break;
						case 3:
							rowData.type = button ? button.innerText : cell.innerText;
							break;
						case 4:
							rowData.discountValue = input ? parseFloat(input.value.replace('%', '').replace('₩', '')) : parseFloat(cell.innerText.replace('%', '').replace('₩', ''));
							if (rowData.discountType === 'P' && rowData.discountValue > 100) {
								alert('할인율은 100 이하로 설정해야 합니다.');
								isValid = false;
							}
							break;
						case 5:
							rowData.minPrice = input ? parseFloat(input.value.replace('₩', '')) : parseFloat(cell.innerText.replace('₩', ''));
							break;
						case 6:
							rowData.maxDiscount = input ? parseFloat(input.value.replace('₩', '')) : parseFloat(cell.innerText.replace('₩', ''));
							break;
						case 7:
							rowData.startDate = input ? input.value : cell.innerText;
							break;
						case 8:
							rowData.endDate = input ? input.value : cell.innerText;
							break;
						case 9:
							rowData.onsaleYn = button ? (button.innerText === '진행 중' ? 'Y' : 'N') : cell.innerText;
							break;
					}
				});

				data.push(rowData);
			});

			if (!isValid) {
				return;
			}

			console.log(data);

			fetch('/admin/discountUpdate', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(data)
			})
				.then(response => response.json())
				.then(result => {
					console.log('Success:', result);
					alert(result.message);
					loadContent('/admin/discountList', 'discountList', true);
				})
				.catch(error => {
					console.error('Error:', error);
				});
		}
	});
}
