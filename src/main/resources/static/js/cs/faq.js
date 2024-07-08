document.addEventListener('DOMContentLoaded', function() {
    let currentFilter = '';

    function loadFaqs(query, page) {
        fetch('/cs/csMain', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json;charset=UTF-8'
            },
            body: JSON.stringify({ query: query, page: page, filter: currentFilter })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            displayFaqs(data.faqs);
            setupPagination(data.totalPages, page);
        })
        .catch(error => {
            console.error('Error loading FAQs:', error);
        });
    }

    function displayFaqs(faqs) {
        var faqList = document.getElementById('faqList');
        faqList.innerHTML = '';
        faqs.forEach(function(faq) {
            var faqItem = document.createElement('div');
            faqItem.className = 'list-group-item faq-item';
            faqItem.innerHTML = '<h5>' + faq.question + '<span class="arrow"><img src="images/icon/arrow.png" /></span></h5><div class="faq-answer">' + faq.answer + '</div>';
            faqList.appendChild(faqItem);
        });

        var faqItems = document.querySelectorAll('.faq-item');
        faqItems.forEach(function(item) {
            item.addEventListener('click', function() {
                faqItems.forEach(function(i) {
                    if (i !== item) {
                        i.classList.remove('active');
                        i.querySelector('.faq-answer').style.display = 'none';
                        i.querySelector('.arrow').style.transform = 'rotate(90deg)'; // 기본 화살표 상태로
                    }
                });
                item.classList.toggle('active');
                var answer = item.querySelector('.faq-answer');
                var arrow = item.querySelector('.arrow');
                if (item.classList.contains('active')) {
                    answer.style.display = 'block';
                    arrow.style.transform = 'rotate(-90deg)'; // 화살표 회전
                } else {
                    answer.style.display = 'none';
                    arrow.style.transform = 'rotate(90deg)'; // 기본 화살표 상태로
                }
            });
        });
    }

    function setupPagination(totalPages, currentPage) {
        var pagination = document.getElementById('pagination');
        pagination.innerHTML = '';

        var createPageItem = function(page, label, disabled) {
            var li = document.createElement('li');
            li.className = 'page-item' + (page === currentPage ? ' active' : '') + (disabled ? ' disabled' : '');
            var a = document.createElement('a');
            a.className = 'page-link';
            a.href = '#';
            a.innerText = label;
            if (!disabled) {
                a.addEventListener('click', function(e) {
                    e.preventDefault();
                    loadFaqs(document.getElementById('searchQuery').value, page);
                });
            }
            li.appendChild(a);
            return li;
        };

        if (totalPages > 1) {
            if (currentPage > 1) {
                pagination.appendChild(createPageItem(1, '<<', false));
                pagination.appendChild(createPageItem(currentPage - 1, '<', false));
            }

            for (var i = 1; i <= totalPages; i++) {
                pagination.appendChild(createPageItem(i, i, false));
            }

            if (currentPage < totalPages) {
                pagination.appendChild(createPageItem(currentPage + 1, '>', false));
                pagination.appendChild(createPageItem(totalPages, '>>', false));
            }
        } else {
            pagination.appendChild(createPageItem(1, '1', false));
        }
    }

    document.getElementById('searchButton').addEventListener('click', function() {
        loadFaqs(document.getElementById('searchQuery').value, 1);
    });

    document.getElementById('searchQuery').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            loadFaqs(document.getElementById('searchQuery').value, 1);
        }
    });

    var filterButtons = document.querySelectorAll('.filter-bar button');
    filterButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            if (this.classList.contains('active')) {
                this.classList.remove('active');
                currentFilter = '';
            } else {
                filterButtons.forEach(function(btn) {
                    btn.classList.remove('active');
                });
                this.classList.add('active');
                currentFilter = this.getAttribute('data-filter');
            }
            loadFaqs(currentFilter, 1);
        });
    });
    
    document.getElementById('contactButton').addEventListener('click', function() {
        window.location.href = '/mypage/contact'; // 1:1 문의 페이지로 이동
    });

    loadFaqs('', 1); // 초기 로딩
});
