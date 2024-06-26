package com.food.global.auth;

import java.io.IOException;

import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.filter.OncePerRequestFilter;

import com.food.domain.user.service.CustomUserDetailsService;

import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;

    public JwtAuthenticationFilter(JwtUtil jwtUtil, @Lazy UserDetailsService userDetailsService) {
        this.jwtUtil = jwtUtil;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {

        String token = null;
        String refreshToken = null;

        // 우선 쿠키에서 토큰을 찾습니다.
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("jwt")) {
                    token = cookie.getValue();
                } else if (cookie.getName().equals("refreshToken")) {
                    refreshToken = cookie.getValue();
                }
            }
        }

        // 쿠키에서 토큰을 찾지 못하면 세션에서 가져옵니다.
        if (token == null) {
            token = (String) request.getSession().getAttribute("jwt");
        }

        boolean newTokenIssued = false;

        try {
            if (token != null && jwtUtil.validateToken(token)) {
                String email = jwtUtil.extractUsername(token);
                String provider = (String) request.getSession().getAttribute("provider");

                UserDetails userDetails;
                if (provider == null) {
                    userDetails = ((CustomUserDetailsService) userDetailsService).loadUserByUsername(email);
                } else {
                    userDetails = ((CustomUserDetailsService) userDetailsService).loadUserByEmail(email);
                }

                if (jwtUtil.validateToken(token, userDetails)) {
                    UsernamePasswordAuthenticationToken authentication = 
                            new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            }
        } catch (ExpiredJwtException e) {
            // JWT가 만료된 경우 리프레시 토큰을 검증하고, 유효한 경우 새로운 JWT 발급
            if (refreshToken != null && jwtUtil.validateRefreshToken(refreshToken)) {
                String email = jwtUtil.extractUsername(refreshToken);
                String provider = (String) request.getSession().getAttribute("provider");

                UserDetails userDetails;
                if (provider == null) {
                    userDetails = ((CustomUserDetailsService) userDetailsService).loadUserByUsername(email);
                } else {
                    userDetails = ((CustomUserDetailsService) userDetailsService).loadUserByEmail(email);
                }

                if (jwtUtil.validateToken(refreshToken, userDetails)) {
                    String newToken = jwtUtil.generateToken(email, false, provider, null);

                    // 새로운 JWT를 쿠키에 추가
                    Cookie newJwtCookie = new Cookie("jwt", newToken);
                    newJwtCookie.setHttpOnly(true);
                    newJwtCookie.setPath("/");
                    newJwtCookie.setMaxAge(7 * 24 * 60 * 60); // 쿠키 유효 기간을 7일로 설정
                    response.addCookie(newJwtCookie);

                    // 새로운 JWT를 세션에 추가
                    request.getSession().setAttribute("jwt", newToken);

                    // 새로운 JWT로 인증
                    UsernamePasswordAuthenticationToken authentication = 
                            new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(authentication);

                    // 리다이렉트 루프 방지를 위해 플래그 설정
                    newTokenIssued = true;
                }
            }
        }

        // 새로운 토큰이 발행된 경우 다시 원래 요청을 처리
        if (newTokenIssued) {
            response.sendRedirect(request.getRequestURI());
            return;
        }

        chain.doFilter(request, response);
    }
}
