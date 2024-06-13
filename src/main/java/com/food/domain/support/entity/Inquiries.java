package com.food.domain.support.entity;

import java.time.LocalDateTime;

import com.food.domain.user.entity.Customer;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "INQUIRIES_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Inquiries {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "CUSTOMER_ID", nullable = false)
    private Customer customer;

    @Column(name = "SUBJECT", length = 255, nullable = false)
    private String subject;

    @Column(name = "TYPE", nullable = false)
    private Integer type;

    @Column(name = "SECRET", nullable = false)
    @Builder.Default
    private Integer secret = 1;

    @Lob
    @Column(name = "MESSAGE")
    private String message;

    @Column(name = "CREATED_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime createdDate;
}