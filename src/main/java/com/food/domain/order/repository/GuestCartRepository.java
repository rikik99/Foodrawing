package com.food.domain.order.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.order.entity.GuestCart;

public interface GuestCartRepository extends JpaRepository<GuestCart, Long> {

    
}