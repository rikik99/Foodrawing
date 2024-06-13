package com.food.domain.support.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.support.entity.Response;

public interface ResponseRepository extends JpaRepository<Response, Long> {

    
}