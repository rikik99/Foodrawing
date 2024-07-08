// reviews.js
document.addEventListener('DOMContentLoaded', function () {
    loadReviews(1);

    function loadReviews(page) {
        const salesPostId = document.getElementById('salesPostId').value;
        fetch(`/reviews/${salesPostId}?page=${page}&size=5`)
            .then(response => response.json())
            .then(data => {
                displayReviews(data.reviews);
                setupPagination(data.totalPages, data.currentPage);
            })
            .catch(error => console.error('Error fetching reviews:', error));
    }

    function displayReviews(reviews) {
        const reviewSection = document.getElementById('review-section');
        reviewSection.innerHTML = '';

        reviews.forEach((review, index) => {
            const reviewItem = document.createElement('div');
            reviewItem.className = 'review-item';

            let reviewContent = `
                <div class="review-details">
                    <div class="review-info">
                        <span class="review-rating">${'★'.repeat(review.rating)}</span>
                        <span class="review-author">${review.customer.nickname}</span>
                        <span class="review-date">${new Date(review.createdDate).toLocaleDateString()}</span>
                    </div>
                    <div class="review-content">
                        <div class="review-comment">
                            <p>${review.message}</p>
                        </div>
            `;

            if (review.files && review.files.filePath) {
                reviewContent += `
                    <div class="review-thumbnail">
                        <img id="thumbnail-${index}" src="${review.files.filePath}" alt="Review Image" onclick="toggleReviewMoreContent(${index})">
                    </div>
                    <div id="more-content-${index}" class="more-content">
                        <img src="${review.files.filePath}" class="full-size-img" alt="Full Review Image">
                `;
            }

            if (review.reply) {
                reviewContent += `
                    <div class="review-answer">
                        <p>${review.reply.message}</p>
                    </div>
                `;
            }

            if (review.files || review.reply) {
                reviewContent += `</div><div id="more-btn-${index}" class="more-btn" onclick="toggleReviewMoreContent(${index})">더보기</div>`;
            }

            reviewContent += `
                    </div>
                </div>
            `;

            reviewItem.innerHTML = reviewContent;
            reviewSection.appendChild(reviewItem);
        });
    }

    function setupPagination(totalPages, currentPage) {
        const pagination = document.querySelector('.pagination');
        pagination.innerHTML = '';

        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement('li');
            pageItem.className = 'page-item' + (i == currentPage ? ' active' : '');
            pageItem.innerHTML = `<a class="page-link" href="#">${i}</a>`;
            pageItem.addEventListener('click', (e) => {
                e.preventDefault();
                loadReviews(i);
            });
            pagination.appendChild(pageItem);
        }
    }
});

function toggleReviewMoreContent(index) {
    const moreContent = document.getElementById(`more-content-${index}`);
    const moreBtn = document.getElementById(`more-btn-${index}`);
    const thumbnail = document.getElementById(`thumbnail-${index}`);

    if (moreContent.style.display == 'none' || moreContent.style.display == '') {
        moreContent.style.display = 'flex';
        moreBtn.textContent = '닫기';
        thumbnail.style.display = 'none';
    } else {
        moreContent.style.display = 'none';
        moreBtn.textContent = '더보기';
        thumbnail.style.display = 'block';
    }
}
