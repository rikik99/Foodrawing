package com.food.domain.user.entity;

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
@Table(name = "MEMBER_RATING_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberRating {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "RATING", length = 50, nullable = false)
    private String rating;

    @Column(name = "MIN_AMOUNT", nullable = false)
    private Long minAmount;

    @Column(name = "MAX_AMOUNT", nullable = false)
    private Long maxAmount;
}