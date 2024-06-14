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
public class CartDTO {
    private Long id;
    private Long customerId;
    private String productNumber;
    private Long quantity;
    private LocalDateTime lastDate;
}
