package com.food.domain.product.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StockTransactionDTO {
    private Long id;
    private String productNumber;
    private String transactionType;
    private Long quantity;
    private LocalDateTime transactionDate;
    private LocalDateTime expirationDate;
}