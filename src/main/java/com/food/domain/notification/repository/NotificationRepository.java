package com.food.domain.notification.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.notification.entity.Notification;

public interface NotificationRepository extends JpaRepository<Notification, Long> {

    
}