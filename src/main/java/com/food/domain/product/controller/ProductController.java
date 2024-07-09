package com.food.domain.product.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

        List<CustomPageDTO> customList = new ArrayList<>();

        for (ProductNutritionDTO result : results) {
            ProductDTO product = productService.findById(result.getProductNumber());
            ProductFileDTO file = productService.getFileByProductNumber(result.getProductNumber());

            if (product != null) {
                customList.add(new CustomPageDTO(
                    result.getProductNumber(),
                    result.getCalorie(),
                    result.getProtein(),
                    result.getFat(),
                    result.getTransFat(),
                    result.getSaturatedFat(),
                    result.getCarbohydrate(),
                    result.getSugar(),
                    result.getSodium(),
                    result.getCholesterol(),
                    result.getWeight(),
                    product.getName(),
                    product.getDescription(),
                    product.getPrice(),
                    product.getQuantity(),
                    product.getCreatedDate(),
                    file != null ? file.getId() : null,
                    file != null ? file.getOriginalName() : null,
                    file != null ? file.getFilePath() : null,
                    file != null ? file.getFileType() : null,
                    file != null ? file.getUploadDate() : null
                ));
            }
        }

        logger.info("Custom List: {}", customList);
        return customList;
    }
}
