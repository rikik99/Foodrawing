package com.food.domain.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.ProductNutritionDTO;

@Mapper
public interface ProductMapper {
    List<ProductNutritionDTO> selectByCriteria(ProductNutritionDTO productNutrition);

	ProductDTO selectByResults(ProductNutritionDTO productNutritionDTO);

	ProductFileDTO fileByResults(String productNumber);
	
	ProductDTO getProductById(String productNumber);

	ProductDTO findById(String productNumber);
}