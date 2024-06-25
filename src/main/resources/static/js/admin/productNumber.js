async function updateProductDetails(source) {
    const selectElement = document.getElementById(source);
    const selectedValue = selectElement.value;
    const productNumberInput = document.getElementById("productNumber");
    const previewArea = document.querySelector('.previewArea');

    if (selectedValue) {
        let url = '';
        if (source === 'category') {
            url = `/admin/nextProductNumber?id=${selectedValue}`;
        } else if (source === 'productList') {
            url = `/admin/getProductDetails?name=${selectedValue}`;
        }

        try {
            const response = await fetch(url);
            if (response.ok) {
                const productDetails = await response.json();
                productNumberInput.value = productDetails.productCode || 'Error';
                previewArea.src = productDetails.imagePath || '/images/FooDrawing_Logo.png';
            } else {
                console.error('Failed to fetch product details');
                productNumberInput.value = 'Error';
                previewArea.src = '/images/FooDrawing_Logo.png';
            }
        } catch (error) {
            console.error('Error:', error);
            productNumberInput.value = 'Error';
            previewArea.src = '/images/FooDrawing_Logo.png';
        }
    } else {
        productNumberInput.value = '상품코드';
        previewArea.src = '/images/FooDrawing_Logo.png';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const categorySelect = document.getElementById("category");

    if (categorySelect) {
        categorySelect.addEventListener('change', function() {
            updateProductDetails('category');
        });
    }

    const insertProductForm = document.getElementById('insertProductForm');
    const insertSalsePostForm = document.getElementById('insertSalsePostForm');
    if (insertProductForm) {
    insertProductForm.addEventListener('submit', async function(event) {
        event.preventDefault();

        const formData = new FormData(insertProductForm);

        try {
            const response = await fetch(insertProductForm.action, {
                method: 'POST',
                body: formData
            });

            if (response.ok) {
                const message = await response.text();
                alert(message);

                if (window.opener) {
                    window.opener.loadContent('/admin/productManagement', 'productManagement', true);
                    window.close();
                }
            } else {
                console.error('Failed to submit form');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    });
    }
 if (insertSalsePostForm) {
        insertSalsePostForm.addEventListener('submit', async function(event) {
            event.preventDefault();

            const formData = new FormData(insertSalsePostForm);
            const fileDTOList = JSON.parse(localStorage.getItem('fileDTOList')) || [];

            const params = new URLSearchParams();
            formData.forEach((value, key) => {
                params.append(key, value);
            });

            try {
                const response = await fetch(insertSalsePostForm.action, {
                    method: 'POST',
                    body: params.toString() + '&fileDTOList=' + encodeURIComponent(JSON.stringify(fileDTOList)),
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                });

                if (response.ok) {
                    const message = await response.text();
                    alert(message);

                    // salesPost 페이지로 이동
                    loadContent('/admin/salesPost', 'salesPost', true);
                    localStorage.removeItem('fileDTOList'); // 파일 리스트 초기화
                } else {
                    console.error('Failed to submit form');
                }
            } catch (error) {
                console.error('Error:', error);
            }
        });
    }
    const fileInput = document.getElementById('file');
    if (fileInput) {
        const previewArea = document.querySelector('.previewArea');

        fileInput.addEventListener('change', function(e) {
            if (fileInput.files.length === 0) {
                previewArea.src = '/images/FooDrawing_Logo.png';
                return;
            }

            const file = e.target.files[0];
            const reader = new FileReader();

            reader.onload = function(e) {
                previewArea.src = e.target.result;
            };

            reader.readAsDataURL(file);
        });
    }
});
