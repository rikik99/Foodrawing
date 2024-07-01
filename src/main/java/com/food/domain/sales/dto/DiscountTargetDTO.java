package com.food.domain.sales.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiscountTargetDTO {
    private Long id;
    private Long discountId;
    private String targetType;
    private String targetId;
    private String targetName;
    private Object target;
}