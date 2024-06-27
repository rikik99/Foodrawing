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
public class OrderDTO {
    private Long id;
    private String identifierId;
    private String identifierType;
    private LocalDateTime orderDate;
    private String totalAmount;
    private Long orderNumber;
    private String paymentId;
    private String paymentType;
}