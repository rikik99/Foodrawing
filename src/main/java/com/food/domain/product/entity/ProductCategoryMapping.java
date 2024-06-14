package com.food.domain.product.entity;

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
@Table(name = "PRODUCT_CATEGORY_MAPPING_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductCategoryMapping {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "PRODUCT_NUMBER", nullable = false)
    private Product product;

    @ManyToOne
    @JoinColumn(name = "CATEGORY_ID", nullable = false)
    private ProductCategory category;
}