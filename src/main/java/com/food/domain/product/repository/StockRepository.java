package com.food.domain.product.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.product.entity.Stock;

public interface StockRepository extends JpaRepository<Stock, Long> {

    
}