package com.food.domain.order.dto;

import java.util.List;

import lombok.Data;

@Data
public class CheckoutRequestDTO {
    private Long customerId;
    private List<String> productIds;
}