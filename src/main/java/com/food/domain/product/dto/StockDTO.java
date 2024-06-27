package com.food.domain.product.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StockDTO {
    private Long id;
    private String productNumber;
    private Long quantity;
    private LocalDateTime lastUpdated;
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public String getFormattedLastUpdated() {
        if (lastUpdated != null) {
            return lastUpdated.format(formatter);
        }
        return "";
    }
    
}