package com.food.domain.sales.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewsReplyDTO {
    private Long id;
    private Long reviewId;
    private Long userId;
    private String content;
    private LocalDateTime createdDate;
    private LocalDateTime uploadDate;
}