package com.food.global.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.food.global.common.service.GlobalCartService;

@ControllerAdvice
public class GlobalControllerAdvice {
	@Autowired
	private GlobalCartService cartService;
	 
	@ModelAttribute("cartItemCount")
    public int getCartItemCount() {
        return cartService.getCartItemCount(); // 장바구니 아이템 갯수 가져오기
    }
}
