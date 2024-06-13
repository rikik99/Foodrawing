package com.food.domain.order.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.order.entity.Delivery;

public interface DeliveryRepository extends JpaRepository<Delivery, Long> {

    
}