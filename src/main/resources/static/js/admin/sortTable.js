document.addEventListener('DOMContentLoaded', function() {
    document.addEventListener('click', function(e) {
        const header = e.target.closest('.sortable');
        if (header) {
            console.log("Header clicked:", header);

            const column = header.getAttribute('data-column');
            const currentSort = header.getAttribute('data-sort');

            let newSort;
            switch (currentSort) {
                case 'asc':
                    newSort = 'desc';
                    break;
                case 'desc':
                    newSort = '-';
                    break;
                default:
                    newSort = 'asc';
                    break;
            }

            console.log(`Sorting ${column} by ${newSort}`);

            // 모든 아이콘 초기화
            const tableHeaders = document.querySelectorAll('.sortable');
            tableHeaders.forEach(h => {
                h.setAttribute('data-sort', '-');
                h.querySelector('.sort-icon.default').style.display = 'inline';
                h.querySelector('.sort-icon.asc').style.display = 'none';
                h.querySelector('.sort-icon.desc').style.display = 'none';
            });

            // 새로운 아이콘 설정
            header.setAttribute('data-sort', newSort);
            header.querySelector('.sort-icon.default').style.display = 'none';
            if (newSort === 'asc') {
                header.querySelector('.sort-icon.asc').style.display = 'inline';
            } else if (newSort === 'desc') {
                header.querySelector('.sort-icon.desc').style.display = 'inline';
            }

            // URL 업데이트 및 새로운 정렬 매개변수로 콘텐츠를 부분 업데이트
            const urlParams = new URLSearchParams(window.location.search);
            const sortParams = [];
            tableHeaders.forEach(h => {
                const col = h.getAttribute('data-column');
                const sort = h.getAttribute('data-sort');
                if (sort !== '-') {
                    sortParams.push(`${col},${sort}`);
                }
            });

            urlParams.set('sort', sortParams.join(','));
            const newUrl = `${window.location.pathname}?${urlParams.toString()}`;
            console.log("New URL:", newUrl);

            history.pushState(null, '', newUrl);
            updateTableContent(newUrl);
        }
    });
});

function updateTableContent(url) {
    console.log("Updating table content from URL:", url);
    const tableBody = document.querySelector('.product-list tbody');

    fetch(url)
        .then(response => response.text())
        .then(html => {
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = html;
            const newTableBody = tempDiv.querySelector('.product-list tbody');

            if (newTableBody) {
                tableBody.innerHTML = newTableBody.innerHTML;
            }
        })
        .catch(error => console.error('Error updating table content:', error));
}
