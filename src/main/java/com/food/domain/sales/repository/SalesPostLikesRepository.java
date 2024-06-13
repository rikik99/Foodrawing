package com.food.domain.sales.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.sales.entity.SalesPostLikes;

public interface SalesPostLikesRepository extends JpaRepository<SalesPostLikes, Long> {

    
}