<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Link</title>
</head>
<body>
	<h1>Account Link</h1>
	<p>Email: ${email}</p>
	<form action="/linkAccount" method="post">
		<input type="hidden" name="email" value="${email}">
		<input type="hidden" name="provider" value="${provider}">
		<input type="hidden" name="providerId" value="${providerId}">
		<button type="submit">Link Account</button>
	</form>
	<script>
document.addEventListener('DOMContentLoaded', function() {
    window.onbeforeunload = function() {
        fetch('/invalidateSession', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
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
    };
});
</script>
</body>
</html>
