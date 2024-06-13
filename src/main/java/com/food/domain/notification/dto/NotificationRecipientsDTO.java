package com.food.domain.notification.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationRecipientsDTO {
    private Long id;
    private Long notificationId;
    private Long userId;
    private String readYn;
    private LocalDateTime readDate;
}