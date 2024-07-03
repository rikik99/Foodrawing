document.addEventListener('DOMContentLoaded', function() {
    const quantityInputs = document.querySelectorAll('.quantity');
    const totalPriceElements = document.querySelectorAll('.total-price');
    const pricePerItem = parseInt(document.getElementById('productprice').value);

    function updateTotalPrice() {
        const quantity = parseInt(quantityInputs[0].value);
        totalPriceElements.forEach(totalPriceElement => {
            const totalPrice = quantity * pricePerItem;
            totalPriceElement.innerText = totalPrice.toLocaleString() + '원';
        });
        quantityInputs.forEach(input => {
            input.value = quantity;
        });
    }

    document.querySelectorAll('.increment').forEach(button => {
        button.addEventListener('click', function() {
            const quantity = parseInt(quantityInputs[0].value) + 1;
            quantityInputs.forEach(input => input.value = quantity);
            updateTotalPrice();
        });
    });

    document.querySelectorAll('.decrement').forEach(button => {
        button.addEventListener('click', function() {
            if (quantityInputs[0].value > 1) {
                const quantity = parseInt(quantityInputs[0].value) - 1;
                quantityInputs.forEach(input => input.value = quantity);
                updateTotalPrice();
            }
        });
    });

    updateTotalPrice();
});
