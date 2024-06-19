package com.food.domain.user.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
    @GetMapping("/salesPost")
    public ModelAndView salesPost() {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("admin/salesPost");
    	return mv;
    }
    @GetMapping("/salesInquiry")
    public ModelAndView salesInquiry() {
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("admin/salesInquiry");
    	return mv;
    }
    
	@GetMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
	    HttpSession session = request.getSession();
	    session.invalidate();

	    // JWT 쿠키 삭제
	    Cookie cookie = new Cookie("jwt", null);
	    cookie.setHttpOnly(true);
	    cookie.setSecure(true);
	    cookie.setPath("/");
	    cookie.setMaxAge(0); // 쿠키 삭제
	    response.addCookie(cookie);

	    ModelAndView mv = new ModelAndView();
	    mv.setViewName("redirect:/login");
	    return mv;
	}
}
