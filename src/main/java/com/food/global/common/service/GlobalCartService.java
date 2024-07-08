package com.food.global.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.food.domain.user.controller.AdminController;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.GuestDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.service.CustomerService;
import com.food.domain.user.service.UserService;
import com.food.global.common.mapper.GlobalCartMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GlobalCartService {
	@Autowired
	GlobalCartMapper cartMapper;
	
	@Autowired
	UserService userService;
	
	@Autowired
	CustomerService customerService;

	public int getCartItemCount() {
		// 로그인 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isLoggedIn = authentication != null && authentication.isAuthenticated()
				&& !"anonymousUser".equals(authentication.getPrincipal());

		String username = authentication.getName();
		System.out.println("username: " + username);
		CustomerDTO customerDTO = new CustomerDTO();
		GuestDTO guestDTO = new GuestDTO();
		
		int count = 0;
		
		if (isLoggedIn) {
			UserDTO user = userService.loadUser(username);
			log.info("product UserDTO = {}",user);
			Long userId = user.getId();
			customerDTO = customerService.findCustomerByUserId(userId);
			log.info("customDTO = {}", customerDTO);
			
			count = cartMapper.getCartItemCount(customerDTO.getId());
		} else {
			count = 0;
		}
		
		
		return count;
	}

	public int getGuestCartItemCount(String guestId) {
		return cartMapper.getGuestCartItemCount(guestId);
	}

}