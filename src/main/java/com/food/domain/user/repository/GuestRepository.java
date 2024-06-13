package com.food.domain.user.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.user.entity.Guest;

public interface GuestRepository extends JpaRepository<Guest, Long> {

    
}