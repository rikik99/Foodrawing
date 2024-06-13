package com.food.domain.sales.entity;

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
@Table(name = "DISCOUNT_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Discount {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "ONSALE_YN", length = 1, nullable = false)
    @Builder.Default
    private String onsaleYn = "N";

    @Column(name = "NAME", length = 100, nullable = false)
    private String name;

    @Column(name = "TYPE", length = 50, nullable = false)
    private String type;

    @Column(name = "START_DATE", nullable = false)
    private LocalDateTime startDate;

    @Column(name = "END_DATE", nullable = false)
    private LocalDateTime endDate;

    @Column(name = "DISCOUNT_TYPE", length = 1, nullable = false)
    private String discountType;

    @Column(name = "DISCOUNT_VALUE", nullable = false)
    private Long discountValue;

    @Column(name = "MAX_DISCOUNT")
    private Long maxDiscount;

    @Column(name = "DESCRIPTION", length = 255)
    private String description;

    @Column(name = "MIN_PRICE", nullable = false)
    private Long minPrice;
}