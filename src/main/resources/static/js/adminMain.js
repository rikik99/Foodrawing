document.addEventListener('DOMContentLoaded', function() {
    const mainContent = document.querySelector('.main-content');
    const toggleModeButton = document.getElementById('toggleMode');
    const body = document.body;

    function loadContent(url, target) {
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
                    }, 100);
                }
            })
            .catch(error => console.error('Error loading content:', error));
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

    window.addEventListener('popstate', function(event) {
        if (event.state && event.state.target) {
            loadContent(`/admin/${event.state.target}`, event.state.target);
        } else {
            loadContent('/admin/mainContent', 'mainContent');
        }
    });

    const pathSegments = window.location.pathname.split('/');
    const initialPage = pathSegments[pathSegments.length - 1];
    if (initialPage && initialPage !== 'admin') {
        loadContent(`/admin/${initialPage}`, initialPage);
    } else {
        loadContent('/admin/mainContent', 'mainContent');
    }

    setupNavigation();

    function toggleMode() {
        body.classList.toggle('dark-mode');
        body.classList.toggle('light-mode');
        const elements = document.querySelectorAll('.sidebar, .main-content, .summary-row, .summary-box, .notifications, .product-list, .recent-orders, .popular-products, .customer-reviews, .notification-box');
        elements.forEach(el => {
            el.classList.toggle('dark-mode');
            el.classList.toggle('light-mode');
        });
    }

    if (toggleModeButton) {
        toggleModeButton.addEventListener('click', toggleMode);
    }

    function setupCheckboxEventListeners() {
        const selectAll = document.getElementById('selectAll');
        if (selectAll) {
            selectAll.addEventListener('click', function() {
                var isChecked = selectAll.checked;
                var selectProducts = document.querySelectorAll('.selectProduct');
                selectProducts.forEach(function(checkbox) {
                    checkbox.checked = isChecked;
                });
            });
        }
    }

    setupCheckboxEventListeners();

    function setDateRange(range) {
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

        document.getElementById('fr_date').value = startDate;
        document.getElementById('to_date').value = endDate;
    }

    window.setDateRange = setDateRange;

    function setStockRange(range) {
        let stockMin = document.getElementById('stock_min');
        let stockMax = document.getElementById('stock_max');

        switch (range) {
            case 'all':
                stockMin.value = '';
                stockMax.value = '';
                break;
            case 'soldOut':
                stockMin.value = 0;
                stockMax.value = 0;
                break;
            case 'outOfStock':
                stockMin.value = 1;
                stockMax.value = 500;
                break;
            case 'availability':
                stockMin.value = 1001;
                stockMax.value = '';
                break;
        }
    }

    window.setStockRange = setStockRange;

    const sortTable = (column, order) => {
        const tableBody = document.getElementById('stockTableBody');
        const rows = Array.from(tableBody.rows);
        const dataType = rows[0].querySelector(`[data-column="${column}"]`).getAttribute('data-type');

        const compare = (rowA, rowB) => {
            let cellA = rowA.querySelector(`[data-column="${column}"]`).innerText;
            let cellB = rowB.querySelector(`[data-column="${column}"]`).innerText;

            if (dataType === 'number') {
                cellA = parseInt(cellA);
                cellB = parseInt(cellB);
            } else if (dataType === 'date') {
                cellA = new Date(cellA);
                cellB = new Date(cellB);
            }

            if (order === 'asc') {
                return cellA > cellB ? 1 : -1;
            } else {
                return cellA < cellB ? 1 : -1;
            }
        };

        rows.sort(compare);
        tableBody.append(...rows);
    };

    document.querySelectorAll('.sortable').forEach(header => {
        header.addEventListener('click', function() {
            const order = header.classList.contains('asc') ? 'desc' : 'asc';
            const column = header.getAttribute('data-column');

            document.querySelectorAll('.sortable').forEach(th => th.classList.remove('asc', 'desc'));
            header.classList.add(order);

            sortTable(column, order);
        });
    });
});