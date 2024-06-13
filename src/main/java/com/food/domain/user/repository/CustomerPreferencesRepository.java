package com.food.domain.user.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.user.entity.CustomerPreferences;

public interface CustomerPreferencesRepository extends JpaRepository<CustomerPreferences, Long> {

    
}