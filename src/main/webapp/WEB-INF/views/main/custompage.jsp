<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Nutrient Graph</title>
<style>

/* 새로운 애니메이션 속성 및 변수 설정 */
@property --hue {
  initial-value: 0;
  syntax: '<number>';
  inherits: false;
}

@property --eval {
  initial-value: 0;
  syntax: '<number>';
  inherits: false;
}

body {
  width: 100vw;
  height: 100vh;
  overflow: auto; /* 스크롤 가능하도록 설정 */
  background-color: black;
  display: flex;
  flex-direction: column; /* Flex direction을 column으로 변경 */
  align-items: center;
  justify-content: flex-start; /* Flex start로 변경 */
  color: white;
  animation: rotate 8s linear infinite both, eval 19s linear infinite both;
  background-image: 
    radial-gradient(farthest-corner at 0% calc(var(--eval) * 100%), hsla(calc(var(--hue) * 360deg), 70%, 60%, 1), hsla(calc(var(--hue) * 360deg), 70%, 60%, 0) 80%),
    radial-gradient(farthest-corner at calc(var(--eval) * 100%) 100%, hsla(calc((var(--hue) + 0.15) * 360deg), 60%, 60%, 1), hsla(calc((var(--hue) + 0.2) * 360deg), 60%, 60%, 0) 110%),
    radial-gradient(farthest-corner at calc(100% - var(--eval) * 100%) 0%, hsla(calc((var(--hue) + 0.3) * 360deg), 60%, 60%, 1), hsla(calc((var(--hue) + 0.3) * 360deg), 60%, 60%, 0) 100%),
    radial-gradient(farthest-corner at 100% calc(100% - var(--eval) * 100%), hsla(calc((var(--hue) + 0.45) * 360deg), 70%, 60%, 1), hsla(calc((var(--hue) + 0.5) * 360deg), 70%, 60%, 0) 90%);
}

.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  padding: 20px;
  color: white; /* 텍스트 색상을 흰색으로 설정 */
  box-sizing: border-box; /* 요소 크기 계산 시 padding과 border 포함 */
}

.grid-container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  width: 100%;
  box-sizing: border-box; /* 요소 크기 계산 시 padding과 border 포함 */
}

.svg-container {
  display: none; /* 처음에는 그래프를 숨김 */
  justify-content: center;
  align-items: center;
  width: 400px;
  position: sticky;
  top: 0px; /* 스크롤 시 상단으로부터의 거리 */
  box-sizing: border-box;
  align-items: flex-start;
}

svg {
  max-width: 100%;
  height: auto;
  overflow: hidden;
  background-color: rgba(255, 255, 255, 0.5);
}


/* 육각형 기본 색상 */
.hexagon {
  fill: none;
  stroke: #FFDFCA;  /* 기본 육각형 색상 */
}

/* 애니메이션 실행 시 색상 */
#data-line {
  stroke: #FFE694;
}

.text {
  fill: #000; /* 텍스트 색상 변경 */
  font-size: 12px;
  font-family: Arial, sans-serif;
  text-anchor: middle;
}

.data-container-wrapper {
  display: none; /* 처음에는 데이터 컨테이너를 숨김 */
  width: 100%;
  text-align: center;
}

.data-container {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개의 아이템을 표시 */
  gap: 10px;
  box-sizing: border-box; /* 요소 크기 계산 시 padding과 border 포함 */
  width: 900px;
}

.data-item {
  background: white;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  text-align: center;
  cursor: pointer; /* 클릭 가능하게 커서 변경 */
  width: 100%; /* 넓이를 100%로 설정하여 반응형으로 만듦 */
  box-sizing: border-box; /* 요소 크기 계산 시 padding과 border 포함 */
  color: black;
}

.data-item img {
  max-width: 100%;
  width: 190px;
  height: 190px;
  border-radius: 10px;
}

.data-item h3, .data-item p {
  margin: 10px 0;
}

/* Button styling */
.btn6, .btn6:link, .btn6:visited {
  padding: 13px 5px;
  border: 0px solid #f0f0f0;
  color: #333;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 13px;
  letter-spacing: 3px;
  transition: all .2s ease-in-out;
  cursor: pointer;
  border-radius: 10px;
  margin: 5px; /* 각 버튼 사이의 간격 추가 */
}

.btn6 {
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.3);
}

.btn6:hover {
  background: #333;
  border: 1px solid #333;
  color: #fefefe;
}

.btn6.active {
  background: #333;
  border: 1px solid #333;
  color: #fefefe;
}

#product-name {
  font-size: 25px;
  fill: black;
}

.buttons-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
}

h1 {
  font-size: 10vw;
  background-image: inherit;
  animation: inherit;
  filter: brightness(1.5) drop-shadow(0rem 0.3rem 0rem rgba(0, 0, 0, 0.2));
  background-clip: text;
  -webkit-background-clip: text;
  color: transparent;
}

.buy-div {
	
}
.buy-btn {
	margin-right: 10px;
	padding: 5px;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	background-color: #5766ff;
	text-decoration-line: none;
	color: white;
}

.cart-btn {
	padding: 5px;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	background-color: #a1a1a1;
	text-decoration-line: none;
	color: white;
}

.data-container-wrapper h3 {

}

@keyframes rotate {
  from { --hue: 0; }
  to { --hue: 1; }
}

@keyframes eval {
  0% { --eval: 0; }
  50% { --eval: 1; }
  100% { --eval: 0; }
}
/* 데이터아이템 헤더폰트 */
h2 {
  position: relative;
  padding: 0;
  margin: 0;
  font-family: "Raleway", sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: #FF7A85;
  -webkit-transition: all 0.4s ease 0s;
  -o-transition: all 0.4s ease 0s;
  transition: all 0.4s ease 0s;
}

h2 span {
  display: block;
  font-size: 0.5em;
  line-height: 1.3;
}
h2 em {
  font-style: normal;
  font-weight: 600;
}
.eleven h2 {
  font-size:30px;text-align:center; line-height:1.5em; padding-bottom:45px; font-family:"Playfair Display", serif; text-transform:uppercase;letter-spacing: 2px; color:black;
padding-top:50px;}


.eleven h2:before {
  position: absolute;
  left: 0;
  bottom: 20px;
  width: 60%;
  left:50%; margin-left:-30%;
  height: 1px;
  content: "";
  background-color: #DFBFBD; z-index: 4;
}
/* .eleven h2:after { */
/*   position:absolute; */
/*   width:40px; height:40px; left:50%; margin-left:-20px; bottom:0px; */
/*   content: '\00a7'; font-size:30px; line-height:40px; color:#c50000; */
/*   font-weight:400; z-index: 5; */
/*   display:block; */
/*   background-color:#f8f8f8; */
 }  
</style>
</head>
<body>
<div class="container">
  <h3 id="preferences-title">선호하는 영양소를 선택하세요 </h3>
  <div class="buttons-container">
    <!-- 각 영양소별로 선호도를 설정하는 버튼들 -->
    <button class="btn6 protein-btn" onclick="togglePreference('protein', 10, this)">단백질이 많은 음식</button>
    <button class="btn6 transfat-btn" onclick="togglePreference('transFat', 100, this)">트랜스지방이 적은 음식</button>
    <button class="btn6 saturatedfat-btn" onclick="togglePreference('saturatedFat', 100, this)">포화지방이 적은 음식</button>
    <button class="btn6 sugar-btn" onclick="togglePreference('sugar', 50, this)">당 낮은 함량</button>
    <button class="btn6 sodium-btn" onclick="togglePreference('sodium', 50, this)">나트륨이 적은 음식</button>
    <button class="btn6 carbohydrate-btn" onclick="togglePreference('carbohydrate', 20, this)">탄수화물이 많은 음식</button>
  </div>
  <button class="btn6" onclick="fetchData()">데이터 불러오기</button>
  <div class="data-container-wrapper" id="data-container-wrapper">
    <div class="eleven">
  <h2>Custom Nutrition</h2>
</div>
    <div class="grid-container" style="margin-top:50px;">
      <!-- 데이터를 표시하는 영역 -->
      <div class="data-container" id="data-container">
        <!-- 데이터가 여기에 표시됨 -->
      </div>
      <div class="svg-container" id="svg-container">
        <!-- 영양소 육각형 그래프 -->
        <svg class="design-tool" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 420">
          <g id="hexagon">
            <path class="hexagon" opacity=".8" d="M106.14 309.33V190.21l103.15-59.56 103.17 59.56v119.12l-103.17 59.56-103.15-59.56z"/>
            <!-- 각 꼭지점 이름 추가 -->
            <text x="209.29" y="115" class="text">PROTEIN</text> 
            <text x="80" y="190.21" class="text">TRANS_FAT</text>
            <text x="80" y="309.33" class="text">SATURATED_FAT</text>
            <text x="209.29" y="385" class="text">SUGAR</text>
            <text x="338" y="309.33" class="text">SODIUM</text>
            <text x="338" y="190.21" class="text">CARBOHYDRATE</text>
          </g>
          <path id="data-line" fill="none" stroke-linejoin="round" stroke-width="2"/>
          <!-- 각 항목의 이름을 표시할 텍스트 요소 추가 -->
          <text id="product-name" x="50%" y="50" class="text" text-anchor="middle" dominant-baseline="middle"></text>
        </svg>
      </div>
    </div>
  </div>
</div>
<script>
let preferences = {
  protein: 0,
  transFat: 0,
  saturatedFat: 0,
  sugar: 0,
  sodium: 0,
  carbohydrate: 0
};


function togglePreference(nutrient, value, element) {
	  if (preferences[nutrient] === value) {
	    preferences[nutrient] = 0;
	    element.classList.remove('active');
	  } else {
	    preferences[nutrient] = value;
	    element.classList.add('active');
	  }
	}

/* 서버에서 데이터를 가져오는 함수 */
function fetchData() {
	const query = Object.entries(preferences)
    .filter(([key, val]) => val !== 0) // 0이 아닌 값만 필터링
    .map(([key, val]) => `\${key}=\${val}`)
    .join('&');

  fetch(`/nutrition?\${query}`)
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok ' + response.statusText);
      }
      return response.json();
    })
    .then(data => {
      if (!Array.isArray(data)) {
        console.error('Expected an array but got:', data);
        data = [];
      }
      displayData(data);
      document.getElementById('preferences-title').style.display = 'none'; // 데이터를 불러온 후에 제목을 숨김
      document.getElementById('data-container-wrapper').scrollIntoView({ behavior: 'smooth' }); // 스크롤 이동
    })
    .catch(error => console.error('Error fetching data:', error));
}

/* 가져온 데이터를 화면에 표시하는 함수 */
function displayData(data) {
  const containerWrapper = document.getElementById('data-container-wrapper');
  const container = document.getElementById('data-container');
  if (!container) {
    console.error('data-container element not found');
    return;
  }

  container.innerHTML = '';

  data.forEach(item => {
    const div = document.createElement('div');
    div.className = 'data-item';
    div.onclick = () => drawGraph(item); // 클릭 시 그래프 업데이트

    const img = document.createElement('img');
    img.src = item.filePath;
    img.alt = 'Product Image';

    const h3 = document.createElement('h3');
    h3.textContent = item.productNumber;

    const h4 = document.createElement('h3');
    h4.textContent = item.name;

    const p1 = document.createElement('p');
    p1.textContent = 'Calorie: ' + item.calorie;

    const p2 = document.createElement('p');
    p2.textContent = 'Protein: ' + item.protein;

    const p3 = document.createElement('p');
    p3.textContent = 'Fat: ' + item.fat;

    const p4 = document.createElement('p');
    p4.textContent = 'Trans Fat: ' + item.transFat;

    const p5 = document.createElement('p');
    p5.textContent = 'Saturated Fat: ' + item.saturatedFat;

    const p6 = document.createElement('p');
    p6.textContent = 'Sugar: ' + item.sugar;

    const p7 = document.createElement('p');
    p7.textContent = 'Sodium: ' + item.sodium;

    const p8 = document.createElement('p');
    p8.textContent = 'Carbohydrate: ' + item.carbohydrate;
    
    const div2 = document.createElement('div')
    div2.className = 'buy-div'
    
    const btn1 = document.createElement('a');
    btn1.href = '/productDetail?productNumber=' + item.productNumber; //바로 구매하기 기능 만들면 연결하면됨
    btn1.className = 'buy-btn'
    btn1.textContent = '구매하기'
    
    const btn2 = document.createElement('a');
    btn2.href = '/productDetail?productNumber=' + item.productNumber; //장바구니 넣기 기능 만들면 연결하면 됨
    btn2.className = 'cart-btn'
    btn2.textContent = '장바구니'

    div.appendChild(img);
    div.appendChild(h3);
    div.appendChild(h4);
    div.appendChild(p1);
    div.appendChild(p2);
    div.appendChild(p3);
    div.appendChild(p4);
    div.appendChild(p5);
    div.appendChild(p6);
    div.appendChild(p7);
    div.appendChild(p8);
    div.appendChild(div2);
    div2.appendChild(btn1);
    div2.appendChild(btn2);

    container.appendChild(div);
  });

  containerWrapper.style.display = 'block'; // 데이터를 불러온 후에 데이터 컨테이너를 표시
}

/* 그래프를 그리는 함수 */
function drawGraph(nutrition) {
  const maxVal = 40;  // 최대값을 40으로 설정
  const animationDuration = 800;  // 애니메이션 지속 시간 800밀리초

  // 영양소 값들을 올바른 순서로 추출
  const values = [
    nutrition.protein,
    nutrition.transFat,
    nutrition.saturatedFat,
    nutrition.sugar,
    nutrition.sodium,
    nutrition.carbohydrate
  ];

  const hexagonPoints = [
    { x: 209.29, y: 130.65 },  // 단백질
    { x: 106.14, y: 190.21 },  // 트랜스지방
    { x: 106.14, y: 309.33 },  // 포화지방
    { x: 209.29, y: 368.89 },  // 당
    { x: 312.46, y: 309.33 },  // 나트륨
    { x: 312.46, y: 190.21 }   // 탄수화물
  ];

  const centerX = 209.29;  // 중심 좌표
  const centerY = 249.77;  // 중심 좌표

  const targetPoints = hexagonPoints.map((point, index) => {
    const value = Math.min(values[index], maxVal);
    const scale = value / maxVal;
    return {
      x: centerX + (point.x - centerX) * scale,
      y: centerY + (point.y - centerY) * scale
    };
  });

  const dataLine = document.getElementById('data-line');
  const productName = document.getElementById('product-name'); // 이름을 표시할 요소
  const svgContainer = document.getElementById('svg-container'); // 그래프 컨테이너

  productName.textContent = nutrition.name; // 제품 이름 업데이트
  svgContainer.style.display = 'flex'; // 그래프 컨테이너를 표시

  let startTime;

  function animate(timestamp) {
    if (!startTime) startTime = timestamp;
    const progress = Math.min((timestamp - startTime) / animationDuration, 1);  // 진행률 계산 (최대값 1)

    const currentPoints = targetPoints.map(point => ({
      x: centerX + (point.x - centerX) * progress,
      y: centerY + (point.y - centerY) * progress
    }));

    let pathData = "";
    currentPoints.forEach((point, index) => {
      pathData += (index === 0 ? 'M' : 'L') + point.x + "," + point.y + " ";
    });
    pathData += 'Z';

    dataLine.setAttribute('d', pathData);

    if (progress < 1) {
      requestAnimationFrame(animate);
    } else {
      // Final adjustment to make sure points reach exact target positions
      let finalPathData = "";
      targetPoints.forEach((point, index) => {
        finalPathData += (index === 0 ? 'M' : 'L') + point.x + "," + point.y + " ";
      });
      finalPathData += 'Z';
      dataLine.setAttribute('d', finalPathData);
    }
  }

  requestAnimationFrame(animate);
}
</script>
</body>
</html>
