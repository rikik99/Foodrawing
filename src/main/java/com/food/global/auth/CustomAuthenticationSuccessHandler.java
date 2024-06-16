package com.food.global.auth;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private final JwtUtil jwtUtil;

    public CustomAuthenticationSuccessHandler(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        String rememberMeParam = request.getParameter("remember-me");
        boolean rememberMe = rememberMeParam != null && rememberMeParam.equals("on");
        String token = jwtUtil.generateToken(authentication.getName(), rememberMe);

        if (rememberMe) {
            Cookie cookie = new Cookie("jwt", token);
            cookie.setHttpOnly(true);
            cookie.setSecure(false); // HTTP 환경에서는 false로 설정
            cookie.setPath("/");
            cookie.setMaxAge(604800); // 7 days
            response.addCookie(cookie);
            response.setHeader("Set-Cookie", String.format("jwt=%s; HttpOnly; Path=/; Max-Age=%d; SameSite=Lax",
                    token, cookie.getMaxAge()));
        } else {
            Cookie sessionCookie = new Cookie("jwt", null);
            sessionCookie.setHttpOnly(true);
            sessionCookie.setSecure(false);
            sessionCookie.setPath("/");
            sessionCookie.setMaxAge(0); // 쿠키 삭제
            response.addCookie(sessionCookie);
            request.getSession().setAttribute("jwt", token); // 1시간 세션 유지
        }

        Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) authentication.getAuthorities();
        boolean isAdmin = authorities.stream().anyMatch(role -> role.getAuthority().equals("ROLE_ADMIN"));

        if (isAdmin) {
            response.sendRedirect("/admin/main");
        } else {
            response.sendRedirect("/");
        }
    }
}
