async function updateProductNumber() {
	var categorySelect = document.getElementById("category");
	var categoryId = categorySelect.value;
	var productNumberInput = document.getElementById("productNumber");

	if (categoryId) {
		try {
			const response = await fetch(`/admin/nextProductNumber?id=${categoryId}`);
			if (response.ok) {
				const productNumber = await response.text();
				productNumberInput.value = productNumber;
			} else {
				console.error('Failed to fetch product number');
				productNumberInput.value = 'Error';
			}
		} catch (error) {
			console.error('Error:', error);
			productNumberInput.value = 'Error';
		}
	} else {
		productNumberInput.value = '상품코드';
	}
}

document.addEventListener('DOMContentLoaded', function() {
	var categorySelect = document.getElementById("category");
	categorySelect.addEventListener('change', updateProductNumber);
   const insertProductForm = document.getElementById('insertProductForm');

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

    const fileInput = document.getElementById('file');
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
});