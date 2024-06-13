package com.food.domain.order.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "ORDER_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "IDENTIFIER_ID", length = 255, nullable = false)
    private String identifierId;

    @Column(name = "IDENTIFIER_TYPE", length = 10, nullable = false)
    private String identifierType;

    @Column(name = "ORDER_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime orderDate;

    @Column(name = "TOTAL_AMOUNT", nullable = false)
    private Long totalAmount;
}