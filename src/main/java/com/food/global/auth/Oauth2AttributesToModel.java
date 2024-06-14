package com.food.global.auth;

import java.util.Map;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.service.CustomUserDetailsService;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class Oauth2AttributesToModel {

	private final CustomUserDetailsService customUserDetailsService;

	public Oauth2AttributesToModel(CustomUserDetailsService customUserDetailsService) {
		this.customUserDetailsService = customUserDetailsService;
	}

	public void addNaverUserAttributesToModel(Map<String, Object> user, HttpServletRequest request, ModelAndView mv) {
		String email = (String) user.get("email");
		String username = email.split("@")[0]; // '@' 이전의 값을 username으로 설정

		mv.addObject("password", request.getSession().getAttribute("password"));
		mv.addObject("name", user.get("name"));
		mv.addObject("email", email);
		mv.addObject("username", username);
		mv.addObject("nickname", user.get("nickname"));
		mv.addObject("gender", user.get("gender"));
		mv.addObject("birthYear", request.getSession().getAttribute("birthYear"));
		mv.addObject("birthMonth", request.getSession().getAttribute("birthMonth"));
		mv.addObject("birthDay", request.getSession().getAttribute("birthDay"));
		mv.addObject("mobile", user.get("mobile"));
	}

	public void addKakaoUserAttributesToModel(Map<String, Object> user, HttpServletRequest request, ModelAndView mv) {
		String email = (String) user.get("email");
		String username = email.split("@")[0]; // '@' 이전의 값을 username으로 설정

		mv.addObject("password", request.getSession().getAttribute("password"));
		mv.addObject("email", email);
		mv.addObject("username", username);
		mv.addObject("nickname", request.getSession().getAttribute("nickname"));

		// 카카오는 아래 속성들을 제공하지 않으므로 기본 값으로 설정하거나 제외합니다.
		mv.addObject("name", request.getSession().getAttribute("nickname"));
		mv.addObject("gender", "");
		mv.addObject("birthYear", "");
		mv.addObject("birthMonth", "");
		mv.addObject("birthDay", "");
		mv.addObject("mobile", "");
	}

	public void authenticateUserAndSetSession(UserDTO userDTO, HttpServletRequest request) {
		UserDetails userDetails = customUserDetailsService.loadUserByUsername(userDTO.getUsername());
		UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(userDetails, null,
				userDetails.getAuthorities());
		auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
		SecurityContextHolder.getContext().setAuthentication(auth);
	}
}
