document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.mini span').forEach(span => {
        span.addEventListener('click', function() {
            var bigImage = document.getElementById('bigImage');
            var newSrc = this.getAttribute('data-image');
            bigImage.setAttribute('src', newSrc);
        });
    });
	
	function toggleMoreContent(id) {
        var content = document.getElementById('more-content-' + id);
        var btn = document.getElementById('more-btn-' + id);
        var thumbnail = document.getElementById('thumbnail-' + id);

        if (content.style.display === 'none' || content.style.display === '') {
            content.style.display = 'flex';
            thumbnail.style.display = 'none'; // 작은 이미지 숨기기
            btn.innerText = '닫기';
        } else {
            content.style.display = 'none';
            thumbnail.style.display = 'block'; // 작은 이미지 보이기
            btn.innerText = '더보기';
        }
    }
});
