document.addEventListener('DOMContentLoaded', function() {
    const wishIcon = document.getElementById('wish-icon');
    const salesPostId = document.getElementById('salesPostId').value;
    const loginCustomerId = document.getElementById('loginCustomerId').value;
    
    // 처음 로드 시 위시리스트 상태를 확인하여 아이콘 업데이트
    fetch('/wishlist/check', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            salesPostId: salesPostId,
            customerId: loginCustomerId
        })
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if (data.isWished) {
                wishIcon.src = '/images/svg/iconUtilWishOn.svg';
                wishIcon.setAttribute('data-wished', 'true');
            } else {
                wishIcon.src = '/images/svg/iconUtilWish.svg';
                wishIcon.setAttribute('data-wished', 'false');
            }
        })
        .catch(error => {
            console.error('Error checking wishlist status:', error);
        });

    wishIcon.addEventListener('click', function() {
        const isWished = wishIcon.getAttribute('data-wished') === 'true';
        const url = isWished ? '/wishlist/remove' : '/wishlist/add';
        const newIconSrc = isWished ? '/images/svg/iconUtilWish.svg' : '/images/svg/iconUtilWishOn.svg';
        
        if (isWished) {
            if (!confirm('위시리스트에서 삭제하시겠습니까?')) {
                return; // 사용자가 취소를 누르면 함수 종료
            }
        }

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ 
                salesPostId: salesPostId, 
                customerId: loginCustomerId
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                wishIcon.src = newIconSrc;
                wishIcon.setAttribute('data-wished', !isWished);
                alert(isWished ? '위시리스트에 상품이 삭제되었습니다.' : '위시리스트에 상품이 담겼습니다.');
            } else {
                alert('위시리스트 상태를 업데이트하는데 문제가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('위시리스트 상태를 업데이트하는데 문제가 발생했습니다.');
        });
    });
});
