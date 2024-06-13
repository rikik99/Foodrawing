package com.food.domain.order.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.order.entity.OrderStatus;

public interface OrderStatusRepository extends JpaRepository<OrderStatus, Long> {

    
}