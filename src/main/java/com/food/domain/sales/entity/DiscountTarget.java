package com.food.domain.sales.entity;

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
@Table(name = "DISCOUNT_TARGET_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiscountTarget {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "DISCOUNT_ID", nullable = false)
    private Discount discount;

    @Column(name = "TARGET_TYPE", length = 50, nullable = false)
    private String targetType;

    @Column(name = "TARGET_ID", nullable = false)
    private Long targetId;
}