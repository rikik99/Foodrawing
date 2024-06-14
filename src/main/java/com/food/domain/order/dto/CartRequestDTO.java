package com.food.domain.order.dto;

import java.util.List;

import lombok.Data;

@Data
public class CartRequestDTO {
    private Long customerId;
    private String productId;
    private int quantity;
    private List<Long> productIds; // 선택된 항목 결제 시 필요한 필드
}