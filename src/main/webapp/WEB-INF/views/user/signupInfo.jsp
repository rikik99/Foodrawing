<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Foodrawing 회원가입</title>
<style>
body {
	font-family: Arial, sans-serif;
}

.container {
	text-align: center;
	padding: 50px;
}

.benefits-wrapper {
	position: relative;
	margin-top: 40px;
	padding: 20px 0;
	width: 600px; /* 텍스트 길이에 맞추기 위해 고정 폭 설정 */
	margin-left: auto;
	margin-right: auto;
}

.benefits-wrapper::before, .benefits-wrapper::after {
	content: '';
	position: absolute;
	left: 0;
	right: 0;
	width: 100%;
	height: 1px;
	background: #ccc;
}

.benefits-wrapper::before {
	top: 0;
}

.benefits-wrapper::after {
	bottom: 0;
}

.benefits {
	display: flex;
	justify-content: space-between; /* 아이템 사이 간격 균일하게 */
}

.benefit-item {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 0 10px; /* 간격 조정 */
}

.benefit-item img {
	display: block;
	margin-bottom: 10px;
}

button {
	display: block;
	margin: 40px auto;
	padding: 10px 20px;
	font-size: 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #45a049;
}

h1 {
	margin-bottom: 20px;
}

p {
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<h1>회원가입</h1>
		<p>Foodrawing 회원에 가입하시면, 다양한 혜택 및 서비스를 제공 받으실 수 있습니다.</p>

		<div class="benefits-wrapper">
			<div class="benefits">
				<div class="benefit-item">
					<img src="images/processed_coupon-removebg-preview.png"
						alt="신규 가입 이벤트 쿠폰" width="50" height="50">
					<p>
						신규 가입 이벤트<br>쿠폰 제공
					</p>
				</div>
				<div class="benefit-item">
					<img src="images/centered_with_bg_points-removebg-preview.png"
						alt="포인트 적립" width="50" height="50">
					<p>
						다양한 Foodrawing<br>포인트 적립
					</p>
				</div>
				<div class="benefit-item">
					<img src="images/corrected_event-removebg-preview.png" alt="영수증 확인"
						width="50" height="50">
					<p>
						리뷰 작성 시<br>리워드 지급
					</p>
				</div>
				<div class="benefit-item">
					<img src="images/corrected_review-removebg-preview.png"
						alt="회원 전용 혜택" width="50" height="50">
					<p>
						회원 전용<br>혜택
					</p>
				</div>
			</div>
		</div>

		<button onclick="window.location.href='/signup'">Foodrawing
			회원 가입</button>
	</div>
</body>
</html>
