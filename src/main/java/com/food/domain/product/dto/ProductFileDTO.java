package com.food.domain.product.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductFileDTO {
    private Long id;
    private String productNumber;
    private String originalName;
    private String filePath;
    private String fileType;
    private LocalDateTime uploadDate;
}
