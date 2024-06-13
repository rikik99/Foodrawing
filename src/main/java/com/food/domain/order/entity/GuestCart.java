package com.food.domain.order.entity;

import java.time.LocalDateTime;

import com.food.domain.product.entity.Product;

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
@Table(name = "GUEST_CART_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GuestCart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "IDENTIFIER", length = 255, nullable = false)
    private String identifier;

    @ManyToOne
    @JoinColumn(name = "PRODUCT_NUMBER", nullable = false)
    private Product product;

    @Column(name = "QUANTITY", nullable = false)
    private Long quantity;

    @Column(name = "LAST_DATE", nullable = false)
    @org.hibernate.annotations.UpdateTimestamp
    private LocalDateTime lastDate;
}