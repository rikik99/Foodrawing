package com.food.global.configuration;

import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.food.domain.user.service.CustomOAuth2UserService;
import com.food.domain.user.service.CustomUserDetailsService;
import com.food.global.auth.CustomAuthenticationFailureHandler;
import com.food.global.auth.CustomAuthenticationSuccessHandler;
import com.food.global.auth.CustomOAuth2FailureHandler;
import com.food.global.auth.CustomOAuth2SuccessHandler;
import com.food.global.auth.JwtAuthenticationFilter;
import com.food.global.auth.JwtUtil;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.SessionCookieConfig;
import jakarta.servlet.http.Cookie;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	private final CustomUserDetailsService customUserDetailsService;
	private final CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;
	private final CustomAuthenticationFailureHandler customAuthenticationFailureHandler;
	private final CustomOAuth2UserService customOAuth2UserService;
	private final CustomOAuth2SuccessHandler customOAuth2SuccessHandler;
	private final CustomOAuth2FailureHandler customOAuth2FailureHandler;
	private final JwtUtil jwtUtil;

	public SecurityConfig(@Lazy CustomUserDetailsService customUserDetailsService,
			CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler,
			CustomAuthenticationFailureHandler customAuthenticationFailureHandler,
			@Lazy CustomOAuth2UserService customOAuth2UserService,
			CustomOAuth2SuccessHandler customOAuth2SuccessHandler,
			CustomOAuth2FailureHandler customOAuth2FailureHandler, JwtUtil jwtUtil) {
		this.customUserDetailsService = customUserDetailsService;
		this.customAuthenticationSuccessHandler = customAuthenticationSuccessHandler;
		this.customAuthenticationFailureHandler = customAuthenticationFailureHandler;
		this.customOAuth2UserService = customOAuth2UserService;
		this.customOAuth2SuccessHandler = customOAuth2SuccessHandler;
		this.customOAuth2FailureHandler = customOAuth2FailureHandler;
		this.jwtUtil = jwtUtil;
	}

	@Bean
	public JwtAuthenticationFilter jwtAuthenticationFilter() {
		return new JwtAuthenticationFilter(jwtUtil, customUserDetailsService);
	}

	@Bean
	public SecurityFilterChain adminSecurityFilterChain(HttpSecurity http) throws Exception {
		http.securityMatcher("/admin/**").csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(
						authorizeRequests -> authorizeRequests.requestMatchers("/admin/login", "/admin/logout")
								.permitAll().anyRequest().hasAuthority("ROLE_ADMIN"))
				.formLogin(formLogin -> formLogin.loginPage("/admin/login")
						.defaultSuccessUrl("/admin/main", true).successHandler(customAuthenticationSuccessHandler)
						.failureHandler(customAuthenticationFailureHandler).permitAll())
				.logout(logout -> logout.logoutUrl("/admin/logout").logoutSuccessUrl("/admin/login").permitAll())
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
				.userDetailsService(customUserDetailsService);

		return http.build();
	}

	@Bean
	public SecurityFilterChain userSecurityFilterChain(HttpSecurity http) throws Exception {
		http.csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(authorizeRequests -> authorizeRequests.requestMatchers("/", "/login",
						"/loginFail", "/signup", "/WEB-INF/views/**", "/css/**", "/js/**", "/images/**",
						"/sendVerificationEmail", "/verify", "/signupInfo", "/main/custompage", "/main/mainpage",
						"/nutrition", "/verificationSuccess", "/verificationFail", "/checkDuplicateUsername",
						"/invalidateSession", "/linkAccount", "/findUsername", "/verify-id-code", "/showUsername",
						"/findPassword", "/sendPasswordResetCode", "/verify-password-code", "/passwordReset", "/best",
						"/ProductDetail", "/cart/checkStock", "/cart/addToCart", "/cart", "/cart/deleteCartItem",
						"/order/prepareCheckout", "/checkoutPage", "/order/prepareCheckoutAll", "/cart/updateCartItem")
						.permitAll().anyRequest().authenticated())
				.formLogin(formLogin -> formLogin.loginPage("/login").defaultSuccessUrl("/", true)
						.successHandler(customAuthenticationSuccessHandler)
						.failureHandler(customAuthenticationFailureHandler).permitAll())
				.oauth2Login(oauth2Login -> oauth2Login.loginPage("/login")
						.userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService))
						.successHandler(customOAuth2SuccessHandler).failureHandler(customOAuth2FailureHandler))
				.logout(logout -> logout.logoutUrl("/logout")
						.logoutSuccessHandler((request, response, authentication) -> {
							Cookie cookie = new Cookie("jwt", null);
							cookie.setHttpOnly(true);
							cookie.setSecure(false); // HTTP 환경에서는 false로 설정
							cookie.setPath("/");
							cookie.setMaxAge(0); // 쿠키 삭제
							response.addCookie(cookie);
							request.getSession().invalidate(); // 세션 무효화
							response.sendRedirect("/login");
						}).permitAll())
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)) // 세션을
																												// 필요할
																												// 때만
																												// 생성하도록
																												// 설정
				.userDetailsService(customUserDetailsService);

		http.addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

		return http.build();
	}

	@Bean
	public UserDetailsService userDetailsService() {
		return customUserDetailsService;
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public ServletContextInitializer initializer() {
		return new ServletContextInitializer() {
			@Override
			public void onStartup(ServletContext servletContext) throws ServletException {
				SessionCookieConfig sessionCookieConfig = servletContext.getSessionCookieConfig();
				sessionCookieConfig.setMaxAge(-1); // 브라우저 닫을 때 세션 쿠키 삭제
				sessionCookieConfig.setHttpOnly(true);
				sessionCookieConfig.setSecure(false);
				System.out.println("Session Cookie Config MaxAge set to: " + sessionCookieConfig.getMaxAge());
			}
		};
	}
}
