package com.food.domain.sales.entity;

import java.time.LocalDateTime;

import com.food.domain.user.entity.User;

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
@Table(name = "REVIEWS_REPLY_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewsReply {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "REVIEW_ID", nullable = false)
    private Review review;

    @ManyToOne
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;

    @Lob
    @Column(name = "CONTENT")
    private String content;

    @Column(name = "CREATED_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime createdDate;

    @Column(name = "UPLOAD_DATE", nullable = false)
    @org.hibernate.annotations.UpdateTimestamp
    private LocalDateTime uploadDate;
}