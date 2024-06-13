package com.food.domain.sales.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.sales.entity.SalesPost;

public interface SalesPostRepository extends JpaRepository<SalesPost, Long> {

    
}