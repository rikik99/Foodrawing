package com.food.domain.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.user.service.AdminService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/admin")
@Controller
public class AdminController {

	@Autowired
	AdminService adminService;

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
	public ModelAndView productManagement(@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "size", defaultValue = "5") int size) {
		ModelAndView mv = new ModelAndView();
		Pageable pageable = PageRequest.of(page, size);
		Page<ProductDTO> ProductList = adminService.findProductList(pageable);
		List<ProductCategoryDTO> categoryList = adminService.findCategoryList();
		mv.addObject("product", ProductList);
		mv.addObject("categoryList", categoryList);
		mv.addObject("currentPage", ProductList.getNumber());
		mv.addObject("pageCount", ProductList.getTotalPages());
		mv.addObject("size", size);
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

	@GetMapping("/salesReview")
	public ModelAndView salesReview() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/salesReview");
		return mv;
	}

	@GetMapping("/discountList")
	public ModelAndView discountList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/discountList");
		return mv;
	}

	@GetMapping("/discountManagement")
	public ModelAndView discountManagement() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/discountManagement");
		return mv;
	}

	@GetMapping("/couponList")
	public ModelAndView couponList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/couponList");
		return mv;
	}

	@GetMapping("/couponManagement")
	public ModelAndView couponManagement() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/couponManagement");
		return mv;
	}

	@GetMapping("/orderList")
	public ModelAndView orderList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/orderList");
		return mv;
	}

	@GetMapping("/deliveryList")
	public ModelAndView deliveryList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/deliveryList");
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
