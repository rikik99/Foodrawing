package com.food.global.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.food.global.common.service.GlobalCartService;

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
        
        // 관리자 권한 확인
        boolean isAdmin = false;
        if (isLoggedIn) {
            for (GrantedAuthority authority : authentication.getAuthorities()) {
                if (authority.getAuthority().equals("ROLE_ADMIN")) {
                    isAdmin = true;
                    break;
                }
            }
        }

        // 관리자일 경우 장바구니 아이템 수 반환을 건너뜀
        if (isAdmin) {
            return 0;
        }

        Cookie[] cookies = request.getCookies();

        try {
            if (isLoggedIn) {
                return cartService.getCartItemCount();
            } else if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("guestId".equals(cookie.getName())) {
                        String guestId = cookie.getValue();
                        return cartService.getGuestCartItemCount(guestId);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0; // 장바구니 아이템 갯수 가져오기 실패 시 0 반환
    }
}