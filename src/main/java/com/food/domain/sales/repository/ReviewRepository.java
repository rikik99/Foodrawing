package com.food.domain.sales.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.sales.entity.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    
}