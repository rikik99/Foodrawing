package com.food.domain.user.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.user.entity.Admin;

public interface AdminRepository extends JpaRepository<Admin, Long> {

    
}