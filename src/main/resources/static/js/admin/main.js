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

function loadContent(url, target) {
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
