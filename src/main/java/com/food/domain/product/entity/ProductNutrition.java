package com.food.domain.product.entity;

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
@Table(name = "PRODUCT_NUTRITION_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductNutrition {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "CALORIE")
    private Long calorie;

    @Column(name = "PROTEIN")
    private Long protein;

    @Column(name = "FAT")
    private Long fat;

    @Column(name = "TRANS_FAT")
    private Long transFat;

    @Column(name = "SATURATED_FAT")
    private Long saturatedFat;

    @Column(name = "CARBOHYDRATE")
    private Long carbohydrate;

    @Column(name = "SUGAR")
    private Long sugar;

    @Column(name = "SODIUM")
    private Long sodium;

    @Column(name = "CHOLESTEROL")
    private Long cholesterol;

    @Column(name = "WEIGHT")
    private Long weight;

    @ManyToOne
    @JoinColumn(name = "PRODUCT_NUMBER", nullable = false)
    private Product product;
}