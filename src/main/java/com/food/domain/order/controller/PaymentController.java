package com.food.domain.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.order.dto.OrderDTO;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	@RequestMapping("/success")
	public ModelAndView paymentSucess(OrderDTO order) {
		ModelAndView mv = new ModelAndView();
		
		System.out.println("order: " + order);
		
		mv.addObject("orderNumber", order.getOrderNumber());
		
		mv.setViewName("order/checkoutSuccess");
		return mv;
	}
	
	@RequestMapping("/fail")
	public ModelAndView paymentFail() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("order/checkoutFail");
		return mv;
	}
}
