package com.food.global.auth;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component
public class CustomOAuth2SuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final JwtUtil jwtUtil;

    public CustomOAuth2SuccessHandler(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        // 세션에서 pendingRegistration 속성을 확인합니다.
        Boolean pendingRegistration = (Boolean) request.getSession().getAttribute("pendingRegistration");

        if (pendingRegistration == null || !pendingRegistration) {
            String username = authentication.getName();
            String provider = (String) request.getSession().getAttribute("provider");
            Map<String, Object> additionalClaims = (Map<String, Object>) request.getSession().getAttribute("oauth2Attributes");
            String token = jwtUtil.generateToken(username, true, provider, additionalClaims); // rememberMe 기본값으로 설정

            Cookie cookie = new Cookie("jwt", token);
            cookie.setHttpOnly(true);
            cookie.setSecure(false); // HTTPS 사용 시 true로 설정
            cookie.setPath("/");
            cookie.setMaxAge(86400); // 1일
            response.addCookie(cookie);
        } else {
            // 회원가입 후 세션에서 속성을 제거합니다.
            request.getSession().removeAttribute("pendingRegistration");
        }

        // 세션에서 oauth2RedirectUrl을 가져오고 제거합니다.
        String redirectUrl = (String) request.getSession().getAttribute("oauth2RedirectUrl");
        if (redirectUrl != null) {
            request.getSession().removeAttribute("oauth2RedirectUrl"); // 세션에서 제거
            getRedirectStrategy().sendRedirect(request, response, redirectUrl);
        } else {
            super.onAuthenticationSuccess(request, response, authentication);
        }
    }
}
