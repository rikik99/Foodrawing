<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Foodrawing</title>
<style>
/* 배경 스타일 */
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
  overflow: hidden;
  background-color: black;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  animation: rotate 8s linear infinite both, eval 19s linear infinite both,;
  background-image: 
    radial-gradient(farthest-corner at 0% calc(var(--eval) * 100%), hsla(calc(var(--hue) * 360deg), 70%, 60%, 1), hsla(calc(var(--hue) * 360deg), 70%, 60%, 0) 80%),
    radial-gradient(farthest-corner at calc(var(--eval) * 100%) 100%, hsla(calc((var(--hue) + 0.15) * 360deg), 60%, 60%, 1), hsla(calc((var(--hue) + 0.2) * 360deg), 60%, 60%, 0) 110%),
    radial-gradient(farthest-corner at calc(100% - var(--eval) * 100%) 0%, hsla(calc((var(--hue) + 0.3) * 360deg), 60%, 60%, 1), hsla(calc((var(--hue) + 0.3) * 360deg), 60%, 60%, 0) 100%),
    radial-gradient(farthest-corner at 100% calc(100% - var(--eval) * 100%), hsla(calc((var(--hue) + 0.45) * 360deg), 70%, 60%, 1), hsla(calc((var(--hue) + 0.5) * 360deg), 70%, 60%, 0) 90%);
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

/* 폰트 스타일 */
@import url('https://fonts.googleapis.com/css?family=Paytone+One');
/* 폰트 */
.content {
  word-spacing: 2px;
  overflow: hidden;
}
@keyframes reveal {
  0% {
    transform: translateY(100%);
  }
  100% {
    transform: translateY(0);
  }
}
.letter {
  display: inline-block;
  animation: reveal 1s cubic-bezier(0.77, 0, 0.175, 1) forwards;
  color: 5dad52;
    font-family: Paytone One;
    letter-spacing: -.005em;
    opacity:0.7;
    font-weight: 800;
    font-size: 30px;
}

/* ------------------- */

/* 버튼 스타일 */
@import url(https://fonts.googleapis.com/css?family=Raleway:400,500,700);
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);
.snip1477 {
  display: inline-block;
  margin-right: 20px; /* figure 사이의 간격 조절 */
}

figure.snip1477 {
  font-family: 'Raleway', Arial, sans-serif;
  position: relative;
  overflow: hidden;
  margin: 10px;
  min-width: 230px;
  max-width: 315px;
  width: 100%;
  color: #ffffff;
  text-align: center;
  font-size: 16px;
  background-color: #000000;
   border-radius: 30px;
}
figure.snip1477 *,
figure.snip1477 *:before,
figure.snip1477 *:after {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all 0.55s ease;
  transition: all 0.55s ease;
}
figure.snip1477 img {
  max-width: 100%;
  backface-visibility: hidden;
  vertical-align: top;
  opacity: 0.9;
}
figure.snip1477 .title {
  position: absolute;
  top: 58%;
  left: 25px;
  padding: 5px 10px 10px;
}
figure.snip1477 .title:before,
figure.snip1477 .title:after {
  height: 2px;
  width: 400px;
  position: absolute;
  content: '';
  background-color: #ffffff;
}
figure.snip1477 .title:before {
  top: 0;
  left: 10px;
  -webkit-transform: translateX(100%);
  transform: translateX(100%);
}
figure.snip1477 .title:after {
  bottom: 0;
  right: 10px;
  -webkit-transform: translateX(-100%);
  transform: translateX(-100%);
}
figure.snip1477 .title div:before,
figure.snip1477 .title div:after {
  width: 2px;
  height: 300px;
  position: absolute;
  content: '';
  background-color: #ffffff;
}
figure.snip1477 .title div:before {
  top: 10px;
  right: 0;
  -webkit-transform: translateY(100%);
  transform: translateY(100%);
}
figure.snip1477 .title div:after {
  bottom: 10px;
  left: 0;
  -webkit-transform: translateY(-100%);
  transform: translateY(-100%);
}
figure.snip1477 h2,
figure.snip1477 h4 {
  margin: 0;
  text-transform: uppercase;
}
figure.snip1477 h2 {
  font-weight: 400;
}
figure.snip1477 h4 {
  display: block;
  font-weight: 700;
  background-color: #ffffff;
  padding: 5px 10px;
  color: #000000;
}
figure.snip1477 figcaption {
  position: absolute;
  bottom: 42%;
  left: 25px;
  text-align: left;
  opacity: 0;
  padding: 5px 60px 5px 10px;
  font-size: 0.8em;
  font-weight: 500;
  letter-spacing: 1.5px;
}
figure.snip1477 figcaption p {
  margin: 0;
}
figure.snip1477 a {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
}
figure.snip1477:hover img,
figure.snip1477.hover img {
  zoom: 1;
  filter: alpha(opacity=35);
  -webkit-opacity: 0.35;
  opacity: 0.35;
}
figure.snip1477:hover .title:before,
figure.snip1477.hover .title:before,
figure.snip1477:hover .title:after,
figure.snip1477.hover .title:after,
figure.snip1477:hover .title div:before,
figure.snip1477.hover .title div:before,
figure.snip1477:hover .title div:after,
figure.snip1477.hover .title div:after {
  -webkit-transform: translate(0, 0);
  transform: translate(0, 0);
}
figure.snip1477:hover .title:before,
figure.snip1477.hover .title:before,
figure.snip1477:hover .title:after,
figure.snip1477.hover .title:after {
  -webkit-transition-delay: 0.15s;
  transition-delay: 0.15s;
}
figure.snip1477:hover figcaption,
figure.snip1477.hover figcaption {
  opacity: 1;
  -webkit-transition-delay: 0.2s;
  transition-delay: 0.2s;
}

</style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $(".food-button").click(function() {
                const category = $(this).data("category");
                console.log(category);
                window.location.href = "/mainpage?category=" + category;
            });
        });
    </script>
</head>
<body>
    <h2 class="title content" style="position:absolute; bottom:650px; left:100px;">
        <span class="letter">Custom Nutrient<br><small style="font-size:17px;">원하는 영양소를 직접 골라보세요</small></span>
    </h2>

    <figure class="snip1477 food-button" data-category="21">
        <img src="/images/balance.jpg" alt="sample38" />
        <div class="title">
            <div>
                <h2>균형잡힌 식단</h2>
                <h4 style="border-radius:15px;">Balanced</h4>
            </div>
        </div>
        <figcaption>
            <p>다양한 영양소가 조화롭게 구성된 균형잡힌 식단은 건강한 삶을 위한 필수적인 요소입니다.</p>
        </figcaption>
        <a href="javascript:void(0);"></a>
    </figure>

     <figure class="snip1477 food-button" data-category="22" style="margin-top:200px;">
        <img src="/images/protien.jpg" alt="img" />
        <div class="title">
            <div>
                <h2>단백질 위주 식단</h2>
                <h4 style="border-radius:15px;">Protein-based</h4>
            </div>
        </div>
        <figcaption>
            <p>단백질은 우리 몸을 구성하는 핵심 성분으로, 근육 합성, 면역 기능 강화, 체중 관리 등에 필수적입니다.</p>
        </figcaption>
        <a href="javascript:void(0);"></a>
    </figure>

    <figure class="snip1477 food-button" data-category="23">
        <img src="/images/diet.jpeg" alt="sample38" />
        <div class="title">
            <div>
                <h2>다이어트 식단</h2>
                <h4 style="border-radius:15px;">Diet menu</h4>
            </div>
        </div>
        <figcaption>
            <p>건강한 체중 관리를 위한 다이어트 식단은 영양 균형을 유지하면서도 에너지 섭취를 줄이는 것이 핵심입니다.</p>
        </figcaption>
        <a href="javascript:void(0);"></a>
    </figure>

    <figure class="snip1477 food-button" data-category="24" style="margin-top:200px;">
        <img src="/images/Na.jpg" alt="sample38" />
        <div class="title">
            <div>
                <h2>저염 식단</h4>
                <h4 style="border-radius:15px;">Low salt</h4>
            </div>
        </div>
        <figcaption>
            <p>과도한 나트륨 섭취는 고혈압, 심혈관 질환 등 다양한 건강 문제를 야기할 수 있습니다.</p>
        </figcaption>
        <a href="javascript:void(0);"></a>
    </figure>
</body>
</html>
