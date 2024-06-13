package com.food.domain.sales.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SalesController {
	@RequestMapping("/")
	public String firstpage() {
		return "main/firstpage";
	}
	@RequestMapping("/main/mainpage")
	public String main() {
		return "main/mainpage";
	}
	@RequestMapping("/main/custompage")
	public String custompage() {
		return "main/custompage";
	}
}

