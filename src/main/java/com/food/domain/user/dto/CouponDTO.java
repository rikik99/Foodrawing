package com.food.domain.user.dto;



import java.sql.Timestamp;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CouponDTO {
    private Long id;
    private Long couponNumber;
    private String discountName;
    private Timestamp issuedAt;
    private String description;
    private String discountType;
    private Double discountValue;
    private Double maxDiscount;
}