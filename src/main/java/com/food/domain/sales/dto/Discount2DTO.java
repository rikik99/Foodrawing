package com.food.domain.sales.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Discount2DTO {
    private Long id;
    private String onSaleYn;
    private String name;
    private String type;
    private Date startDate;
    private Date endDate;
    private String discountType;
    private int discountValue;
    private int maxDiscount;
    private String description;
    private int minPrice;
    private String productName;
    private String productDescription;
    private int originalPrice;
    private double discountedPrice; 
    private String productFilePath; // 새 필드 추가
}
