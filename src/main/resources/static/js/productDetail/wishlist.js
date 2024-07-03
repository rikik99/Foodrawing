document.addEventListener('DOMContentLoaded', function() {
    const wishIcon = document.getElementById('wish-icon');
    const salesPostId = document.getElementById('salesPostId').value;
    const customerId = 1; // 설정해 줘야함

    wishIcon.addEventListener('click', function() {
        const isWished = wishIcon.getAttribute('data-wished') === 'true';
        const url = isWished ? '/wishlist/remove' : '/wishlist/add';
        const newIconSrc = isWished ? '/images/svg/iconUtilWish.svg' : '/images/svg/iconUtilWishOn.svg';

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ 
                salesPostId: salesPostId, 
                customerId: customerId
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
