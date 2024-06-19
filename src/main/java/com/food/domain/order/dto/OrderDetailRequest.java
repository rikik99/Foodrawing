package com.food.domain.order.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailRequest {
    private Long id;
    private Long orderId;
    private String salesPostId;
    private BigDecimal unitPrice;
    private BigDecimal discountPrice;
    private int quantity;
}