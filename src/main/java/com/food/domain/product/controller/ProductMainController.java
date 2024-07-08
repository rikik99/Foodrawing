package com.food.domain.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.food.domain.product.dto.BestDTO;
import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.service.ProductMainService;
import com.food.domain.sales.dto.Discount2DTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductMainController {

    private final ProductMainService productMainService;

    @Autowired
    public ProductMainController(ProductMainService productMainService) {
        this.productMainService = productMainService;
    }

    @GetMapping("/mainpage")
    public String getAllProducts(@RequestParam("category") int category, Model model, Authentication authentication) {
        List<ProductDTO> recommendedProducts = productMainService.getProductsByCategory(category);
        List<ProductDTO> allProducts = productMainService.getAllProducts();
        List<ProductFileDTO> productFiles = productMainService.getAllProductFiles();
        List<ProductCategoryDTO> allCategories = productMainService.getAllCategories();
        List<BestDTO> bestSellingProducts = productMainService.getBestSellingProducts();
        List<Discount2DTO> discountProducts = productMainService.getDiscountProducts(); // 추가된 부분
        boolean isLoggedIn = (authentication != null && authentication.isAuthenticated());
        log.info("isLoggedIn = {}",isLoggedIn);
        model.addAttribute("isLoggedIn", isLoggedIn);
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
        model.addAttribute("bestSellingProducts", bestSellingProducts);
        log.info("bestSellingProducts = {}", bestSellingProducts);
        model.addAttribute("discountProducts", discountProducts); // 추가된 부분
        log.info("discountProducts = {}", discountProducts);
        return "main/mainpage";
    }
}
