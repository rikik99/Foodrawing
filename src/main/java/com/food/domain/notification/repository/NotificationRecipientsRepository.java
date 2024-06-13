package com.food.domain.notification.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.food.domain.notification.entity.NotificationRecipients;

public interface NotificationRecipientsRepository extends JpaRepository<NotificationRecipients, Long> {

    
}