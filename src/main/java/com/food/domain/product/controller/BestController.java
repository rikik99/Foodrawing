package com.food.domain.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.food.domain.product.dto.BestDTO;
import com.food.domain.product.service.BestService;

@Controller
@RequestMapping("/main")
public class BestController {

	private final BestService bestService;

	@Autowired
	public BestController(BestService bestService) {
		this.bestService = bestService;
	}

	@GetMapping("/bestpage")
	public String getBestSellingProducts(Model model) {
		// 로그인 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isLoggedIn = authentication != null && authentication.isAuthenticated()
				&& !"anonymousUser".equals(authentication.getPrincipal());

		model.addAttribute("isLoggedIn", isLoggedIn);
		List<BestDTO> bestSellingProducts = bestService.getBestSellingProducts();
		model.addAttribute("bestSellingProducts", bestSellingProducts);
		return "main/bestpage";
	}

	@GetMapping("/mainpage")
	public String getMainPage(Model model) {
		List<BestDTO> bestSellingProducts = bestService.getBestSellingProducts();
		model.addAttribute("bestSellingProducts", bestSellingProducts);

		return "main/mainpage";
	}
}
