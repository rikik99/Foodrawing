package com.food.domain.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.product.dto.ProductNutritionDTO;
import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountInfoDTO;

@Mapper
public interface ProductDetailMapper {

	ProductDTO getProductById(String productNumber);

	ProductFileDTO getProductFileByProductNumber(String productNumber);

	ProductCategoryDTO getCategoryByCategryCode(String categoryCode);

	List<DiscountInfoDTO> getDiscount(ProductCategoryDTO productCategoryInfo, String productNumber);

}