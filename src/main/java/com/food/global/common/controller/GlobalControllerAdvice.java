package com.food.global.common.controller;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.food.global.common.dto.RecentProductInfo;
import com.food.global.common.service.GlobalCartService;
import com.nimbusds.jose.shaded.gson.Gson;
import com.nimbusds.jose.shaded.gson.reflect.TypeToken;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalControllerAdvice {
	@Autowired
	private GlobalCartService cartService;
	 
	@ModelAttribute("cartItemCount")
    public int getCartItemCount(HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isLoggedIn = authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal());
        Cookie[] cookies = request.getCookies();
        
        //로그인있을때
        if (isLoggedIn) {
        	return cartService.getCartItemCount();
        } else if (cookies != null) { //게스트 일때
        	for (Cookie cookie : cookies) {
                if ("guestId".equals(cookie.getName())) {
                    String guestId = cookie.getValue();
                    return cartService.getGuestCartItemCount(guestId);
                }
            }        	
        } 
        return 0; // 장바구니 아이템 갯수 가져오기
    }
}
