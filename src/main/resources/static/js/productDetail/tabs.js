document.addEventListener('DOMContentLoaded', function () {
    var navLinks = document.querySelectorAll('.nav-tabs .nav-link');
    navLinks.forEach(function (link) {
        link.addEventListener('click', function (event) {
            event.preventDefault(); // Prevent default anchor behavior
            navLinks.forEach(function (navLink) {
                navLink.classList.remove('active'); // Remove active class from all tabs
            });
            link.classList.add('active'); // Add active class to clicked tab
            var targetId = link.getAttribute('href').substring(1); // Get the target content ID
            var targetElement = document.getElementById(targetId);
            var offset = document.querySelector('.sticky-wrap').offsetHeight; // Adjust scroll position by sticky-wrap height
            window.scrollTo({
                top: targetElement.offsetTop - offset,
                behavior: 'smooth'
            });
        });
    });

    // Scroll to top on page load and replace URL without hash
    if (window.location.hash) {
        history.replaceState(null, null, 'http://localhost:9086/ProductDetail');
        window.scrollTo(0, 0);
    } else {
        window.scrollTo(0, 0);
    }

    // Ensure page scrolls to top on refresh
    window.addEventListener('beforeunload', function () {
        history.replaceState(null, null, 'http://localhost:9086/ProductDetail');
    });
});
