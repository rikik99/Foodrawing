package com.food.domain.support.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.support.entity.Chat;

public interface ChatRepository extends JpaRepository<Chat, Long> {

    
}