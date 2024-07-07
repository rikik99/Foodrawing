package com.food.domain.product.controller;

import java.util.ArrayList;
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
import com.food.domain.sales.dto.DiscountTargetDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.sales.mapper.DiscountMapper;
import com.food.domain.sales.mapper.ReviewMapper;
import com.food.domain.sales.mapper.SalesMapper;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.GuestDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.service.CustomerService;
import com.food.domain.user.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductBController {
	
	@Autowired
	private ProductDetailMapper productDetailMapper;

	@Autowired
	private SalesMapper salesMapper;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Autowired
	private DiscountMapper discountMapper;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CustomerService customerService;
	
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
	   System.out.println("productNumber and Sales Post id : " + salesPost.getProductNumber() + " / " + salesPost.getId());
	   
	   //상품 등록 정보 가져오기 + file
	   SalesPostDTO salesInfo = salesMapper.getSalesById(salesPost);
	   mv.addObject("salesInfo", salesInfo);
	   
	   //상품 고정 바꾸기
	   //String productNumber = "ST003";   
	   //salesPost.setProductNumber(productNumber);
	   
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
	   
	   // 상품 할인 정보(카테고리 or 상품 할인)
	   List<DiscountInfoDTO> discountInfo = new ArrayList<>();

	   // 카테고리로 할인 가져오기
	   DiscountTargetDTO categoryTargetDiscount = discountMapper.getCategroyTargetDiscount(productCategoryInfo.getId());
	   if (categoryTargetDiscount != null) {
	       DiscountDTO categoryDiscount = discountMapper.getDiscount(categoryTargetDiscount.getDiscountId());
	       DiscountInfoDTO categoryDiscountInfo = new DiscountInfoDTO();
	       categoryDiscountInfo.setDiscountDTO(categoryDiscount);
	       categoryDiscountInfo.setDiscountTargetDTO(categoryTargetDiscount);
	       discountInfo.add(categoryDiscountInfo);
	   }

	   // 상품으로 할인 가져오기
	   DiscountTargetDTO productTargetDiscount = discountMapper.getProductTargetDiscount(salesPost.getProductNumber());
	   if (productTargetDiscount != null) {
	       DiscountDTO productDiscount = discountMapper.getDiscount(productTargetDiscount.getDiscountId());
	       DiscountInfoDTO productDiscountInfo = new DiscountInfoDTO();
	       productDiscountInfo.setDiscountDTO(productDiscount);
	       productDiscountInfo.setDiscountTargetDTO(productTargetDiscount);
	       discountInfo.add(productDiscountInfo);
	   }
	   
	   //productDetailMapper.getDiscount(productCategoryInfo, salesPost.getProductNumber());
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
	   
	   //리뷰 사전 정보 가져오기
	   //리뷰 개수
	   int totalReviews = (reviewMapper.countReviews(salesPost.getId()) > 0 ? reviewMapper.countReviews(salesPost.getId()) : 0);
	   mv.addObject("totalReviews", totalReviews);
	   
	   // 리뷰 평균 점수
       double averageRating = reviewMapper.getAverageRating(salesPost.getId());
       mv.addObject("averageRating", averageRating);
       int floorRating = (int) Math.floor(averageRating);
       mv.addObject("floorRating", floorRating);

       // 점수별 리뷰 비율
       int[] ratingPercentageArray = new int[5];
       
       for (int i = 5; i > 0; i--) {
    	   ratingPercentageArray[i - 1] = reviewMapper.getRatingPercentages(salesPost.getId(), i);
       }   		   
       System.out.println("ratingPercentageArray : " + ratingPercentageArray.toString());
       
       
       mv.addObject("ratingPercentages", ratingPercentageArray);
	   
       //로그인 가져오기
	   Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
       boolean isLoggedIn = authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal());
       
       mv.addObject("isLoggedIn", isLoggedIn);
       
       String username = authentication.getName();
       System.out.println("username: " + username);
       CustomerDTO customerDTO = new CustomerDTO();
       GuestDTO guestDTO = new GuestDTO();
       if (isLoggedIn) {
    	   UserDTO user = userService.loadUser(username);
    	   log.info("product UserDTO = {}",user);
    	   Long userId = user.getId();
    	   customerDTO = customerService.findCustomerByUserId(userId);
    	   log.info("customDTO = {}", customerDTO);
    	   System.out.println("customerDTO: " + customerDTO);
    	   
    	   if (customerDTO == null) {
	           log.info("customDTO is null, redirecting to login");
	           //mv.setViewName();"redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	       }
       }
       mv.addObject("customer", customerDTO);
       
	   
       mv.setViewName("product/productDetail");
       return mv;
   }
}