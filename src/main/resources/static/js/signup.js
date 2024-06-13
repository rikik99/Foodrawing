document.addEventListener('DOMContentLoaded', function() {
    var signin1 = true;
    var signin2 = true;
    var signin3 = true;
    var signin4 = true;
    var signin5 = true;
    var signin6 = true;
    var signin7 = true; // 비밀번호 확인 필드 유효성 검사 결과 추가

    var username = document.getElementById('username');
    var password = document.getElementById('password');
    var confirmPassword = document.getElementById('confirm-password');
    var nickname = document.getElementById('nickname');
    var email = document.getElementById('email');
    var phone = document.getElementById('phone');
    var name = document.getElementById('name');
    var btnSignin = document.getElementById('signup-btn');
    var authCheckBtn = document.getElementById('auth-check');
    var referrerCheckBtn = document.getElementById('referrer-check');

    function updateButtonStatus() {
        btnSignin.disabled = !(signin1 && signin2 && signin3 && signin4 && signin5 && signin6 && signin7);
    }

    function validateField(field, regex, invalidId, errorMsg) {
        var feedbackElement = document.getElementById(invalidId);

        if (!feedbackElement) {
            feedbackElement = document.createElement('div');
            feedbackElement.id = invalidId;
            feedbackElement.className = 'text-danger';
            field.parentNode.insertBefore(feedbackElement, field.nextSibling);
        }

        if (field.value.trim() === "") {
            feedbackElement.style.display = 'none';
            feedbackElement.textContent = ''; // 비어있을 때 메시지 초기화
            return true;
        } else if (regex.test(field.value)) {
            feedbackElement.style.display = 'none';
            feedbackElement.textContent = ''; // 유효할 때 메시지 초기화
            if (field.nextElementSibling && field.nextElementSibling.classList.contains('check-icon')) {
                field.nextElementSibling.style.display = 'inline'; // 유효성 검사 통과 시 아이콘 표시
            }
            return true;
        } else {
            feedbackElement.textContent = errorMsg;
            feedbackElement.style.display = 'block';
            if (field.nextElementSibling && field.nextElementSibling.classList.contains('check-icon')) {
                field.nextElementSibling.style.display = 'none'; // 유효성 검사 실패 시 아이콘 숨김
            }
            return false;
        }
    }

    function validateConfirmPassword() {
        var feedbackElement = document.getElementById('invalidPwCheck');

        if (!feedbackElement) {
            feedbackElement = document.createElement('div');
            feedbackElement.id = 'invalidPwCheck';
            feedbackElement.className = 'text-danger';
            confirmPassword.parentNode.insertBefore(feedbackElement, confirmPassword.nextSibling);
        }

        if (confirmPassword.value.trim() === "") {
            feedbackElement.style.display = 'none';
            feedbackElement.textContent = ''; // 비어있을 때 메시지 초기화
            return true;
        } else if (confirmPassword.value === password.value) {
            feedbackElement.style.display = 'none';
            feedbackElement.textContent = ''; // 유효할 때 메시지 초기화
            return true;
        } else {
            feedbackElement.textContent = '비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.';
            feedbackElement.style.display = 'block';
            return false;
        }
    }

    username.addEventListener('blur', function() {
        fetch('/checkDuplicateUsername?username=' + encodeURIComponent(username.value))
            .then(response => response.json())
            .then(data => {
                var usernameFeedback = document.getElementById('usernameFeedback');
                if (data === true) {
                    usernameFeedback.innerHTML = '<p class="text-danger">이미 사용중인 아이디입니다.</p>';
                    usernameFeedback.style.display = 'block';
                    signin1 = false;
                } else {
                    usernameFeedback.style.display = 'none';
                    signin1 = validateField(username, /^[a-z0-9]{6,20}$/, 'usernameFeedback', '사용할 수 없는 아이디입니다. 영문 소문자와 숫자를 조합해 6자 이상 입력해주세요.');
                }
                updateButtonStatus();
            });
    });

    password.addEventListener('blur', function() {
        signin2 = validateField(password, /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/, 'invalidPw', '비밀번호는 숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
        updateButtonStatus();
    });

    confirmPassword.addEventListener('blur', function() {
        signin7 = validateConfirmPassword();
        updateButtonStatus();
    });

    confirmPassword.addEventListener('input', function() {
        signin7 = validateConfirmPassword();
        updateButtonStatus();
    });

    nickname.addEventListener('blur', function() {
        signin3 = validateField(nickname, /^[a-z가-힣]{1}[a-z가-힣0-9._-]{1,15}$/, 'invalidNickname', '닉네임은 2자 이상 16자 이하로 입력해주세요.');
        updateButtonStatus();
    });

    email.addEventListener('blur', function() {
        signin4 = validateField(email, /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, 'invalidEmail', '이메일 주소를 확인해주세요.');
        updateButtonStatus();
    });

    phone.addEventListener('blur', function() {
        signin5 = validateField(phone, /^010-[0-9]{3,4}-[0-9]{4}$/, 'invalidPhone', '전화번호를 확인해주세요. 전화번호는 "010-"으로 시작해야 합니다.');
        updateButtonStatus();
    });

    phone.addEventListener('input', function() {
        var value = phone.value.replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거

        if (value.length > 0 && !value.startsWith('010')) {
            value = '010' + value;
        }

        if (value.length > 3 && value.length <= 7) {
            value = value.slice(0, 3) + '-' + value.slice(3);
        } else if (value.length > 7) {
            value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7);
        }

        phone.value = value;
    });

    name.addEventListener('blur', function() {
        signin6 = validateField(name, /^([가-힣]{2,18}|[a-zA-Z\s]{2,20})$/, 'invalidName', '이름을 올바르게 입력해주세요. (한글: 2~18자, 영어: 2~20자)');
        updateButtonStatus();
    });

    btnSignin.addEventListener('click', function(event) {
        if (!signin1 || !signin2 || !signin3 || !signin4 || !signin5 || !signin6 || !signin7) {
            console.log(signin1, signin2, signin3, signin4, signin5, signin6, signin7);
            event.preventDefault(); // 폼 제출 방지
            return false;
        } else {
            // 폼이 유효하면 제출됩니다.
            return true;
        }
    });

    authCheckBtn.addEventListener('click', function() {
        startEmailVerification();
    });

    referrerCheckBtn.addEventListener('click', function() {
        execDaumPostcode();
    });
    
 window.onbeforeunload = function() {
        var email = document.getElementById('email').value;
        if (email) {
            fetch('/invalidateSession', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'email=' + encodeURIComponent(email),
                keepalive: true
            }).then(response => {
                if (response.ok) {
                    window.location.href = '/login';
                } else {
                    console.error('Failed to invalidate session');
                }
            }).catch(error => {
                console.error('Error invalidating session:', error);
            });
        }
    };
	
});

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 도로명 주소 사용
                addr = data.roadAddress;
            } else { // 지번 주소 사용
                addr = data.jibunAddress;
            }

            // 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById('address').value = addr;

            // 참고항목 문자열이 있을 경우 추가한다.
            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById('addressDetail').value = extraAddr;
            } else {
                document.getElementById('addressDetail').value = '';
            }

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('addressDetail').focus();
        }
    }).open();
}

function startEmailVerification() {
    var email = document.getElementById('email');
    var emailFeedback = document.getElementById('invalidEmail');
    if (!email.value) {
        alert("이메일 주소를 입력해주세요.");
        return;
    }

    fetch("/sendVerificationEmail", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "email=" + encodeURIComponent(email.value)
    })
        .then(response => {
            if (response.ok) {
                return response.text();
            } else {
                throw new Error("이메일 인증 요청에 실패했습니다.");
            }
        })
        .then(text => {
            alert(text);
            emailFeedback.textContent = text.includes("이미 인증된 이메일입니다.") ? text : '';
        })
        .catch(error => {
            alert(error.message);
        });
}

function checkAll(mainCheckbox) {
    var checkboxes = document.getElementsByName('terms');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = mainCheckbox.checked;
    }
}

function toggleTerms(termId) {
    var termContent = document.getElementById(termId);
    if (termContent.style.display === "none" || termContent.style.display === "") {
        termContent.style.display = "block";
    } else {
        termContent.style.display = "none";
    }
}
