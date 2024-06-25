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
    if (e.target.classList.contains('page-link')) {
        const page = e.target.getAttribute('data-page');
        const size = e.target.getAttribute('data-size');
        const urlPath = e.target.getAttribute('data-url');
        loadPage(page, size, urlPath);
    }
    if (e.target.id === 'deleteSelectedButton') {
        const urlPath = e.target.getAttribute('data-url');
        deleteSelectedProducts(urlPath);
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
});

document.addEventListener('change', function(e) {
    if (e.target && e.target.id === 'productList') {
        console.log("상품명 선택했어요");
        updateProductDetails('productList');
    }
});

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
        { id: 'last_fr_date', name:'last_fr_date'},
        { id: 'last_to_date', name:'last_to_date'},
        { id: 'register_fr_date', name:'register_fr_date'},
        { id: 'register_to_date', name:'register_to_date'},
        { id: 'sale_status', name:'sale_status'}
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

    const radioButtons = document.getElementsByName('sale_status');
    let selectedValue = '';
    for (const radioButton of radioButtons) {
        if (radioButton.checked) {
            selectedValue = radioButton.value;
            break;
        }
    }
    if (selectedValue) params.append('sale_status', selectedValue);

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
            history.pushState({ url: url, target: 'productManagement' }, '', url);
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
    const productCheckboxes = document.querySelectorAll('.selectProduct');

    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            productCheckboxes.forEach(function(checkbox) {
                checkbox.checked = selectAllCheckbox.checked;
            });
        });
    }

    productCheckboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            if (!checkbox.checked) {
                selectAllCheckbox.checked = false;
            } else {
                const allChecked = Array.from(productCheckboxes).every(chk => chk.checked);
                selectAllCheckbox.checked = allChecked;
            }
        });
    });
}

function deleteSelectedProducts(urlPath) {
    const productCheckboxes = document.querySelectorAll('.selectProduct:checked');
    const selectedProducts = Array.from(productCheckboxes).map(checkbox => {
        return checkbox.closest('tr').querySelector('td:nth-child(3) p').textContent;
    });

    if (selectedProducts.length > 0) {
        fetch('/admin/deleteProducts', {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ productNumbers: selectedProducts })
        })
            .then(response => response.ok ? response.text() : Promise.reject('Failed to delete products'))
            .then(message => {
                alert(message);
                loadContent(urlPath, urlPath.split('/').pop(), false);
            })
            .catch(error => console.error('Error:', error));
    } else {
        alert('삭제할 항목을 선택해주세요.');
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