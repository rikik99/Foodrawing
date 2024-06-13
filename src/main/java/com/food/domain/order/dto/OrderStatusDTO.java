package com.food.domain.order.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderStatusDTO {
    private Long id;
    private Long orderId;
    private String orderStatus;
    private String description;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
}