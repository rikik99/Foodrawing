package com.food.domain.sales.entity;

import java.time.LocalDateTime;

import com.food.domain.product.entity.Product;
import com.food.domain.user.entity.Admin;

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
@Table(name = "SALES_POST_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SalesPost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "ADMIN_ID", nullable = false)
    private Admin admin;

    @ManyToOne
    @JoinColumn(name = "PRODUCT_NUMBER", nullable = false)
    private Product product;

    @Column(name = "TITLE", length = 255, nullable = false)
    private String title;

    @Column(name = "DESCRIPTION", length = 3000)
    private String description;

    @Column(name = "PRICE", nullable = false)
    private Long price;

    @Column(name = "STOCK", nullable = false)
    private Long stock;

    @Column(name = "CREATED_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime createdDate;

    @Column(name = "LAST_POST_DATE")
    private LocalDateTime lastPostDate;

    @Column(name = "UPDATED_DATE", nullable = false)
    @org.hibernate.annotations.UpdateTimestamp
    private LocalDateTime updatedDate;
}