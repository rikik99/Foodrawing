package com.food.domain.order.dto;

import lombok.Data;

@Data
public class CartRequestDTO {
    private Long customerId;
    private String productNumber;
    private int quantity;
}