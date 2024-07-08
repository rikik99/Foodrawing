document.addEventListener('DOMContentLoaded', function() {
    window.setCookie = function(name, value) {
        document.cookie = name + "=" + (value || "") + "; path=/";
        console.log(`Set cookie: ${name}=${value}`);
    }

    window.getCookie = function(name) {
        const nameEQ = name + "=";
        const ca = document.cookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    window.getGuestId = function() {
        return fetch('/guest/id', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log('Fetched guest ID:', data.guestId);
            // 쿠키에 게스트 아이디를 세션 동안만 저장
            setCookie('guestId', data.guestId);
            return data.guestId;
        })
        .catch(error => {
            console.error('Error fetching guest ID:', error);
            throw error;
        });
    }

    // 페이지 로드 시 쿠키에서 게스트 아이디를 확인하고 없으면 새로 가져오기
    const guestId = getCookie('guestId');
    if (!guestId) {
        window.getGuestId();
    } else {
        console.log('Existing guest ID:', guestId);
    }
});
