package com.food.domain.user.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.user.entity.CustomerReserves;

public interface CustomerReservesRepository extends JpaRepository<CustomerReserves, Long> {

    
}