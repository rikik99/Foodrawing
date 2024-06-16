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
                if (newMainContent) {
                    mainContent.innerHTML = newMainContent.innerHTML;
                    setupNavigation();
                }
                highlightMenu(target);
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
        const elements = document.querySelectorAll('.sidebar, .main-content, .summary-row, .summary-box, .notifications, .recent-orders, .popular-products, .customer-reviews, .notification-box');
        elements.forEach(el => {
            el.classList.toggle('dark-mode');
            el.classList.toggle('light-mode');
        });
    }

    if (toggleModeButton) {
        toggleModeButton.addEventListener('click', toggleMode);
    }
});
