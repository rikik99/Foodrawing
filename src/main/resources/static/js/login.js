document.addEventListener('DOMContentLoaded', function() {
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    const loginMain = document.querySelector('.login-main');

    // 페이지 로드 시 저장된 상태가 있는지 확인
    if (localStorage.getItem('adminLoginContent')) {
        loginMain.innerHTML = localStorage.getItem('adminLoginContent');
    }

    document.addEventListener('keydown', function(event) {
        if (event.ctrlKey && event.altKey && event.key.toLowerCase() === 'a') { // 예: Ctrl + Alt + A
            console.log('Ctrl + Alt + A detected');
            fetch('/admin/loginContent', {
                headers: {
                    [csrfHeader]: csrfToken
                },
            })
            .then(response => {
                console.log('Fetch response status:', response.status);
                return response.text();
            })
            .then(html => {
                console.log('Fetched HTML:', html);
                loginMain.innerHTML = html;
                // 가져온 콘텐츠를 localStorage에 저장
                localStorage.setItem('adminLoginContent',  html);
                localStorage.setItem('isAdminPage', 'true');
            })
            .catch(error => console.error('Error:', error));
        }

        if (event.ctrlKey && event.altKey && event.key.toLowerCase() === 'u') { // 예: Ctrl + Alt + U
            console.log('Ctrl + Alt + U detected');
            // 기본 로그인 페이지로 돌아가기
            localStorage.removeItem('adminLoginContent');
            localStorage.removeItem('isAdminPage');
            window.location.reload(); // 페이지 새로고침으로 기본 로그인 페이지 로드
        }
    });
});
