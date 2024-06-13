package com.food.domain.product.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.product.entity.Product;

public interface ProductRepository extends JpaRepository<Product, String> {

    
}