package com.food.domain.sales.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.sales.entity.DiscountTarget;

public interface DiscountTargetRepository extends JpaRepository<DiscountTarget, Long> {

    
}