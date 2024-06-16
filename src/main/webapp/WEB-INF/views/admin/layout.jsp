<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="sidebar">
    <ul>
        <li><a href="#" data-target="mainContent">
            Home
        </a></li>
        
        <li class="dropdown-container">
            <ul>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">
                        <img src="/images/admin/product-svgrepo-com.svg" alt="Dropdown Icon" class="dropdown-icon">
                        상품 관리
                        <i class="fa fa-chevron-right arrow-icon"></i>
                    </a>
                </li>
            </ul>
            <ul class="dropdown-menu">
                <li><a href="#" data-target="addProduct">상품 목록</a></li>
                <li><a href="#" data-target="deleteProduct">상품 수정</a></li>
                <li><a href="#" data-target="updateInventory">재고 관리</a></li>
            </ul>
        </li>
        
        <li class="dropdown-container">
            <ul>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">
                        <img src="/images/admin/post-sign-message-svgrepo-com.svg" alt="Dropdown Icon" class="dropdown-icon">
                        판매글 관리
                        <i class="fa fa-chevron-right arrow-icon"></i>
                    </a>
                </li>
            </ul>
            <ul class="dropdown-menu">
                <li><a href="#" data-target="addBanner">판매글 목록</a></li>
                <li><a href="#" data-target="removeBanner">판매글 관리</a></li>
            </ul>
        </li>
        
        <li class="dropdown-container">
            <ul>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">
                        <img src="/images/admin/discount-svgrepo-com.svg" alt="Dropdown Icon" class="dropdown-icon">
                        할인 관리
                        <i class="fa fa-chevron-right arrow-icon"></i>
                    </a>
                </li>
            </ul>
            <ul class="dropdown-menu">
                <li><a href="#" data-target="addDiscount">할인 추가</a></li>
                <li><a href="#" data-target="removeDiscount">할인 삭제</a></li>
            </ul>
        </li>
        
        <li class="dropdown-container">
            <ul>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">
                        <img src="/images/admin/user-management-svgrepo-com.svg" alt="Dropdown Icon" class="dropdown-icon">
                        회원 관리
                        <i class="fa fa-chevron-right arrow-icon"></i>
                    </a>
                </li>
            </ul>
            <ul class="dropdown-menu">
                <li><a href="#" data-target="viewUsers">회원 목록</a></li>
                <li><a href="#" data-target="editUsers">회원 수정</a></li>
            </ul>
        </li>
        
        <li class="dropdown-container">
            <ul>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle">
                        <img src="/images/admin/call-center-svgrepo-com.svg" alt="Dropdown Icon" class="dropdown-icon">
                        고객센터
                        <i class="fa fa-chevron-right arrow-icon"></i>
                    </a>
                </li>
            </ul>
            <ul class="dropdown-menu">
                <li><a href="#" data-target="viewInquiries">문의 보기</a></li>
                <li><a href="#" data-target="replyInquiries">문의 답변</a></li>
            </ul>
        </li>

        <!-- 로그아웃 버튼 추가 -->
        <li>
            <a href="<c:url value='/logout' />" class="logout-btn">
                <img src="/images/admin/logout-svgrepo-com.svg" alt="Logout Icon" class="dropdown-icon">
                로그아웃
            </a>
        </li>
    </ul>
</nav>
