package com.food.domain.sales.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.sales.entity.ReviewFile;

public interface ReviewFileRepository extends JpaRepository<ReviewFile, Long> {

    
}