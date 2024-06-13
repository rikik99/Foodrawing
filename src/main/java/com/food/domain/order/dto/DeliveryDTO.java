package com.food.domain.order.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DeliveryDTO {
    private Long id;
    private Long orderId;
    private String deliveryStatus;
    private LocalDateTime deliveryStartDate;
    private LocalDate estimatedArrivalDate;
    private String carrier;
    private String trackingNumber;
    private String recipientName;
    private String recipientPhone;
    private String recipientAddress;
    private String recipientAddressDetail;
    private String recipientZipcode;
    private String deliveryComment;
    private String apartmentPassword;
}
