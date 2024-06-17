package com.food.domain.user.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/admin")
@Controller
public class AdminController {
    @GetMapping("/login")
    public ModelAndView login(Authentication authentication) {
        // 로그인된 사용자가 로그인 페이지로 접근할 경우 메인 페이지로 리다이렉트
        if (authentication != null && authentication.isAuthenticated()) {
            return new ModelAndView("redirect:/admin/main");
        }
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/login");
        return mv;
    }

    @GetMapping("/main")
    public ModelAndView admindashboard() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/adminMain");
        return mv;
    }

    @GetMapping("/mainContent")
    public ModelAndView adminMain() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/mainContent");
        return mv;
    }

    @GetMapping("/productManagement")
    public ModelAndView productManagement() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/productManagement");
        return mv;
    }
    @GetMapping("/stockManagement")
    public ModelAndView stockManagement() {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("admin/stockManagement");
    	return mv;
    }
    @GetMapping("/stockTransaction")
    public ModelAndView stockTransaction() {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("admin/stockTransaction");
    	return mv;
    }

}
