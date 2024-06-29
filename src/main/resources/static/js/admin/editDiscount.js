function setupEditDiscount() {
	document.addEventListener('click', function(e) {
		if (e.target && e.target.id === 'editDiscount') {
			console.log("clicked");

			const rows = document.querySelectorAll('#discountTable tbody tr');
			rows.forEach(row => {
				const cells = row.querySelectorAll('td');
				cells.forEach((cell, index) => {
					let value = cell.innerText;
					cell.innerHTML = '';

					if (index === 3) { // 할인 종류
						const button = document.createElement('button');
						button.type = 'button';
						button.innerText = value;
						button.className = 'discount-button primary';
						button.addEventListener('click', function() {
							button.innerText = button.innerText === '%' ? '₩' : '%';
						});
						cell.appendChild(button);
					} else if (index === 2) { // 할인 유형
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
						input.type = 'text';
						input.value = value;
						input.className = 'table-input';
						cell.appendChild(input);
					}
				});
			});

			e.target.id = 'saveDiscount';
			e.target.innerText = '수정 완료';
		} else if (e.target && e.target.id === 'saveDiscount') {
			console.log("saving changes");

			const rows = document.querySelectorAll('#discountTable tbody tr');
			const data = [];

			rows.forEach(row => {
				const cells = row.querySelectorAll('td');
				const rowData = {};

				cells.forEach((cell, index) => {
					const input = cell.querySelector('input');
					const button = cell.querySelector('button');

					switch (index) {
						case 0:
							rowData.discountName = input ? input.value : cell.innerText;
							break;
						case 1:
							rowData.discountDescription = input ? input.value : cell.innerText;
							break;
						case 2:
							rowData.discountType = button ? button.innerText : cell.innerText;
							break;
						case 3:
							rowData.discountCategory = button ? button.innerText : cell.innerText;
							break;
						case 4:
							rowData.discountValue = input ? input.value : cell.innerText;
							break;
						case 5:
							rowData.minPurchaseValue = input ? input.value : cell.innerText;
							break;
						case 6:
							rowData.maxDiscountValue = input ? input.value : cell.innerText;
							break;
						case 7:
							rowData.startDate = input ? input.value : cell.innerText;
							break;
						case 8:
							rowData.endDate = input ? input.value : cell.innerText;
							break;
						case 9:
							rowData.status = button ? button.innerText : cell.innerText;
							break;
					}
				});

				data.push(rowData);
			});

			console.log(data);

			fetch('/your-server-endpoint', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(data)
			})
				.then(response => response.json())
				.then(result => {
					console.log('Success:', result);

					rows.forEach((row, rowIndex) => {
						const cells = row.querySelectorAll('td');
						const rowData = result[rowIndex];

						cells.forEach((cell, index) => {
							cell.innerHTML = '';

							let value;
							switch (index) {
								case 0:
									value = rowData.discountName;
									break;
								case 1:
									value = rowData.discountDescription;
									break;
								case 2:
									value = rowData.discountType;
									break;
								case 3:
									value = rowData.discountCategory;
									break;
								case 4:
									value = rowData.discountValue;
									break;
								case 5:
									value = rowData.minPurchaseValue;
									break;
								case 6:
									value = rowData.maxDiscountValue;
									break;
								case 7:
									value = rowData.startDate;
									break;
								case 8:
									value = rowData.endDate;
									break;
								case 9:
									value = rowData.status;
									break;
							}

							cell.innerText = value;
						});
					});

					e.target.id = 'editDiscount';
					e.target.innerText = '할인 수정';
				})
				.catch(error => {
					console.error('Error:', error);
				});
		}
	});
}
