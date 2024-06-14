package com.food.domain.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@RequestMapping("/admin")
@Controller
public class AdminController {
    @GetMapping("/loginContent")
    public ModelAndView adminLoginContent() {
        ModelAndView mv = new ModelAndView();
        // 필요한 경우 추가 데이터를 모델에 추가
        mv.setViewName("admin/adminContrent");
        mv.addObject("message", "Welcome to the admin login page");
        return mv;
    }
    @GetMapping("/dashboard")
    public ModelAndView admindashboard() {
    	ModelAndView mv = new ModelAndView();
    	// 필요한 경우 추가 데이터를 모델에 추가
    	mv.setViewName("admin/adminMain");
    	mv.addObject("message", "Welcome to the admin login page");
    	return mv;
    }
}
