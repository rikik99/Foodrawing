<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/bestpage.css">
<link rel="stylesheet" href="css/sidebar.css">
<style>

</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>	
	<div class="header-wrap">
		<%@include file="/WEB-INF/include/header.jsp"%>

		<%@include file="/WEB-INF/include/nav.jsp"%>
  </div>
  
  
  <div>
  	<div class="container">
  		<h2 class="page-title">카테고리별 판매 베스트</h2>
  		<div id="tab1" data-tab-content class="active">
  			<ul class="category-list column5 mt10 newcate2024" data-tab="">
	        <li class="active"><a href="#category00" onclick="loadBestProd('')">전체</a></li>
          <li><a href="#category0036" onclick="loadBestProd('0036')">햇반/볶음밥/컵반/죽</a></li>
          <li><a href="#category0037" onclick="loadBestProd('0037')">국/탕/찌개</a></li>
          <li><a href="#category0038" onclick="loadBestProd('0038')">만두</a></li>
          <li><a href="#category0039" onclick="loadBestProd('0039')">분식</a></li>
          <li><a href="#category0040" onclick="loadBestProd('0040')">떡갈비/생선구이/어묵/반찬</a></li>
          <li><a href="#category0041" onclick="loadBestProd('0041')">치킨/피자/핫도그/탕수육/함박</a></li>
          <li><a href="#category0042" onclick="loadBestProd('0042')">햄/스팸/닭가슴살</a></li>
          <li><a href="#category0043" onclick="loadBestProd('0043')">면요리/사리</a></li>
          <li><a href="#category0057" onclick="loadBestProd('0057')">김치</a></li>
          <li><a href="#category0044" onclick="loadBestProd('0044')">양념/장류/오일/다시다</a></li>	                
          <li><a href="#category0045" onclick="loadBestProd('0045')">스낵/젤리/시럽</a></li>
          <li><a href="#category0046" onclick="loadBestProd('0046')">식단관리/식사대용</a></li>
          <li><a href="#category0006" onclick="loadBestProd('0006')">건강식품</a></li>
          <li><a href="#category0010" onclick="loadBestProd('0010')">밀키트</a></li>
          <li><a href="#category0047" onclick="loadBestProd('0047')">음료/생수/유제품</a></li>
          <li><a href="#category0048" onclick="loadBestProd('0048')">정육/수산/계란</a></li>
          <li><a href="#category0049" onclick="loadBestProd('0049')">과일/채소</a></li>
          <li></li>           
          <li></li>
	    </ul>
  		</div>
  	</div>
  
  	<div class="product-list-body">
  	<div class="product-grid">
  	<c:forEach var="index" begin="1" end="10">
  		<div class="product-card">
	  		<div class="product-top">
		  		<a class="product-card-href" href="/ProductDetail">
		         <div class="badge">BEST</div>
		         <img src="images/20240517_CaTchWorkFavicon.png" alt="Product Image">
		      </a>
		      <a class="product-card-cart-href" href="#">
			      <div class="cart-icon">
			          <img src="/images/basket-icon.png" alt="Cart Icon">
			      </div>
		      </a>
	  		</div>
  			<a class="product-card-href" href="/ProductDetail">
            <div class="product-details">
               <div class="product-title">
                   불향까지 살아있는 직화🔥<br>
                   육공육 리얼직화 삼겹 225g
               </div>
               <div class="product-price">
                   5,187원
                   <span class="product-old-price">7,980원</span>
               </div>
               <div class="product-discount">35% 할인</div>
               <div class="product-rating">★ 4.7 (64)</div>
               <div class="delivery-info">
                   내일 <span>꼭! 도착</span><br>
                   내일 06/08 (토) 도착예정
               </div>
               <div class="refrigeration-info">
                   <img src="path/to/refrigeration-icon.png" alt="Refrigeration Icon">
                   냉장
               </div>
            </div>
  			</a>
      </div>
    </c:forEach>
  	</div>
  	</div>
  	<%@include file="/WEB-INF/include/sidebar.jsp"%>
  </div>
  
  
  <%@include file="/WEB-INF/include/footer.jsp"%>
  

</body>
</html>