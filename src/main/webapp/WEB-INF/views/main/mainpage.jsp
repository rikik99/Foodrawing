
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<title>Insert title here</title>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<style>
.section {
	padding-bottom: 20px; /* 선과 다음 섹션 사이의 여백 추가 */
	margin-bottom: 20px; /* 섹션 간의 여백 추가 */
}

.section.grid {
	display: grid;
	grid-template-columns: repeat(2, 6fr); /* 3개의 동일한 크기의 열 */
	grid-gap: 20px; /* 각 그리드 항목 사이의 간격 */
}

.section.grid {
	text-align: right; /* 그리드 항목 내부의 텍스트 가운데 정렬 */
}

.btn-group-vertical {
	border: 1px solid #ccc; /* 테두리 추가 */
	border-radius: 5px; /* 테두리 둥글게 */
	padding: 10px; /* 버튼 그룹 내부 여백 추가 */
}

.btn-group-vertical>button>img {
	width: 325px;
	height: 100px;
	border-radius: 20px;
}

.btn-group-vertical>button {
	width: 650px;
	height: 100px;
	border-radius: 20px;
}

.buttonText {
	position: absolute;
	top: 50%;
	left: 78%;
	transform: translate(-50%, -50%);
}

.btnGroup {
	position: relative;
	padding: 0px;
	margin: 0px;
	margin-bottom: 10px;
}

.image-container {
	width: 1400px;
	height: 300px;
	position: relative;
}

.image-container img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}

.image-controls {
	position: absolute;
	top: 50%;
	left: 0;
	right: 0;
	transform: translateY(-50%);
	display: flex;
	justify-content: space-between;
	padding: 0 20px;
}

.image-controls button {
	background-color: rgba(0, 0, 0, 0.5);
	border: none;
	color: white;
	font-size: 24px;
	padding: 10px;
	cursor: pointer;
	border-radius: 50%;
}

.image-controls button i {
	display: block;
}

.image-index {
	display: none;
}
/* 슬릭슬라이드 */
.grid-item {
	max-width: 800px;
	margin: 0 auto;
}

.slide_div img {
	max-width: 150px;
	max-height: 150px;
	object-fit: cover;
	margin-right: 20px;
}

.content-wrapper {
	display: flex;
	align-items: center;
}

.content-wrapper img {
	margin-right: 20px; /* 이미지와 텍스트 사이의 간격 조정 */
}
/* 슬라이드 버튼 제거 */
.slick-prev, .slick-next {
	display: none !important;
}

.saleicon {
	width: 35px;
	height: 35px;
}
</style>

</head>

<body>
	<main>
		<div class="image-container">
			<img id="image-container" src="/images/2.png" alt="이미지"
				style="width: 100%; height: 100%; object-fit: contain;">
			<div class="image-controls">
				<button id="prev-btn" class="prev-btn">
					<i class="fas fa-chevron-left"></i>
				</button>
				<button id="next-btn" class="next-btn">
					<i class="fas fa-chevron-right"></i>
				</button>
			</div>
			<div id="image-index" class="image-index">1/5</div>
		</div>


		<div class="section grid"
			style="border: 1px solid #ccc; padding: 20px; margin-top: 20px;">
			<div class="grid-item">
				<h3 style="text-align: center; font-weight: bold">
					할인품목<img src="/images/saleicon.png" class="saleicon">
				</h3>
				<div class="now-top item-area" id="discountMainArea">
					<div class="box">
						<a href="#" class="item-link"> <img src="/images/Na.jpg"
							style="margin: 10px; min-width: 230px; max-width: 315px; width: 100%;">


							<div class="box_list_title" style="text-align: left;">메뉴 제목</div>
						</a>
						<div class="box_list_sub" style="text-align: left;">메뉴 설명</div>
						<div class="box_list_price" style="text-align: left;">10000원</div>

					</div>
				</div>
			</div>

			<!--   슬릭슬라이드 -->

			<div class="grid-item"
				style="display: flex; flex-direction: column; align-items: left; padding-left: 20px;">
				<div class="slick_slider">
					<div class="slide_div">
						<a href="#" class="item-link">
							<div class="content-wrapper"
								style="display: flex; align-items: center;">
								<img src="/images/balance.jpg" alt="균형잡힌 식단">
								<div style="text-align: left;">
									<h4>균형잡힌 식단</h4>
						</a>
						<p>가격</p>
						<p>다양한 영양소가 포함된 균형잡힌 식단을 제공합니다.</p>
					</div>
				</div>
			</div>
			<div class="slide_div">
				<a href="#" class="item-link">
					<div class="content-wrapper"
						style="display: flex; align-items: center;">
						<img src="/images/balance.jpg" alt="균형잡힌 식단">
						<div style="text-align: left;">
							<h4>균형잡힌 식단</h4>
				</a>
				<p>가격</p>
				<p>다양한 영양소가 포함된 균형잡힌 식단을 제공합니다.</p>
			</div>
		</div>
		</div>
		<div class="slide_div">
			<a href="#" class="item-link">
				<div class="content-wrapper"
					style="display: flex; align-items: center;">
					<img src="/images/balance.jpg" alt="균형잡힌 식단">
					<div style="text-align: left;">
						<h4>균형잡힌 식단</h4>
			</a>
			<p>가격</p>
			<p>다양한 영양소가 포함된 균형잡힌 식단을 제공합니다.</p>
		</div>
		</div>
		</div>
		<div class="slide_div">
			<a href="#" class="item-link">
				<div class="content-wrapper"
					style="display: flex; align-items: center;">
					<img src="/images/balance.jpg" alt="균형잡힌 식단">
					<div style="text-align: left;">
						<h4>균형잡힌 식단</h4>
			</a>
			<p>가격</p>
			<p>다양한 영양소가 포함된 균형잡힌 식단을 제공합니다.</p>
		</div>
		</div>
		</div>
		<div class="slide_div">
			<a href="#" class="item-link">
				<div class="content-wrapper"
					style="display: flex; align-items: center;">
					<img src="/images/balance.jpg" alt="균형잡힌 식단">
					<div style="text-align: left;">
						<h4>균형잡힌 식단</h4>
			</a>
			<p>가격</p>
			<p>다양한 영양소가 포함된 균형잡힌 식단을 제공합니다.</p>
		</div>
		</div>
		</div>
		<div class="slide_div">
			<a href="#" class="item-link">
				<div class="content-wrapper"
					style="display: flex; align-items: center;">
					<img src="/images/balance.jpg" alt="균형잡힌 식단">
					<div style="text-align: left;">
						<h4>균형잡힌 식단</h4>
			</a>
			<p>가격</p>
			<p>다양한 영양소가 포함된 균형잡힌 식단을 제공합니다.</p>
		</div>
		</div>
		</div>
		</div>
		</div>
		</div>

		<div class="section" style="padding-left: 300px;">
			<main class="container">
 <h1>Product Details</h1>
    <p>Product Name: ${productDto.name}</p>
    <p>Product Price: ${productDto.price}</p>
    <p>Product Description: ${productDto.description}</p>
				</div>
			</main>




	<a href="/main/custompage">test</a>
</body>


<script>
const imageContainer = document.getElementById('image-container');
const prevBtn = document.getElementById('prev-btn');
const nextBtn = document.getElementById('next-btn');
const imageIndex = document.getElementById('image-index');

const images = ['/images/2.png', '/images/3.png','/images/7.png','/images/8.png','/images/9.png'];

let currentIndex = 0;

function changeImage() {
    currentIndex = (currentIndex + 1) % images.length;
    imageContainer.src = images[currentIndex];
    imageIndex.textContent = `${currentIndex + 1}/${images.length}`;
}

prevBtn.addEventListener('click', () => {
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    imageContainer.src = images[currentIndex];
    imageIndex.textContent = `${currentIndex + 1}/${images.length}`;
});

nextBtn.addEventListener('click', changeImage);

setInterval(changeImage, 3000);

// 슬릭슬라이드
// Slick Slider 초기화
$(document).ready(function() {
  $('.slick_slider').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    autoplay: true,
    vertical: true,
    autoplaySpeed: 1000,
    responsive: [
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1
        }
      }
    ]
  });
});


</script>

</html>