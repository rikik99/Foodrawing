package com.food.domain.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.order.dto.CartDTO;
import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.mapper.CartMapper;
import com.food.domain.user.dto.CustomerDTO;

@Controller
public class OrderController {
	@Autowired
	private CartMapper cartMapper;
	
	@RequestMapping("/cart")
	public ModelAndView orderCart() {
		ModelAndView mv = new ModelAndView();
		
		//로그인 한 회원 정보
		CustomerDTO customer = new CustomerDTO();
		customer.setId(1L);
		
		//장바구니 정보
		List<CartInfoDTO> cartItems = cartMapper.getCartListByCustomerId(customer.getId());

		
		mv.addObject("cartItems", cartItems);
		
		mv.setViewName("order/order");
		
		return mv; 
	}
}
