package com.food.domain.sales.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewDTO {
    private Long id;
    private Long salesPostId;
    private Long userId;
    private Long rating;
    private String content;
    private LocalDateTime createdDate;
    private LocalDateTime uploadDate;
}
