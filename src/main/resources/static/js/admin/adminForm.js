document.addEventListener('DOMContentLoaded', function() {
    var username = document.getElementById('username');
    var password = document.getElementById('password');
    var confirmPassword = document.getElementById('confirmPassword');
    var name = document.getElementById('name');
    var accessLevel = document.getElementById('accessLevel');
    var submitButton = document.getElementById('submitButton');
    
    username.addEventListener('blur', function() {
        fetch('/checkDuplicateUsername?username=' + encodeURIComponent(username.value))
            .then(response => response.json())
            .then(data => {
                var usernameFeedback = document.getElementById('usernameFeedback');
                if (data) {
                    usernameFeedback.innerHTML = '<p class="text-danger">이미 사용중인 아이디입니다.</p>';
                    usernameFeedback.style.display = 'block';
                } else {
                    usernameFeedback.style.display = 'none';
                }
                updateButtonStatus();
            });
    });

    confirmPassword.addEventListener('input', function() {
        var passwordFeedback = document.getElementById('passwordFeedback');
        if (password.value !== confirmPassword.value) {
            passwordFeedback.innerHTML = '<p class="text-danger">비밀번호가 일치하지 않습니다.</p>';
            passwordFeedback.style.display = 'block';
        } else {
            passwordFeedback.style.display = 'none';
        }
        updateButtonStatus();
    });

    function updateButtonStatus() {
        var isFormValid = username.value && password.value && confirmPassword.value && name.value && accessLevel.value &&
            password.value === confirmPassword.value && document.getElementById('usernameFeedback').style.display === 'none';
        submitButton.disabled = !isFormValid;
    }

    var inputs = document.querySelectorAll('input, select');
    inputs.forEach(input => {
        input.addEventListener('input', updateButtonStatus);
    });

    adminForm.addEventListener('submit', async function(event) {
        event.preventDefault();

        if (password.value !== confirmPassword.value) {
            alert('비밀번호가 일치하지 않습니다.');
            return;
        }

        const formData = new FormData(adminForm);
        const data = {};

        formData.forEach((value, key) => {
            data[key] = value;
        });

        try {
            const response = await fetch(adminForm.action, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });

            if (response.ok) {
                const message = await response.text();
                alert(message);

                if (window.opener) {
                    window.opener.loadContent('/admin/adminManagement', 'adminManagement', true);
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
