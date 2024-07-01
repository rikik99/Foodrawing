<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="nav-inner">
    <nav class="navbar navbar-expand-lg justify-content-center nav-inner-in" aria-label="Tenth navbar example">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample08"
                aria-controls="navbarsExample08" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse nav-menu justify-content-center" id="navbarsExample08">
                <div class="category">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown08" data-bs-toggle="dropdown"
                                aria-expanded="false">카테고리</a>
                            <ul class="dropdown-menu" aria-labelledby="dropdown08">
                                <li><a class="dropdown-item" href="#">Action</a></li>
                                <li><a class="dropdown-item" href="#">Another action</a></li>
                                <li><a class="dropdown-item" href="#">Something else here</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <ul class="navbar-nav menuitems justify-content-center">
                    <li class="nav-item"><a class="nav-link" href="/main/bestpage">베스트</a></li>
                    <li class="nav-item"><a class="nav-link" href="/custompage">영양소커스텀</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">할인</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">고객센터</a></li>
                </ul>
            </div>
            <div>
                <ul class="navbar-nav nav-util justify-content-right">
                    <c:choose>
                        <c:when test="${isLoggedIn}">
                            <li class="nav-item loginli"><a href="/logout" class="login">로그아웃</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item loginli"><a href="/login" class="login">로그인</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li class="nav-item csli"><a href="#" class="cs">고객센터</a></li>
                </ul>
            </div>
        </div>
    </nav>
</div>
