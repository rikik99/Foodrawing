package com.food.domain.support.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FaqController {
	@RequestMapping("/csMain")
	ModelAndView csMain() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("support/csMain");
		return mv;
	}
}
