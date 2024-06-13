package com.food.domain.support.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.support.entity.Faq;

public interface FaqRepository extends JpaRepository<Faq, Long> {

    
}