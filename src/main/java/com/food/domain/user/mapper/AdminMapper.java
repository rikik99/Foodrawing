package com.food.domain.user.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.sales.dto.SalesPostDTO;

@Mapper
public interface AdminMapper {

	List<ProductDTO> findProductList();

	ProductFileDTO findProductFileByProductNumber(String productNumber);

	ProductCategoryDTO findProductCategoryByProductNumber(String productNumber);

	List<ProductCategoryDTO> findCategoryList();

	List<ProductDTO> findProductListByKeyword(Map<String, String> allParams);

	SalesPostDTO findSalesPostByProductNumber(String productNumber);

	ProductCategoryDTO getCategoryById(Long id);

	void insertProduct(Map<String, String> allParams);

	void insertProductFile(ProductFileDTO productFile);

	void updateCategoryById(Long categoryId);

	void insertProductCategoryMapping(String productNumber, Long categoryId);

	void deleteProductByProductNumber(String productNumber);
}
