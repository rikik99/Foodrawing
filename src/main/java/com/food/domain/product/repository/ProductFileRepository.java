package com.food.domain.product.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.product.entity.ProductFile;

public interface ProductFileRepository extends JpaRepository<ProductFile, Long> {

    
}