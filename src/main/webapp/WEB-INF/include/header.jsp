<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="header-inner">
			<div class="container">
		    <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3">
		      <div class="col-md-3 mb-2 mb-md-0">
		        <a href="/" class="d-inline-flex link-body-emphasis text-decoration-none">
		          <img id="headerLogo" src="/images/FooDrawing_Logo_update.png" alt="이미지 오류">
		          <span class="logoText">FooDrawing</span>
		        </a>
		      </div>
		
		      <div class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 searchForm">
		        <form class="col-12 col-lg-auto mb-3 me-lg-3 d-flex mb-1">
		          <input type="search" class="form-control me-3" placeholder="검색어를 입력하세요." aria-label="Search" style="width: 400px;">
		          <input id="search-btn" type="submit" class="btn" value="검색">
		        </form>
		      </div>
		
		      <div class="col-md-3 text-end">
		<!--       	<a href="#"><img class="btn-search" src="/images/svg/search.svg"></a> -->
						<a href="#" class="btn-alarm">
		      		<img class="btn-alarm-icon" src="/images/alarm.png">
		      		<span class="count" id="headerAlarmCount">0</span>
		      	</a>
		      	<a href="/cart" class="btn-cart ms-2">
		      		<img class="btn-cart-icon" src="/images/basket-icon.png">
		      		<span class="count" id="headerCartCount">${cartItemCount}</span>
		      	</a>
		      	<a href="/myPage" class="ms-2"><img class="btn-search" src="/images/user-profile.png"></a>
		      </div>
		    </header>
	  	</div>
	  </div>