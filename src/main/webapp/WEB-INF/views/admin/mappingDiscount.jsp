<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/admin/common.css" />
    <link rel="stylesheet" href="/css/admin/targetAdd.css" />
</head>
<body class="dark-mode">
    <div class="discount-form-container">
        <form id="insertDiscountForm" method="post" action="/admin/insertDiscountTarget" class="discount-form">
            <h1>할인 매핑</h1>
            <table class="form-table">
                <tr>
                    <td><label for="discountId">할인 목록</label></td>
                    <td>
                        <select id="discountId" name="discountId" class="discountId">
                            <option value=""></option>
                            <c:forEach items="${discounts}" var="discount">
                                <option value="${discount.id}">${discount.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="targetType">할인 대상</label></td>
                    <td>
                        <select id="targetType" name="targetType" class="targetType">
                            <option value=""></option>
                            <option value="ALL">전체</option>
                            <option value="PRODUCT">상품</option>
                            <option value="MEMBER_RATING">회원 등급</option>
                            <option value="CUSTOMER">회원</option>
                            <option value="CATEGORY">카테고리</option>
                        </select>
                    </td>
                </tr>
                <tr id="targetIdRow" style="display: none;">
                    <td><label for="targetId">대상 선택</label></td>
                    <td>
                        <select id="targetId" name="targetId"></select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><button type="submit" class="primary">등록</button></td>
                </tr>
            </table>
        </form>
        <div class="form-container">
            <div class="suggestions-container">
                <h2>검색 결과</h2>
                <div id="suggestions"></div>
            </div>
            <div class="selected-targets-container">
                <h2>선택된 항목</h2>
                <ul id="selectedTargets"></ul>
            </div>
        </div>
    </div>
    
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:forEach begin="1" end="${pageCount}" var="i">
                <li class="page-item ${currentPage + 1 == i ? 'active' : ''}">
                    <a class="page-link" href="javascript:void(0);" data-page="${i - 1}" data-url="/admin/discountList" data-size="${size}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const targetTypeSelect = document.getElementById('targetType');
        const targetIdRow = document.getElementById('targetIdRow');
        const targetIdInput = document.getElementById('targetId');
        const targetIdSelect = document.getElementById('targetId');
        const suggestionsDiv = document.getElementById('suggestions');
        const selectedTargetsList = document.getElementById('selectedTargets');
        const pagination = document.querySelector('.pagination');

        const memberRatingOptions = [
            { value: '1', text: '일반' },
            { value: '2', text: '우수' },
            { value: '3', text: '프리미엄' },
            { value: '4', text: 'VIP' },
            { value: '6', text: 'VVIP' }
        ];

        const categoryOptions = [
            { value: '1', text: '국,탕,찌개' },
            { value: '2', text: '닭고기' },
            { value: '3', text: '돼지고기' },
            { value: '4', text: '면요리' },
            { value: '5', text: '볶음밥,죽' },
            { value: '6', text: '분식,스낵류' },
            { value: '7', text: '소고기' },
            { value: '8', text: '야채' },
            { value: '9', text: '어패류' }
        ];

        targetTypeSelect.addEventListener('change', function() {
            const targetType = targetTypeSelect.value;
            if (targetType === 'PRODUCT' || targetType === 'CUSTOMER') {
                targetIdRow.style.display = '';
                targetIdInput.style.display = 'block';
                targetIdSelect.style.display = 'none';
                fetchTargets(targetType, 0, 5); // 초기 페이지는 0, 페이지 크기는 5로 설정
            } else if (targetType === 'MEMBER_RATING') {
                targetIdRow.style.display = '';
                targetIdInput.style.display = 'none';
                targetIdSelect.style.display = 'block';
                populateOptions(memberRatingOptions);
            } else if (targetType === 'CATEGORY') {
                targetIdRow.style.display = '';
                targetIdInput.style.display = 'none';
                targetIdSelect.style.display = 'block';
                populateOptions(categoryOptions);
            } else if (targetType === 'ALL') {
                targetIdRow.style.display = '';
                targetIdInput.style.display = 'none';
                targetIdSelect.style.display = 'none';
                addSelectedTarget('ALL', '전체', '0');
            } else {
                targetIdRow.style.display = 'none';
                suggestionsDiv.innerHTML = '';
                selectedTargetsList.innerHTML = '';
            }
        });

        function populateOptions(options) {
            targetIdSelect.innerHTML = '';
            options.forEach(option => {
                const opt = document.createElement('option');
                opt.value = option.value;
                opt.text = option.text;
                targetIdSelect.appendChild(opt);
            });
        }

        targetIdSelect.addEventListener('change', function() {
            const selectedOption = targetIdSelect.options[targetIdSelect.selectedIndex];
            addSelectedTarget(targetTypeSelect.value, selectedOption.text, selectedOption.value);
        });

        targetIdInput.addEventListener('input', function() {
            const query = targetIdInput.value;
            const targetType = targetTypeSelect.value;
            if (query.length > 0) {
                fetchTargets(targetType, 0, 5, query); // 검색어가 있을 때
            } else {
                fetchTargets(targetType, 0, 5); // 검색어가 없을 때
            }
        });

        function addSelectedTarget(type, name, id) {
            const listItem = document.createElement('li');
            listItem.className = 'selected-target';
            listItem.dataset.id = id;
            listItem.dataset.type = type;
            listItem.innerHTML = `
                <div class="target-info">
                    <strong>\${type} 번호:</strong> \${id} <br>
                    <strong>이름:</strong> \${name}
                </div>
            `;
            const removeButton = document.createElement('button');
            removeButton.className = 'removeTarget';
            removeButton.textContent = 'Remove';
            removeButton.addEventListener('click', function() {
                listItem.remove();
            });
            listItem.appendChild(removeButton);
            selectedTargetsList.appendChild(listItem);
        }

        function fetchTargets(targetType, page, size, query = '') {
            fetch(`/admin/getTargets?targetType=\${targetType}&keyword=\${query}&page=\${page}&size=\${size}`)
                .then(response => response.json())
                .then(data => {
                    suggestionsDiv.innerHTML = '';
                    if (targetType === 'PRODUCT') {
                        data.content.forEach(item => {
                            const suggestion = document.createElement('div');
                            suggestion.className = 'suggestion-item';
                            suggestion.dataset.id = item.productNumber;
                            suggestion.dataset.name = item.name;
                            suggestion.dataset.price = item.price;
                            suggestion.dataset.quantity = item.quantity;
                            suggestion.innerHTML = `
                                <strong>상품 번호:</strong> \${item.productNumber} <br>
                                <strong>이름:</strong> \${item.name} <br>
                                <strong>가격:</strong> \${item.price}원 <br>
                                <strong>수량:</strong> \${item.quantity}개
                            `;
                            suggestionsDiv.appendChild(suggestion);
                        });
                    } else if (targetType === 'CUSTOMER') {
                        data.content.forEach(item => {
                            const suggestion = document.createElement('div');
                            suggestion.className = 'suggestion-item';
                            suggestion.dataset.id = item.id;
                            suggestion.dataset.username = item.userDTO.username;
                            suggestion.dataset.createdDate = item.userDTO.createdDate;
                            suggestion.dataset.birthDate = item.birthDate;
                            suggestion.dataset.gender = item.gender;
                            suggestion.innerHTML = `
                                <strong>사용자명:</strong> \${item.userDTO.username} <br>
                                <strong>가입 날짜:</strong> \${item.userDTO.createdDate} <br>
                                <strong>생년월일:</strong> \${item.birthDate} <br>
                                <strong>성별:</strong> \${item.gender}
                            `;
                            suggestionsDiv.appendChild(suggestion);
                        });
                    }

                    document.querySelectorAll('.suggestion-item').forEach(item => {
                        item.addEventListener('click', function() {
                            const id = this.dataset.id;
                            const name = this.dataset.name || this.dataset.username;
                            const price = this.dataset.price || '';
                            const quantity = this.dataset.quantity || '';
                            const listItem = document.createElement('li');
                            listItem.className = 'selected-target';
                            listItem.dataset.id = id;
                            listItem.innerHTML = `
                                <div class="target-info">
                                    <strong>상품 번호:</strong> \${id} <br>
                                    <strong>이름:</strong> \${name} <br>
                                    \${price && `<strong>가격:</strong> \${price}원 <br>`}
                                    \${quantity && `<strong>수량:</strong> \${quantity}개`}
                                </div>
                            `;
                            const removeButton = document.createElement('button');
                            removeButton.className = 'removeTarget';
                            removeButton.textContent = 'Remove';
                            removeButton.addEventListener('click', function() {
                                listItem.remove();
                            });
                            listItem.appendChild(removeButton);
                            selectedTargetsList.appendChild(listItem);
                        });
                    });

                    updatePagination(data.totalPages, page, size, targetType, query);
                });
        }

        function updatePagination(totalPages, currentPage, size, targetType, query) {
            pagination.innerHTML = '';
            for (let i = 0; i < totalPages; i++) {
                const li = document.createElement('li');
                li.className = `page-item \${currentPage === i ? 'active' : ''}`;
                const a = document.createElement('a');
                a.className = 'page-link';
                a.href = 'javascript:void(0);';
                a.dataset.page = i;
                a.dataset.size = size;
                a.textContent = i + 1;
                a.addEventListener('click', function() {
                    fetchTargets(targetType, i, size, query);
                });
                li.appendChild(a);
                pagination.appendChild(li);
            }
        }
        const form = document.getElementById('insertDiscountForm');

        form.addEventListener('submit', async function(event) {
            event.preventDefault();

            const selectedTargets = [];
            document.querySelectorAll('#selectedTargets li').forEach(item => {
                selectedTargets.push({
                    id: item.dataset.id,
                    type: targetTypeSelect.value
                });
            });

            const requestBody = { discountId: document.getElementById('discountId').value, targets: selectedTargets };

            try {
                console.log(JSON.stringify(requestBody)); // 요청 본문을 로그로 출력

                const response = await fetch(form.action, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(requestBody)
                });

                if (response.ok) {
                    const message = await response.text();
                    alert(message);

                    if (window.opener) {
                        window.opener.loadContent('/admin/discountTarget', 'discountTarget', true);
                        window.close();
                    }
                } else {
                    console.error('Failed to submit form');
                }
            } catch (error) {
                console.error('Error:', error);
            }
        });

    });
</script>

</body>
</html>
