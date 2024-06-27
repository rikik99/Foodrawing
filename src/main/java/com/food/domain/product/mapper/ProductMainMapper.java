package com.food.domain.product.mapper;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.dto.ProductFileDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductMainMapper {

    List<ProductDTO> selectAllProducts();

    List<ProductFileDTO> selectAllProductFiles();

    ProductFileDTO fileByResults(@Param("productNumber") String productNumber);

    List<ProductDTO> findProductsByCategory(@Param("categoryId") int categoryId);
}
