package com.food.domain.sales.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.food.domain.product.service.ProductMainService;

@Controller
public class SalesController {

	@Autowired
	private ProductMainService productMainService;

	@RequestMapping("/")
	public String firstpage() {
		return "main/firstpage";
	}
}

