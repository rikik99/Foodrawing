document.addEventListener('DOMContentLoaded', function() {
    document.addEventListener('keydown', function(event) {
        if (event.ctrlKey && event.altKey && event.key.toLowerCase() === 'a') { // 예: Ctrl + Alt + A
            console.log('Ctrl + Alt + A detected');
            window.location.href = '/admin/login';
        }
    });
});
