package com.food.domain.sales.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.food.domain.sales.dto.Discount2DTO;
import com.food.domain.sales.service.DiscountService;

@Controller
@RequestMapping("/discounts")
public class DiscountController {

    @Autowired
    private DiscountService discountService;

    @GetMapping("/{id}")
    public Discount2DTO getDiscount(@PathVariable Long id) {
        return discountService.getDiscountById(id);
    }

    @GetMapping("/category/{categoryId}")
    public List<Discount2DTO> getCategoryTargetDiscount(@PathVariable Long categoryId) {
        return discountService.getCategoryTargetDiscount(categoryId);
    }

    @GetMapping("/product/{productId}")
    public List<Discount2DTO> getProductTargetDiscount(@PathVariable Long productId) {
        return discountService.getProductTargetDiscount(productId);
    }

    @GetMapping("/discountpage")
    public String getDiscountProducts(Model model) {
        List<Discount2DTO> discountProducts = discountService.getDiscountProducts();
        model.addAttribute("discountProducts", discountProducts);
        return "main/discountpage";
    }
}
