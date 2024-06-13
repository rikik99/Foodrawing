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
public class CustomPageDTO {
    private String productNumber;
    private Long calorie;
    private Long protein;
    private Long fat;
    private Long transFat;
    private Long saturatedFat;
    private Long carbohydrate;
    private Long sugar;
    private Long sodium;
    private Long cholesterol;
    private Long weight;
    
    private String name;
    private String description;
    private Long price;
    private Long quantity;
    private LocalDateTime createdDate;

    private Long id;
    private String originalName;
    private String filePath;
    private String fileType;
    private LocalDateTime uploadDate;
}
