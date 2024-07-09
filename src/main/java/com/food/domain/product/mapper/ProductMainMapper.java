package com.food.domain.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.sales.dto.SalesPostDTO;

@Mapper
public interface ProductMainMapper {

    List<ProductDTO> selectAllProducts();

    List<ProductFileDTO> selectAllProductFiles();

    ProductFileDTO fileByResults(@Param("productNumber") String productNumber);

    List<ProductDTO> findProductsByCategory(@Param("categoryId") int categoryId);

	SalesPostDTO getSalesPostByProductNumber(String productNumber);
}
