function setupSortTable() {
	let currentSortColumns = [];

	const sortTable = () => {
		const tableBody = document.getElementById('stockTableBody');
		const rows = Array.from(tableBody.rows);

		rows.sort((rowA, rowB) => {
			for (let i = 0; i < currentSortColumns.length; i++) {
				const { column, order, type } = currentSortColumns[i];
				let cellA = rowA.querySelector(`[data-column="${column}"]`).innerText;
				let cellB = rowB.querySelector(`[data-column="${column}"]`).innerText;

				if (type === 'number') {
					cellA = parseInt(cellA);
					cellB = parseInt(cellB);
				} else if (type === 'date') {
					cellA = new Date(cellA);
					cellB = new Date(cellB);
				}

				if (cellA < cellB) return order === 'asc' ? -1 : 1;
				if (cellA > cellB) return order === 'asc' ? 1 : -1;
			}
			return 0;
		});

		tableBody.append(...rows);
	};

	document.addEventListener('click', function(e) {
		const header = e.target.closest('.sortable');
		if (header) {
			const ascIcon = header.querySelector('.sort-icon.asc');
			const descIcon = header.querySelector('.sort-icon.desc');
			if (header.classList.contains('asc')) {
				header.classList.remove('asc');
				header.classList.add('desc');
				if (ascIcon) ascIcon.style.display = 'none';
				if (descIcon) descIcon.style.display = 'inline';
			} else {
				header.classList.remove('desc');
				header.classList.add('asc');
				if (ascIcon) ascIcon.style.display = 'inline';
				if (descIcon) descIcon.style.display = 'none';
			}
		}
	});
}
