package com.food.domain.order.entity;

import com.food.domain.sales.entity.SalesPost;

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
@Table(name = "ORDER_DETAIL_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "ORDER_ID", nullable = false)
    private Order order;

    @ManyToOne
    @JoinColumn(name = "SALES_POST_ID", nullable = false)
    private SalesPost salesPost;

    @Column(name = "UNIT_PRICE", nullable = false)
    private Long unitPrice;

    @Column(name = "DISCOUNT_PRICE")
    private Long discountPrice;

    @Column(name = "QUANTITY", nullable = false)
    private Long quantity;
}