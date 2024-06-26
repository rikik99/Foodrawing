package com.food.domain.order.dto;

import java.util.List;

import lombok.Data;

@Data
public class CartRequestDTO {
    private Long customerId;
    private String productNumber; // 단일 제품의 경우 사용
    private int quantity;
    private List<String> productNumbers; // 선택된 여러 항목의 경우 사용
}
