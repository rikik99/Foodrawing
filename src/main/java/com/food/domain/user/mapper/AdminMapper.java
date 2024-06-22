package com.food.domain.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;

@Mapper
public interface AdminMapper {

	List<ProductDTO> findProductList();

	ProductFileDTO findProductFileByProductNumber(String productNumber);

	ProductCategoryDTO findProductCategoryByProductNumber(String productNumber);

	List<ProductCategoryDTO> findCategoryList();
}
