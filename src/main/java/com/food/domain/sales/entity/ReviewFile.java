package com.food.domain.sales.entity;

import java.time.LocalDateTime;

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
@Table(name = "REVIEW_FILE_TB")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewFile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "REVIEW_ID", nullable = false)
    private Review review;

    @Column(name = "ORIGINAL_NAME", length = 255)
    private String originalName;

    @Column(name = "FILE_PATH", length = 255)
    private String filePath;

    @Column(name = "FILE_TYPE", length = 50)
    private String fileType;

    @Column(name = "UPLOAD_DATE", nullable = false, updatable = false)
    @org.hibernate.annotations.CreationTimestamp
    private LocalDateTime uploadDate;
}