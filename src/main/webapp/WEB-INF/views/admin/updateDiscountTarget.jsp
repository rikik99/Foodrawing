<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="/css/admin/common.css" />
    <link rel="stylesheet" href="/css/admin/targetAdd.css" />
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const targetTypeElement = document.getElementById('targetType');

            targetTypeElement.addEventListener('change', function () {
                const targetType = targetTypeElement.value;

                fetch(`/admin/getDiscountTargets?targetType=\${targetType}`)
                    .then(response => response.json())
                    .then(data => {
                        const tbody = document.querySelector('.discount-table tbody');
                        let tableRows = '';

                        data.forEach(discount => {
                            tableRows += `
                                <tr data-discountId="\${discount.id}">
                                    <td class="discount-name-column"><input value="\${discount.discountDTO.name}" readonly="readonly"></td>
                                    <td class="discount-category-column">\${discount.discountDTO.type}</td>
                                    <td class="discount-targetType-column">
                                        <select name="targetType" class="targetType" onchange="updateTargetOptions(this, '\${discount.id}', '\${discount.targetId}')">
                                            <option value="ALL" \${discount.targetType === 'ALL' ? 'selected' : ''}>전체</option>
                                            <option value="PRODUCT" \${discount.targetType === 'PRODUCT' ? 'selected' : ''}>상품</option>
                                            <option value="MEMBER_RATING" \${discount.targetType === 'MEMBER_RATING' ? 'selected' : ''}>회원 등급</option>
                                            <option value="CATEGORY" \${discount.targetType === 'CATEGORY' ? 'selected' : ''}>카테고리</option>
                                        </select>
                                    </td>
                                    <td class="discount-targetId-column" id="targetId-\${discount.id}">
                                        \${discount.targetType === 'ALL' 
                                            ? `<select class="targetId" id="select-\${discount.id}"><option value="0">전체</option></select>` 
                                            : `<select class="targetId" id="select-\${discount.id}"></select>`
                                        }
                                    </td>
                                </tr>`;
                        });

                        tbody.innerHTML = tableRows;

                        data.forEach(discount => {
                            if (discount.targetType !== 'ALL') {
                                updateTargetOptions(
                                    document.querySelector(`#targetId-\${discount.id} .targetType`),
                                    discount.id,
                                    discount.targetId,
                                    discount.targetType
                                );
                            }
                        });
                    })
                    .catch(error => console.error('Error:', error));
            });

            const insertDiscountForm = document.getElementById('insertDiscountForm');
            insertDiscountForm.addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = new FormData(insertDiscountForm);
                const data = {};
                formData.forEach((value, key) => {
                    data[key] = value;
                });

                const discountData = [];
                document.querySelectorAll('.discount-table tbody tr').forEach(row => {
                    const discountId = row.getAttribute('data-discountId');
                    const targetType = row.querySelector('.targetType').value;
                    const targetId = row.querySelector('.targetId').value;
                    discountData.push({ discountId, targetType, targetId });
                });

                data.discountData = discountData;

                fetch('/admin/updateTarget', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                })
                    .then(response => response.json())
                    .then(result => {
                        alert('할인 대상이 성공적으로 수정되었습니다.');
                        if (window.opener) {
                            window.opener.loadContent('/admin/discountTarget', 'discountTarget', true);
                            window.close();
                        }
                    })
                    .catch(error => console.error('Error:', error));
            });
        });


        function updateTargetOptions(selectElement, discountId, currentTargetId, targetType) {
            if (!targetType) {
                targetType = selectElement.value;
            }

            fetch(`/admin/getTargetOptions?targetType=\${targetType}`)
            .then(response => response.json())
            .then(options => {
                const select = document.getElementById(`select-\${discountId}`);
                let targetOptionsHtml = '';

                if (targetType === 'PRODUCT' || targetType === 'CATEGORY' || targetType === 'MEMBER_RATING') {
                    options.forEach(option => {
                        targetOptionsHtml += `<option value="\${option.id || option.productNumber}" \${option.id === currentTargetId || option.productNumber === currentTargetId ? 'selected' : ''}>\${option.name || option.rating}</option>`;
                    });
                    select.innerHTML = targetOptionsHtml;
                } else if (targetType === 'ALL') {
                    select.innerHTML = `<option value="0">전체</option>`;
                } else {
                    select.innerHTML = `<input type="text" value="\${currentTargetId}" required="required">`;
                }
            })
            .catch(error => console.error('Error:', error));
    }
    </script>
</head>

<body class="dark-mode">
    <div class="discount-form-container">
        <form id="insertDiscountForm" method="post" action="/admin/insertDiscountTarget" class="discount-form">
            <h1>할인 대상 수정</h1>
            <table class="form-table">
                <tr>
                    <td><label for="targetType">할인 대상 선택</label></td>
                    <td>
                        <select id="targetType" name="targetType" class="targetType">
                            <option value="MODU">모두</option>
                            <option value="ALL">전체</option>
                            <option value="PRODUCT">상품</option>
                            <option value="MEMBER_RATING">회원 등급</option>
                            <option value="CATEGORY">카테고리</option>
                        </select>
                    </td>
                </tr>
            </table>
            <div class="form-container">
                <div class="discountTargetList">
                    <table class="discount-table product-list dark-mode">
                        <thead>
                            <tr>
                                <th class="discount-name-column">할인명</th>
                                <th class="discount-target-column">할인 종류</th>
                                <th class="discount-targetType-column">할인 대상</th>
                                <th class="discount-targetId-column">대상 이름</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <button type="submit" class="primary">등록</button>
        </form>
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
</body>

</html>
