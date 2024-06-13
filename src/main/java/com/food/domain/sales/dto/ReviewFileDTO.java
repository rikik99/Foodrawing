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
public class ReviewFileDTO {
    private Long id;
    private Long reviewId;
    private String originalName;
    private String filePath;
    private String fileType;
    private LocalDateTime uploadDate;
}
