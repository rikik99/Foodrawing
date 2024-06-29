package com.food.domain.order.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.mapper.CartMapper;
import com.food.domain.order.mapper.PaymentMapper;
import com.food.domain.order.service.CartService;
import com.food.domain.user.dto.CustomerDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CartInfoController {
	@Autowired
	private CartMapper cartMapper;
	
	private final CartService cartService;
	
	@RequestMapping("/cart")
	public ModelAndView orderCart() {
		ModelAndView mv = new ModelAndView();
		
		//로그인 한 회원 정보
		CustomerDTO customer = new CustomerDTO();
		customer.setId(1L);
		
		//장바구니 정보
		List<CartInfoDTO> cartItems = cartMapper.getCartListByCustomerId(customer.getId());

		mv.addObject("cartItems", cartItems);
		
		mv.setViewName("order/cart");
		
		return mv; 
	}
}
