package com.food.domain.product.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.food.domain.product.dto.CustomPageDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.ProductNutritionDTO;
import com.food.domain.product.service.ProductService;

@RestController
public class ProductController {
    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    private ProductService productService;

    // 영양소 커스텀 페이지로 이동
    @GetMapping("/custompage")
    public ModelAndView nutrientCustom() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("main/custompage"); // custompage.jsp로 이동
        return mv;
    }

    // 영양소 필터링에 따른 제품 데이터 반환
    @RequestMapping("/nutrition")
    public List<CustomPageDTO> getProductNutritions(
        @RequestParam(value = "protein", required = false) Long protein,
        @RequestParam(value = "transFat", required = false) Long transFat,
        @RequestParam(value = "saturatedFat", required = false) Long saturatedFat,
        @RequestParam(value = "sugar", required = false) Long sugar,
        @RequestParam(value = "sodium", required = false) Long sodium,
        @RequestParam(value = "carbohydrate", required = false) Long carbohydrate) {
        
        ProductNutritionDTO criteria = new ProductNutritionDTO();
        criteria.setProtein(protein);
        criteria.setTransFat(transFat);
        criteria.setSaturatedFat(saturatedFat);
        criteria.setSugar(sugar);
        criteria.setSodium(sodium);
        criteria.setCarbohydrate(carbohydrate);

        logger.info("Criteria: {}", criteria);

        List<ProductNutritionDTO> results = productService.getProductNutritionsByCriteria(criteria);

        logger.info("Results: {}", results);

        List<ProductDTO> productList = productService.getProductName(results);
        List<ProductFileDTO> fileList = productService.getProductFile(results);

        List<CustomPageDTO> customList = new ArrayList<>();

        for (int i = 0; i < results.size(); i++) {
            String productName = (i < productList.size()) ? productList.get(i).getName() : null;
            String productDescription = (i < productList.size()) ? productList.get(i).getDescription() : null;
            Long productPrice = (i < productList.size()) ? productList.get(i).getPrice() : null;
            Long productQuantity = (i < productList.size()) ? productList.get(i).getQuantity() : null;
            LocalDateTime productCreatedDate = (i < productList.size()) ? productList.get(i).getCreatedDate() : null;

            Long fileId = (i < fileList.size() && fileList.get(i) != null) ? fileList.get(i).getId() : null;
            String fileOriginalName = (i < fileList.size() && fileList.get(i) != null) ? fileList.get(i).getOriginalName() : null;
            String filePath = (i < fileList.size() && fileList.get(i) != null) ? fileList.get(i).getFilePath() : null;
            String fileType = (i < fileList.size() && fileList.get(i) != null) ? fileList.get(i).getFileType() : null;
            LocalDateTime fileUploadDate = (i < fileList.size() && fileList.get(i) != null) ? fileList.get(i).getUploadDate() : null;
            customList.add(new CustomPageDTO(
                results.get(i).getProductNumber(),
                results.get(i).getCalorie(),
                results.get(i).getProtein(),
                results.get(i).getFat(),
                results.get(i).getTransFat(),
                results.get(i).getSaturatedFat(),
                results.get(i).getCarbohydrate(),
                results.get(i).getSugar(),
                results.get(i).getSodium(),
                results.get(i).getCholesterol(),
                results.get(i).getWeight(),
                productName,
                productDescription,
                productPrice,
                productQuantity,
                productCreatedDate,
                fileId,
                fileOriginalName,
                filePath,
                fileType,
                fileUploadDate
            ));
        }

        logger.info("Custom List: {}", customList);
        return customList;
    }
}
