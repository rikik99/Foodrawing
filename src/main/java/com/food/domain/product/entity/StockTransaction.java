package com.food.domain.product.entity;

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
@Table(name = "STOCK_TRANSACTION_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StockTransaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "PRODUCT_NUMBER", nullable = false)
    private Product product;

    @Column(name = "TRANSACTION_TYPE", length = 3, nullable = false)
    private String transactionType;

    @Column(name = "QUANTITY", nullable = false)
    private Long quantity;

    @Column(name = "TRANSACTION_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime transactionDate;

    @Column(name = "EXPIRATION_DATE")
    private LocalDateTime expirationDate;
}