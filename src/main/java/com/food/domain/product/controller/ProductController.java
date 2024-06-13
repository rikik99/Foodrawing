package com.food.domain.product.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

        for(int i = 0; i < results.size(); i++) {
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
                productList.get(i).getName(),
                productList.get(i).getDescription(),
                productList.get(i).getPrice(),
                productList.get(i).getQuantity(),
                productList.get(i).getCreatedDate(),
                fileList.get(i).getId(),
                fileList.get(i).getOriginalName(),
                fileList.get(i).getFilePath(),
                fileList.get(i).getFileType(),
                fileList.get(i).getUploadDate()
            ));
        }

        logger.info("Custom List: {}", customList);
        return customList;
    }
}
