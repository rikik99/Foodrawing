package com.food.domain.order.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.order.entity.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {

}