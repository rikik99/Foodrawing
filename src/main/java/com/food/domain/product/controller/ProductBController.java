package com.food.domain.product.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductDetailCategoryInfo;
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
   
    @GetMapping("/productDetail/{id}")
    public ModelAndView productDetailGet(@PathVariable Long id) {
        return productDetail(id);
    }

    @PostMapping("/productDetail/{id}")
    public ModelAndView productDetailPost(@PathVariable Long id) {
        return productDetail(id);
    }

    private ModelAndView productDetail(Long id) {
        ModelAndView mv = new ModelAndView();
        
        SalesPostDTO salesPost = salesMapper.findSalesPostById(id);
        if (salesPost == null) {
            mv.setViewName("error/404"); // salesPost가 null인 경우 404 페이지로 리다이렉트
            return mv;
        }
        System.out.println("salesPost: " + salesPost);
        
        salesPost.setProductNumber(salesMapper.getIdByProductNumber(salesPost));
        System.out.println("productNumber and Sales Post id : " + salesPost.getProductNumber() + " / " + salesPost.getId());
        
        SalesPostDTO salesInfo = salesMapper.getSalesById(salesPost);
        mv.addObject("salesInfo", salesInfo);
        
        ProductDTO productInfo = productDetailMapper.getProductById(salesPost.getProductNumber());
        if (productInfo == null) {
            mv.setViewName("error/404"); // productInfo가 null인 경우 404 페이지로 리다이렉트
            return mv;
        }
        mv.addObject("productInfo", productInfo);
        
        ProductFileDTO productFileInfo = productDetailMapper.getProductFileByProductNumber(salesPost.getProductNumber());
        mv.addObject("productFileInfo", productFileInfo);
        
        String categoryCode = productInfo.getProductNumber().substring(0, 2);
        ProductCategoryDTO productCategoryInfo = productDetailMapper.getCategoryByCategryCode(categoryCode);
        
        List<DiscountInfoDTO> discountInfo = new ArrayList<>();

        DiscountTargetDTO categoryTargetDiscount = discountMapper.getCategroyTargetDiscount(productCategoryInfo.getId());
        if (categoryTargetDiscount != null) {
            DiscountDTO categoryDiscount = discountMapper.getDiscount(categoryTargetDiscount.getDiscountId());
            if (categoryDiscount != null) {
                DiscountInfoDTO categoryDiscountInfo = new DiscountInfoDTO();
                categoryDiscountInfo.setDiscountDTO(categoryDiscount);
                categoryDiscountInfo.setDiscountTargetDTO(categoryTargetDiscount);
                discountInfo.add(categoryDiscountInfo);
            }
        }

        DiscountTargetDTO productTargetDiscount = discountMapper.getProductTargetDiscount(salesPost.getProductNumber());
        if (productTargetDiscount != null) {
            DiscountDTO productDiscount = discountMapper.getDiscount(productTargetDiscount.getDiscountId());
            if (productDiscount != null) {
                DiscountInfoDTO productDiscountInfo = new DiscountInfoDTO();
                productDiscountInfo.setDiscountDTO(productDiscount);
                productDiscountInfo.setDiscountTargetDTO(productTargetDiscount);
                discountInfo.add(productDiscountInfo);
            }
        }
        
        int discountPrice = 0;
        String discountType = "";
        
        if (discountInfo.size() == 1) {
            DiscountInfoDTO singleDiscount = discountInfo.get(0);
            DiscountDTO discountDTO = singleDiscount.getDiscountDTO();
            if (discountDTO != null) {
                mv.addObject("discountInfo", discountInfo);

                if(discountDTO.getDiscountType().equals("P")) {
                    discountPrice = (int) (productInfo.getPrice() * (1 - (discountDTO.getDiscountValue() * 0.01)));
                    discountType = discountDTO.getDiscountValue() + "%";
                } else if (discountDTO.getDiscountType().equals("A")) {
                    discountPrice = (int) (productInfo.getPrice() - discountDTO.getDiscountValue());
                    discountType = "-" + discountDTO.getDiscountValue();
                }
            }
        } else if (discountInfo.size() > 1) {
            mv.addObject("discountInfo", discountInfo);
            int a = 0;
            int b = 0;

            for(DiscountInfoDTO discount : discountInfo) {
                DiscountDTO discountDTO = discount.getDiscountDTO();
                if (discountDTO != null) {
                    if(discountDTO.getDiscountType().equals("P")) {
                        a = (int) (productInfo.getPrice() * (1 - (discountDTO.getDiscountValue() * 0.01)));
                        discountType = discountDTO.getDiscountValue() + "%";
                    } else if (discountDTO.getDiscountType().equals("A")) {
                        b = (int) (productInfo.getPrice() - discountDTO.getDiscountValue());
                        discountType = "-" + discountDTO.getDiscountValue();
                    }
                }
            }

            discountPrice = (a > b) ? a : b;
        }

        mv.addObject("discountPrice", discountPrice);
        mv.addObject("discountType", discountType);

        int totalReviews = (reviewMapper.countReviews(salesPost.getId()) > 0 ? reviewMapper.countReviews(salesPost.getId()) : 0);
        mv.addObject("totalReviews", totalReviews);

        double averageRating = reviewMapper.getAverageRating(salesPost.getId());
        mv.addObject("averageRating", averageRating);
        int floorRating = (int) Math.floor(averageRating);
        mv.addObject("floorRating", floorRating);

        int[] ratingPercentageArray = new int[5];
        
        for (int i = 5; i > 0; i--) {
            ratingPercentageArray[i - 1] = reviewMapper.getRatingPercentages(salesPost.getId(), i);
        }              
        System.out.println("ratingPercentageArray : " + ratingPercentageArray.toString());
        
        mv.addObject("ratingPercentages", ratingPercentageArray);

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
        
        List<ProductDetailCategoryInfo> categoryProducts = productDetailMapper.getDiscountedProducts(salesPost.getProductNumber(), categoryCode);
        mv.addObject("categoryProducts", categoryProducts);
        
        System.out.println("categoryProducts: " + categoryProducts);
        
        mv.setViewName("product/productDetail");
        return mv;
    }


}
