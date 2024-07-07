// inquiries.js
document.addEventListener('DOMContentLoaded', function () {
    loadInquiries(1);

    function loadInquiries(page) {
        const salesPostId = document.getElementById('salesPostId').value;

        fetch(`/inquiries/${salesPostId}?page=${page}&size=5`)
            .then(response => response.json())
            .then(data => {
                displayInquiries(data.inquiries);
                setupInquiryPagination(data.totalPages, data.currentPage);
            })
            .catch(error => console.error('Error fetching inquiries:', error));
    }

    function displayInquiries(inquiries) {
        const inquirySection = document.getElementById('inquiry-section');
        const loginCustomerId = document.getElementById('loginCustomerId').value; // 실제로는 로그인된 사용자의 ID를 가져와야 합니다.
        inquirySection.innerHTML = '';

        inquiries.forEach((inquiry, index) => {
            const reply = inquiry.responses ? inquiry.responses.message : null;
            const isSecret = inquiry.secret === '2';
            const isOwner = loginCustomerId && inquiry.customerId == loginCustomerId;
            const canView = !isSecret || isOwner;
            const inquiryItem = document.createElement('div');
            inquiryItem.className = 'inquiry-item';

            if (canView) {
                inquiryItem.setAttribute('onclick', `toggleInquiryAnswer(${index})`);
                inquiryItem.innerHTML = `
                    <div class="inquiry-info">
                        ${inquiry.resolvedYn === 'Y' ? '<span class="inquiry-badge text-dark">답변완료</span>' : '<span class="inquiry-badge text-dark">미답변</span>'}
                        ${isSecret ? '<span class="lock-icon">🔒</span>' : ''}
                        <span class="inquiry-content">${inquiry.subject}</span>
                    </div>
                    <div class="inquiry-meta">
                        <span class="inquiry-author">${inquiry.customer.nickname}</span>
                        <span class="inquiry-date">${new Date(inquiry.createdDate).toLocaleDateString()}</span>
                    </div>
                    <div id="inquiry-answer-${index}" class="inquiry-answer" style="display: none;">
                        <p>${inquiry.message}</p>
                        ${reply ? `
                            <div class="inquiry-answer-content">
                                <p><strong>관리자</strong></p>
                                <p>${reply}</p>
                            </div>
                        ` : ''}
                    </div>
                `;
            } else {
                inquiryItem.innerHTML = `
                    <div class="inquiry-info">
                        ${inquiry.resolvedYn === 'Y' ? '<span class="inquiry-badge text-dark">답변완료</span>' : '<span class="inquiry-badge text-dark">미답변</span>'}
                        <span class="lock-icon">🔒</span>
                        <span class="inquiry-content">비밀글입니다.</span>
                    </div>
                    <div class="inquiry-meta">
                        <span class="inquiry-author">${inquiry.customer.nickname}</span>
                        <span class="inquiry-date">${new Date(inquiry.createdDate).toLocaleDateString()}</span>
                    </div>
                `;
            }

            inquirySection.appendChild(inquiryItem);
        });
    }

    function setupInquiryPagination(totalPages, currentPage) {
        const pagination = document.getElementById('inquiry-pagination');
        pagination.innerHTML = '';

        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement('li');
            pageItem.className = 'page-item' + (i === currentPage ? ' active' : '');
            pageItem.innerHTML = `<a class="page-link" href="#">${i}</a>`;
            pageItem.addEventListener('click', (e) => {
                e.preventDefault();
                loadInquiries(i);
            });
            pagination.appendChild(pageItem);
        }
    }

    window.toggleInquiryAnswer = function (index) {
        const answer = document.getElementById(`inquiry-answer-${index}`);
        if (answer) {
            if (answer.style.display === 'none' || answer.style.display === '') {
                answer.style.display = 'block';
            } else {
                answer.style.display = 'none';
            }
        }
    };

    // 팝업 표시 함수
    function showInquiryPopup() {
        document.getElementById('inquiryPopupOverlay').style.display = 'flex';
    }

    // 팝업 숨김 함수
    function hideInquiryPopup() {
        document.getElementById('inquiryPopupOverlay').style.display = 'none';
    }

    // 상품 문의 등록 함수
    function submitInquiry() {
        const salesPostId = document.getElementById('salesPostId').value;
        const loginCustomerId = document.getElementById('loginCustomerId').value;
        const subject = document.getElementById('inquirySubject').value;
        const message = document.getElementById('inquiryMessage').value;
        const secret = document.getElementById('inquirySecret').checked ? 2 : 1;

        const inquiryData = {
            salesPostId: salesPostId,
            customerId: loginCustomerId,
            subject: subject,
            message: message,
            secret: secret
        };

        fetch('/inquiries/insert', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(inquiryData),
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json(); // JSON 응답으로 변환
        })
        .then(data => {
            hideInquiryPopup();
            alert('문의가 등록되었습니다. ');
            loadInquiries(1); // 문의 목록 비동기 로딩 함수 호출
        })
        .catch(error => {
            console.error('Error:', error);
            alert('문의 등록 중 오류가 발생했습니다.');
        });
    }

    // 공개된 함수들
    window.showInquiryPopup = showInquiryPopup;
    window.hideInquiryPopup = hideInquiryPopup;
    window.submitInquiry = submitInquiry;
});
