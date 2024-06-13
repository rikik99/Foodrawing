package com.food.domain.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.mapper.ProductMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ProductBController {
	
	@Autowired
	ProductMapper productMapper;
	
   @RequestMapping("/best")
   public ModelAndView main(HttpServletRequest request) {
	   ModelAndView mv = new ModelAndView();

       mv.setViewName("product/best");
       return mv;
   }   
   
   @RequestMapping("/ProductDetail")
   public ModelAndView productDetail() {
	   ModelAndView mv = new ModelAndView();
	   
	   String productId = "MK001";
	   
	   //상품 정보, 현재 하나로 고정
	   ProductDTO productinfo = productMapper.getProductById(productId);
	   
	   mv.addObject("productinfo", productinfo);
	   
       mv.setViewName("product/productDetail");
       return mv;
   }
   
   @RequestMapping("/ProductDetail2")
   public ModelAndView productDetail2() {
	   ModelAndView mv = new ModelAndView();

       mv.setViewName("/productDetail2");
       return mv;
   }
}
