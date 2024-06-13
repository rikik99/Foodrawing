package com.food.domain.sales.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.sales.entity.Discount;

public interface DiscountRepository extends JpaRepository<Discount, Long> {

    
}