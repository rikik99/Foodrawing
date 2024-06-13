package com.food.domain.product.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.product.entity.StockTransaction;

public interface StockTransactionRepository extends JpaRepository<StockTransaction, Long> {

    
}