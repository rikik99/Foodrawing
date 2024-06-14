package com.food.domain.order.entity;

import java.time.LocalDateTime;

import com.food.domain.product.entity.Product;
import com.food.domain.user.entity.Customer;

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
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "CART_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "CUSTOMER_ID", nullable = false)
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "PRODUCT_NUMBER", nullable = false)
    private Product product;

    @Column(name = "QUANTITY", nullable = false)
    private Long quantity;

    @Column(name = "LAST_DATE", nullable = false)
    @org.hibernate.annotations.UpdateTimestamp
    private LocalDateTime lastDate;
}
