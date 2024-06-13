package com.food.domain.sales.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.sales.entity.SalesPostFile;

public interface SalesPostFileRepository extends JpaRepository<SalesPostFile, Long> {

    
}