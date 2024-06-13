package com.food.domain.order.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "DELIVERY_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Delivery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "ORDER_ID", nullable = false)
    private Order order;

    @Column(name = "DELIVERY_STATUS", length = 50, nullable = false)
    private String deliveryStatus;

    @Column(name = "DELIVERY_START_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime deliveryStartDate;

    @Column(name = "ESTIMATED_ARRIVAL_DATE")
    private LocalDate estimatedArrivalDate;

    @Column(name = "CARRIER", length = 255)
    private String carrier;

    @Column(name = "TRACKING_NUMBER", length = 255)
    private String trackingNumber;

    @Column(name = "RECIPIENT_NAME", length = 255)
    private String recipientName;

    @Column(name = "RECIPIENT_PHONE", length = 15)
    private String recipientPhone;

    @Column(name = "RECIPIENT_ADDRESS", length = 255)
    private String recipientAddress;

    @Column(name = "RECIPIENT_ADDRESS_DETAIL", length = 255)
    private String recipientAddressDetail;

    @Column(name = "RECIPIENT_ZIPCODE", length = 10)
    private String recipientZipcode;

    @Column(name = "DELIVERY_COMMENT", length = 255)
    private String deliveryComment;

    @Column(name = "APARTMENT_PASSWORD", length = 50)
    private String apartmentPassword;
}