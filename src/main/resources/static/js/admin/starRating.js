function setupStarRating() {
    document.addEventListener('click', function(e) {
        const star = e.target.closest('.star');
        if (star) {
            const value = star.getAttribute('data-value');
            const ratingInput = document.getElementById('rating');
            const stars = document.querySelectorAll('.star-rating .star');

            if (ratingInput.value === value) {
                ratingInput.value = '';
                stars.forEach(s => {
                    s.classList.remove('selected');
                    s.classList.remove('checked');
                });
            } else {
                ratingInput.value = value;
                stars.forEach(s => {
                    s.classList.remove('selected');
                    s.classList.remove('checked');
                });
                star.classList.add('selected');
                star.classList.add('checked');
                let previousSibling = star.previousElementSibling;
                while (previousSibling) {
                    previousSibling.classList.add('selected');
                    previousSibling = previousSibling.previousElementSibling;
                }
            }
        }
    });

    document.addEventListener('mouseover', function(e) {
        const star = e.target.closest('.star');
        if (star) {
            const stars = document.querySelectorAll('.star-rating .star');
            stars.forEach(s => s.classList.remove('hover'));
            star.classList.add('hover');
            let previousSibling = star.previousElementSibling;
            while (previousSibling) {
                previousSibling.classList.add('hover');
                previousSibling = previousSibling.previousElementSibling;
            }
        }
    });

    document.addEventListener('mouseout', function(e) {
        const star = e.target.closest('.star');
        if (star) {
            const stars = document.querySelectorAll('.star-rating .star');
            stars.forEach(s => s.classList.remove('hover'));
        }
    });
}
