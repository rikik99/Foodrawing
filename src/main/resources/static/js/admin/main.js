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
    setupCheckboxEventListeners();
    setupPaginationLinks();

    // 초기 로드 설정
    const pathSegments = window.location.pathname.split('/');
    const initialPage = pathSegments[pathSegments.length - 1];
    if (initialPage && initialPage !== 'admin') {
        loadContent(`/admin/${initialPage}`, initialPage, false);
    } else {
        loadContent('/admin/mainContent', 'mainContent', false);
    }
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
        setDateRange(range, group);
    }
});

document.addEventListener('click', function(e) {
    if (e.target.classList.contains('search-btn')) {
        performSearch();
    }
    if (e.target.classList.contains('page-link')) {
        const page = e.target.getAttribute('data-page');
        const size = e.target.getAttribute('data-size');
        loadPage(page, size);
    }
});

function performSearch() {
    const params = new URLSearchParams();
    params.append('searchInput', document.getElementById('searchInput').value || '');
    params.append('category', document.getElementById('category').value || '');
    params.append('fr_date', document.getElementById('fr_date').value || '');
    params.append('to_date', document.getElementById('to_date').value || '');
    params.append('stock_min', document.getElementById('stock_min').value || '');
    params.append('stock_max', document.getElementById('stock_max').value || '');
    params.append('price_min', document.getElementById('price_min').value || '');
    params.append('price_max', document.getElementById('price_max').value || '');
    const radioButtons = document.getElementsByName('sale_status');
    let selectedValue = '';
    for (const radioButton of radioButtons) {
        if (radioButton.checked) {
            selectedValue = radioButton.value;
            break;
        }
    }
    params.append('sale_status', selectedValue || '');
    params.append('page', '0'); // 검색 시 첫 페이지로 이동
    params.append('size', '5'); // 기본 페이지 크기 설정

    const url = `/admin/productManagement?${params.toString()}`;
    fetch(url)
        .then(response => response.text())
        .then(html => {
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = html;
            const newContent = tempDiv.querySelector('.main-content');
            document.querySelector('.main-content').innerHTML = newContent.innerHTML;
            setupPaginationLinks(); // 페이지 링크 초기화
            history.pushState({ url: url, target: 'productManagement' }, '', url);
        })
        .catch(error => console.error('Error:', error));
}

function loadPage(page, size) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    params.set('size', size);

    const url = `/admin/productManagement?${params.toString()}`;
    fetch(url)
        .then(response => response.text())
        .then(html => {
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = html;
            const newContent = tempDiv.querySelector('.main-content');
            document.querySelector('.main-content').innerHTML = newContent.innerHTML;
            setupPaginationLinks(); // 페이지 링크 초기화
            history.pushState({ url: url, target: 'productManagement' }, '', url);
        })
        .catch(error => console.error('Error:', error));
}

function setupPaginationLinks() {
    document.querySelectorAll('.page-link').forEach(function(link) {
        link.addEventListener('click', function(event) {
            event.preventDefault();
            const page = this.getAttribute('data-page');
            const size = this.getAttribute('data-size');
            loadPage(page, size);
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

                if (pushState) {
                    history.pushState({ url: url, target: target }, '', url);
                } else {
                    history.replaceState({ url: url, target: target }, '', url);
                }
            } else if (url === '/admin/mainContent') {
                mainContent.innerHTML = '<p>메인 콘텐츠</p>'; // 메인 콘텐츠를 설정합니다. 실제 콘텐츠로 교체하세요.
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

            if (!checkbox.checked) {
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
