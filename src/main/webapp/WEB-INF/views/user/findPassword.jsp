<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/findPassword.css' />">
<script>
document.addEventListener('DOMContentLoaded', function() {
    var usernameInput = document.getElementById('username');
    var nameInput = document.getElementById('name');
    var emailInput = document.getElementById('email');
    var submitButton = document.querySelector('button[type="submit"]');
    var usernameError = document.getElementById('invalidusername');
    var nameError = document.getElementById('invalidName');
    var emailError = document.getElementById('invalidEmail');
    var codeInput = document.getElementById('code');
    var verifyButton = document.getElementById('verifyButton');
    var invalidCode = document.getElementById('invalidCode');

    function validateField(field, regex, errorElement, errorMessage) {
        if (!field.value.trim()) {
            errorElement.style.display = 'none';
            return false;
        }
        if (!regex.test(field.value.trim())) {
            errorElement.textContent = errorMessage;
            errorElement.style.display = 'block';
            field.style.color = '#aaa';
            return false;
        } else {
            errorElement.style.display = 'none';
            field.style.color = '#000';
            return true;
        }
    }

    function updateButtonStatus() {
        submitButton.disabled = !(validateField(usernameInput, /^[a-zA-Z0-9]{4,20}$/, usernameError, '아이디를 올바르게 입력해주세요.') &&
                                validateField(nameInput, /^([가-힣]{2,18}|[a-zA-Z\s]{2,20})$/, nameError, '이름을 올바르게 입력해주세요. (한글: 2~18자, 영어: 2~20자)') && 
                                validateField(emailInput, /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, emailError, '이메일 주소를 확인해주세요.'));
    }

    usernameInput.addEventListener('blur', function() {
        validateField(usernameInput, /^[a-zA-Z0-9]{4,20}$/, usernameError, '아이디를 올바르게 입력해주세요.');
        updateButtonStatus();
    });

    nameInput.addEventListener('blur', function() {
        validateField(nameInput, /^([가-힣]{2,18}|[a-zA-Z\s]{2,20})$/, nameError, '이름을 올바르게 입력해주세요. (한글: 2~18자, 영어: 2~20자)');
        updateButtonStatus();
    });

    emailInput.addEventListener('blur', function() {
        validateField(emailInput, /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, emailError, '이메일 주소를 확인해주세요.');
        updateButtonStatus();
    });

    usernameInput.addEventListener('input', updateButtonStatus);
    nameInput.addEventListener('input', updateButtonStatus);
    emailInput.addEventListener('input', updateButtonStatus);

    codeInput.addEventListener('input', function() {
        verifyButton.disabled = !codeInput.value.trim();
    });
    
    updateButtonStatus(); // 초기 상태 설정

    // 인증 코드 요청
    submitButton.addEventListener('click', function(event) {
        event.preventDefault();
        var data = {
            username: usernameInput.value,
            name: nameInput.value,
            email: emailInput.value
        };
        fetch('/findPassword', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        }).then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('인증 코드가 이메일로 발송되었습니다.');
            } else {
                alert(data.message);
            }
        }).catch(error => {
            console.error('Error:', error);
        });
    });

    // 인증 코드 검증
    verifyButton.addEventListener('click', function(event) {
        event.preventDefault();
        var data = {
            code: codeInput.value,
            email: emailInput.value
        };
        fetch('/verify-password-code', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        }).then(response => response.json())
        .then(data => {
            if (data.success) {
                window.location.href = '/passwordReset';
            } else {
                invalidCode.textContent = '올바르지 않은 인증 코드입니다.';
                invalidCode.style.display = 'block';
            }
        }).catch(error => {
            console.error('Error:', error);
        });
    });
});
</script>
</head>
<body>
<div>
    <h2>비밀번호 찾기</h2>
    <div class="container">
        <h4><b>회원 비밀번호 찾기</b></h4>
        <form>
            <label for="username" class="name-label">아이디</label> 
            <input type="text" name="username" placeholder="아이디를 입력해 주세요." id="username" class="find-input">
            <div id="invalidusername" class="error-message"></div>

            <label for="name" class="name-label">이름</label> 
            <input type="text" name="name" placeholder="이름을 입력해 주세요." id="name" class="find-input">
            <div id="invalidName" class="error-message"></div>
            
            <label for="email" class="email-label">이메일</label> 
            <input type="email" name="email" placeholder="이메일을 입력해 주세요." id="email" class="find-input">
            <div id="invalidEmail" class="error-message"></div>
            
            <button type="submit" disabled="disabled">인증번호 받기</button>
        </form>
        <form>
            <label for="code">인증 코드</label>
            <input type="text" id="code" name="code" class="find-input" required>
            <input type="hidden" name="email" id="hiddenEmail">
            <button id="verifyButton" type="submit" disabled>확인</button>
            <div id="invalidCode" class="error-message" style="display: none;"></div>
        </form>
    </div>
</div>
</body>
</html>
