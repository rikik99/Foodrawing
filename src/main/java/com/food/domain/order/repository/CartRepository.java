package com.food.domain.order.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.order.entity.Cart;

public interface CartRepository extends JpaRepository<Cart, Long> {

    
}