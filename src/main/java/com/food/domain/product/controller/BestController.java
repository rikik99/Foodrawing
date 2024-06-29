package com.food.domain.product.controller;

import com.food.domain.product.dto.BestDTO;
import com.food.domain.product.service.BestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;

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
