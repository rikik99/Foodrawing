package com.food.domain.product.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.product.entity.ProductCategoryMapping;

public interface ProductCategoryMappingRepository extends JpaRepository<ProductCategoryMapping, Long> {

    
}