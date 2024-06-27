package com.food.domain.sales.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.service.ProductMainService;

@Controller
public class SalesController {
	
	@Autowired
	private ProductMainService productMainService;
	
	@RequestMapping("/")
	public String firstpage() {
		return "main/firstpage";
	}
	
	@RequestMapping("/main/mainpage")
	public ModelAndView main() {
		ModelAndView mv = new ModelAndView();
        List<ProductDTO> products = productMainService.getAllProducts();
        List<ProductFileDTO> productFiles = productMainService.getAllProductFiles();

        mv.addObject("products", products);
        mv.addObject("productFiles", productFiles);
        mv.setViewName("main/mainpage");
		return mv;
	}
	
	@RequestMapping("/main/custompage")
	public String custompage() {
		return "main/custompage";
	}
}

