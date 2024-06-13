package com.food.domain.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductNutritionDTO {
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

}
