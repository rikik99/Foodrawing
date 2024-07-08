package com.food.domain.user.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MyPageOrderDTO {
    private Long orderId;
    private Date orderDate;
    private String orderStatus;
    private Double totalAmount;
    private Double unitPrice;
    private Double discountPrice;
    private Integer quantity;
    private String deliveryStatus;
    private String carrier;
    private String trackingNumber;
    private Date estimatedArrivalDate;
}
