package com.food.domain.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.mapper.ProductMapper;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.dto.SalesPostFileDTO;
import com.food.domain.sales.mapper.SalesMapper;

@Controller
public class ProductBController {
	
	@Autowired
	ProductMapper productMapper;

	@Autowired
	SalesMapper salesMapper;
	
    @RequestMapping("/best")
    public ModelAndView main() {
        ModelAndView mv = new ModelAndView();
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isLoggedIn = authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal());
        
        mv.addObject("isLoggedIn", isLoggedIn);
        mv.setViewName("product/best");
        return mv;
    }
   
   @RequestMapping("/ProductDetail")
   public ModelAndView productDetail(SalesPostDTO salesPost) {
	   ModelAndView mv = new ModelAndView();
	   
	   //salesPost 고정
	   salesPost.setId(1L);
	   
	   //SalesPostTb productNumber 가져오기
	   salesPost.setProductNumber(salesMapper.getIdByProductNumber(salesPost));
	   
	   //상품 등록 정보 가져오기 + file
	   SalesPostDTO salesInfo = salesMapper.getSalesById(salesPost);
	   mv.addObject("salesInfo", salesInfo);
	   
	   //상품 고정 바꾸기
	   String productNumber = "ST001";
	   
	   salesPost.setProductNumber(productNumber);
	   
	   //상품 등록 파일 정보 가져오기
	   //SalesPostFileDTO salesFileInfo = salesMapper.getSalesFileById(salesPost);
	   
	   //상품 정보, 현재 하나로 고정
	   ProductDTO productInfo = productMapper.getProductById(salesPost.getProductNumber());
	   //System.out.println("product = " + productinfo);
	   mv.addObject("productInfo", productInfo);
	   
	   //상품 파일 정보
	   ProductFileDTO productFileInfo = productMapper.getProductFileByProductNumber(salesPost.getProductNumber());
	   //System.out.println("productFileInfo = " + productFileInfo);
	   mv.addObject("productFileInfo", productFileInfo);
	   
	   Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
       boolean isLoggedIn = authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal());
       
       mv.addObject("isLoggedIn", isLoggedIn);
	   
       mv.setViewName("product/productDetail");
       return mv;
   }
}
