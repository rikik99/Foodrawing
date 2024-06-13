package com.food.domain.support.entity;

import java.time.LocalDateTime;

import com.food.domain.user.entity.Admin;

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
@Table(name = "RESPONSE_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Response {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "INQUIRIES_ID", nullable = false)
    private Inquiries inquiries;

    @ManyToOne
    @JoinColumn(name = "ADMIN_ID", nullable = false)
    private Admin admin;

    @Lob
    @Column(name = "MESSAGE")
    private String message;

    @Column(name = "CREATED_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime createdDate;

    @Column(name = "RESOLVED_YN", length = 1, nullable = false)
    @Builder.Default
    private String resolvedYn = "N";

    @Column(name = "RESOLVED_DATE")
    private LocalDateTime resolvedDate;
}