package com.food.domain.support.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.support.entity.Inquiries;

public interface InquiriesRepository extends JpaRepository<Inquiries, Long> {

    
}