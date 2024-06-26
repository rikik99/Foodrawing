package com.food.domain.product.mapper;

import com.food.domain.product.dto.ProductCategoryDTO;
import com.food.domain.product.dto.ProductCategoryMappingDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CategoryMapper {

    List<ProductCategoryDTO> selectCategoriesByProductNumber(@Param("productNumber") String productNumber);

    List<ProductCategoryDTO> selectAllCategories();

    List<ProductCategoryMappingDTO> selectCategoryMappingByProductNumber(@Param("productNumber") String productNumber);
}
