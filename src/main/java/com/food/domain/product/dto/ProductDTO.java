package com.food.domain.product.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.food.domain.sales.dto.SalesPostDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {
    private String productNumber;
    private String name;
    private String description;
    private Long price;
    private Long quantity;
    private LocalDateTime createdDate;
    private ProductFileDTO productFileDTO;
    private ProductCategoryDTO productCategoryDTO;
    private SalesPostDTO salesPostDTO;
    private StockDTO stockDTO;
    private StockTransactionDTO stockTransactionDTO; 
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public String getFormattedCreatedDate() {
        if (createdDate != null) {
            return createdDate.format(formatter);
        }
        return "";
    }
    
}
