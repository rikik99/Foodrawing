package com.food.domain.product.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.product.entity.ProductCategory;

public interface ProductCategoryRepository extends JpaRepository<ProductCategory, Long> {

    
}