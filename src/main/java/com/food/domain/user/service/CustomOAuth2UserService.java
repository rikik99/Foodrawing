package com.food.domain.user.service;

import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.UserSocialLinksDTO;
import com.food.domain.user.mapper.CustomerMapper;
import com.food.global.auth.JwtUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final HttpServletRequest request;
    private final CustomerMapper customerMapper;
    private final UserService userService;
    private final CustomUserDetailsService customUserDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    
    public CustomOAuth2UserService(HttpServletRequest request, CustomerMapper customerMapper,
                                   UserService userService, CustomUserDetailsService customUserDetailsService, 
                                   PasswordEncoder passwordEncoder, JwtUtil jwtUtil) {
        this.request = request;
        this.customerMapper = customerMapper;
        this.userService = userService;
        this.customUserDetailsService = customUserDetailsService;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
    }

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {
        OAuth2User oAuth2User = super.loadUser(userRequest);
        Map<String, Object> attributes = oAuth2User.getAttributes();
        System.out.println("attributes = " + attributes);
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        HttpSession session = request.getSession();
        String email = getEmailFromAttributes(attributes, registrationId);
        String providerId = getProviderIdFromAttributes(attributes, registrationId);

        // 소셜 링크가 존재하는지 확인
        UserSocialLinksDTO socialLink = userService.findSocialLinkByProviderAndProviderId(registrationId, providerId);
        if (socialLink != null) {
            // 기존 사용자 로직
        	System.out.println("social check");
            CustomerDTO customer = customerMapper.findCustomerById(socialLink.getUserId());
            System.out.println("customer = " + customer);
            session.setAttribute("provider", registrationId);
            session.setAttribute("providerId", providerId);
            session.setAttribute("email", email);
            session.setAttribute("oauth2Attributes", attributes);
            session.setAttribute("user", customer);
            session.setAttribute("oauth2RedirectUrl", "/");
        } else {
            CustomerDTO existingCustomer = customerMapper.findCustomerByEmail(email);
            if (existingCustomer != null) {
                session.setAttribute("provider", registrationId);
                session.setAttribute("providerId", providerId);
                session.setAttribute("email", email);
                session.setAttribute("oauth2Attributes", attributes);
                session.setAttribute("oauth2RedirectUrl", "/linkAccount");
            } else {
                // 신규 사용자 처리 로직
                handleNewUser(attributes, registrationId, session, providerId);
                userService.markEmailAsVerified(email);
                // 회원가입 페이지로 리다이렉션 설정
                session.setAttribute("pendingRegistration", true);
                session.setAttribute("oauth2RedirectUrl", "/signup");
            }
        }

        // JWT 토큰 생성 및 세션에 저장
        Map<String, Object> additionalClaims = new HashMap<>();
        additionalClaims.put("attributes", attributes); // 필요한 경우 추가 클레임으로 attributes를 저장할 수도 있습니다.
        String token = jwtUtil.generateToken(email, false, registrationId, additionalClaims);
        session.setAttribute("jwt", token);

        return oAuth2User;
    }

    private String getEmailFromAttributes(Map<String, Object> attributes, String registrationId) {
        if ("naver".equals(registrationId)) {
            Map<String, Object> responseMap = (Map<String, Object>) attributes.get("response");
            return (String) responseMap.get("email");
        } else if ("kakao".equals(registrationId)) {
            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
            return (String) kakaoAccount.get("email");
        }
        return null;
    }

    private String getProviderIdFromAttributes(Map<String, Object> attributes, String registrationId) {
        if ("naver".equals(registrationId)) {
            Map<String, Object> responseMap = (Map<String, Object>) attributes.get("response");
            return (String) responseMap.get("id");
        } else if ("kakao".equals(registrationId)) {
            return attributes.get("id").toString();
        }
        return null;
    }

    private void handleNewUser(Map<String, Object> attributes, String registrationId, HttpSession session, String providerId) {
        String email = getEmailFromAttributes(attributes, registrationId);
        String nickname = "";
        String birthYear = "";
        String birthMonth = "";
        String birthDay = "";
        String gender = "";
        String phoneNumber = "";
        String name = "";

        if ("naver".equals(registrationId)) {
            Map<String, Object> responseMap = (Map<String, Object>) attributes.get("response");
            nickname = (String) responseMap.get("nickname");
            birthYear = (String) responseMap.get("birthyear");
            String birth = (String) responseMap.get("birthday");
            if (birth != null && birth.contains("-")) {
                String[] birthParts = birth.split("-");
                birthMonth = birthParts[0];
                birthDay = birthParts[1];
            }
            gender = (String) responseMap.get("gender");
            phoneNumber = (String) responseMap.get("mobile");
            name = (String) responseMap.get("name");
        } else if ("kakao".equals(registrationId)) {
            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
            Map<String, Object> kakaoProfile = (Map<String, Object>) kakaoAccount.get("profile");
            nickname = (String) kakaoProfile.get("nickname");
            name = (String) kakaoProfile.get("nickname");
        }

        String randomPassword = generateRandomPassword();
        String password = passwordEncoder.encode(randomPassword);

        session.setAttribute("provider", registrationId);
        session.setAttribute("providerId", providerId);
        session.setAttribute("password", password);
        session.setAttribute("name", name);
        session.setAttribute("nickname", nickname);
        session.setAttribute("email", email);
        session.setAttribute("birthYear", birthYear);
        session.setAttribute("birthMonth", birthMonth);
        session.setAttribute("birthDay", birthDay);
        session.setAttribute("gender", gender);
        session.setAttribute("phoneNumber", phoneNumber);
        session.setAttribute("pendingRegistration", true);
        session.setAttribute("oauth2RedirectUrl", "/signup");
    }

    private String generateRandomPassword() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[24];
        random.nextBytes(bytes);
        return Base64.getEncoder().encodeToString(bytes);
    }
}
