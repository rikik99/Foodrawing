package com.food.domain.product.controller;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.service.ProductMainService;
import com.food.domain.user.controller.UserController;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@Controller
public class ProductMainController {

	private final ProductMainService productMainService;

	@Autowired
	public ProductMainController(ProductMainService productMainService) {
		this.productMainService = productMainService;
	}

	@GetMapping("/mainpage")
	public String getAllProducts(@RequestParam("category") int category, Model model) {
		List<ProductDTO> recommendedProducts = productMainService.getProductsByCategory(category);
		List<ProductDTO> allProducts = productMainService.getAllProducts();
		List<ProductFileDTO> productFiles = productMainService.getAllProductFiles();
		List<ProductCategoryDTO> allCategories = productMainService.getAllCategories();

		model.addAttribute("category", category);
		log.info("category = {}", category);
		model.addAttribute("recommendedProducts", recommendedProducts);
		log.info("recommendedProducts = {}", recommendedProducts);
		model.addAttribute("products", allProducts);
		log.info("allProducts = {}", allProducts);
		model.addAttribute("productFiles", productFiles);
		log.info("productFiles = {}", productFiles);
		model.addAttribute("categories", allCategories);
		log.info("allCategories = {}", allCategories);
		return "main/mainpage";
	}
}
