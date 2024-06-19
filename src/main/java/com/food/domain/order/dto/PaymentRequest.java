package com.food.domain.order.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentRequest {
    private Long id;
    private String identifierId;
    private String identifierType;
    private LocalDateTime orderDate;
    private BigDecimal totalAmount;
    private String orderNumber;
    private String paymentMethod;
    private List<OrderDetailRequest> orderDetails;

}