package com.food.domain.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.ProductNutritionDTO;
import com.food.domain.product.mapper.ProductMapper;

@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    public List<ProductNutritionDTO> getProductNutritionsByCriteria(ProductNutritionDTO productNutrition) {
        return productMapper.selectByCriteria(productNutrition);
    }

    public ProductDTO findById(String productNumber) {
        return productMapper.findById(productNumber);
    }

    public ProductFileDTO getFileByProductNumber(String productNumber) {
        return productMapper.fileByResults(productNumber);
    }
}
