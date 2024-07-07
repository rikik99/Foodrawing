package com.food.domain.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductCategoryMappingDTO;

@Mapper
public interface CategoryMapper {

    List<ProductCategoryDTO> selectCategoriesByProductNumber(@Param("productNumber") String productNumber);

    List<ProductCategoryDTO> selectAllCategories();

    List<ProductCategoryMappingDTO> selectCategoryMappingByProductNumber(@Param("productNumber") String productNumber);
}
