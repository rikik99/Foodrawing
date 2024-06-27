package com.food.domain.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.mapper.ProductDetailMapper;
import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountInfoDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.mapper.SalesMapper;

@Controller
public class ProductBController {
	
	@Autowired
	ProductDetailMapper productDetailMapper;

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
	   ProductDTO productInfo = productDetailMapper.getProductById(salesPost.getProductNumber());
	   //System.out.println("product = " + productinfo);
	   mv.addObject("productInfo", productInfo);
	   
	   //상품 파일 정보
	   ProductFileDTO productFileInfo = productDetailMapper.getProductFileByProductNumber(salesPost.getProductNumber());
	   //System.out.println("productFileInfo = " + productFileInfo);
	   mv.addObject("productFileInfo", productFileInfo);
	   
	   //상품 카테고리 정보
	   String categoryCode = productInfo.getProductNumber().substring(0, 2);
	   ProductCategoryDTO productCategoryInfo = productDetailMapper.getCategoryByCategryCode(categoryCode);
	   
	   //상품 할인 정보(카테고리 or 상품 할인)
	   List<DiscountInfoDTO> discountInfo = productDetailMapper.getDiscount(productCategoryInfo, salesPost.getProductNumber());
	   int discountPrice = 0;
	   
	   //할인가 계산
	   if (discountInfo.size() == 1) {
		   mv.addObject("discountInfo", discountInfo);
		   
		   if(discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
			   discountPrice = (int) (productInfo.getPrice() * (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
		   } else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
			   discountPrice = (int) (productInfo.getPrice() - discountInfo.get(0).getDiscountDTO().getDiscountValue());
		   }
	   } else if (discountInfo.size() > 1) {
		   mv.addObject("discountInfo", discountInfo);
		   int a = 0;
		   int b = 0;
		   
		   for(DiscountInfoDTO discount : discountInfo) {
			   if(discountInfo.get(0).getDiscountDTO().getDiscountType().equals("P")) {
				   a = (int) (productInfo.getPrice() * (1 - (discountInfo.get(0).getDiscountDTO().getDiscountValue() * 0.01)));
			   } else if (discountInfo.get(0).getDiscountDTO().getDiscountType().equals("A")) {
				   b = (int) (productInfo.getPrice() - discountInfo.get(0).getDiscountDTO().getDiscountValue());
			   }
		   }
		   
		   discountPrice = (a > b) ? a : b;
	   }
	   mv.addObject("discountPrice", discountPrice);
	   
	   Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
       boolean isLoggedIn = authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal());
       
       mv.addObject("isLoggedIn", isLoggedIn);
	   
       mv.setViewName("product/productDetail");
       return mv;
   }
}
