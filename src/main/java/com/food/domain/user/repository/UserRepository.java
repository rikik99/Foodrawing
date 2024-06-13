package com.food.domain.user.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.user.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {

    
}