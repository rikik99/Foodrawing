<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/findUsername.css' />">
<script>
document.addEventListener('DOMContentLoaded', function() {
    var nameInput = document.getElementById('name');
    var emailInput = document.getElementById('email');
    var codeInput = document.getElementById('code');
    var submitButton = document.getElementById('submitBtn');
    var verifyButton = document.getElementById('verifyBtn');
    var nameError = document.getElementById('invalidName');
    var emailError = document.getElementById('invalidEmail');
    var codeError = document.getElementById('invalidCode');

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
        submitButton.disabled = !(validateField(nameInput, /^([가-힣]{2,18}|[a-zA-Z\s]{2,20})$/, nameError, '이름을 올바르게 입력해주세요. (한글: 2~18자, 영어: 2~20자)') && 
                                validateField(emailInput, /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, emailError, '이메일 주소를 확인해주세요.'));
    }

    nameInput.addEventListener('blur', function() {
        validateField(nameInput, /^([가-힣]{2,18}|[a-zA-Z\s]{2,20})$/, nameError, '이름을 올바르게 입력해주세요. (한글: 2~18자, 영어: 2~20자)');
        updateButtonStatus();
    });

    emailInput.addEventListener('blur', function() {
        validateField(emailInput, /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, emailError, '이메일 주소를 확인해주세요.');
        updateButtonStatus();
    });

    nameInput.addEventListener('input', updateButtonStatus);
    emailInput.addEventListener('input', updateButtonStatus);

    codeInput.addEventListener('input', function() {
        verifyButton.disabled = !codeInput.value.trim();
    });

    updateButtonStatus(); // 초기 상태 설정
    verifyButton.disabled = true; // 초기 상태 설정

    // 인증 코드 발송 요청
    submitButton.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 제출 동작 방지

        var name = nameInput.value.trim();
        var email = emailInput.value.trim();

        fetch('/findUsername', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ name: name, email: email })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('hiddenEmail').value = email; // 이메일 저장
                alert('인증 코드가 발송되었습니다.');
            } else {
                alert('인증 코드 발송에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });

    // 인증 코드 검증 결과를 처리하는 함수
    function handleVerificationResponse(response) {
        if (response.success) {
            window.location.href = "/showUsername?userId=" + response.userId; // 성공 시 아이디를 보여주는 페이지로 이동
        } else {
            codeError.textContent = response.message; // 오류 메시지 표시
            codeError.style.display = 'block';
        }
    }

    // 인증 코드 검증 요청
    verifyButton.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 제출 동작 방지

        var code = codeInput.value.trim();
        var email = document.getElementById('hiddenEmail').value.trim();

        fetch('/verify-id-code', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ code: code, email: email })
        })
        .then(response => response.json())
        .then(data => handleVerificationResponse(data))
        .catch(error => {
            console.error('Error:', error);
        });
    });
});
</script>
</head>
<body>
<div>
    <h2>아이디 찾기</h2>
    <div class="container">
        <h4><b>회원 아이디 찾기</b></h4>
        <form id="sendCodeForm">
            <label for="name" class="name-label">이름</label> 
            <input type="text" name="name" placeholder="이름을 입력해 주세요." id="name" class="find-input">
            <div id="invalidName" class="error-message"></div>
            
            <label for="email" class="email-label">이메일</label> 
            <input type="email" name="email" placeholder="이메일을 입력해 주세요." id="email" class="find-input">
            <div id="invalidEmail" class="error-message"></div>
            
            <button type="submit" id="submitBtn" disabled>인증번호 받기</button>
        </form>
        
        <form id="verifyCodeForm">
            <label for="code">인증 코드</label>
            <input type="text" id="code" name="code" class="find-input" required>
            <input type="hidden" id="hiddenEmail" name="email">
            <button type="submit" id="verifyBtn" disabled>확인</button>
            <div id="invalidCode" class="error-message" style="display:none;"></div>
        </form>
    </div>
</div>
</body>
</html>
