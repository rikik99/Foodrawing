package com.food.domain.order.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.order.entity.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    
}