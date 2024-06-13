package com.food.domain.product.service;

import java.util.ArrayList;
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

	public List<ProductDTO> getProductName(List<ProductNutritionDTO> results) {
		List<ProductDTO> products = new ArrayList<>();
		
		for(int i = 0; i < results.size(); i++) {
			ProductDTO product = productMapper.selectByResults(results.get(i));
			products.add(product);
		}
		
		return products;
	}

	public List<ProductFileDTO> getProductFile(List<ProductNutritionDTO> results) {
		List<ProductFileDTO> files = new ArrayList<>();
		
		for(int i = 0; i < results.size(); i++) {
			ProductFileDTO file = productMapper.fileByResults(results.get(i));
			files.add(file);
		}
		
		return files;
	}

    public ProductDTO findById(String productId) {
        return productMapper.findById(productId);
    }
}
