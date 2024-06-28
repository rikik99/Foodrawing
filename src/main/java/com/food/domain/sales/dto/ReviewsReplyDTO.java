package com.food.domain.sales.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewsReplyDTO {
    private Long id;
    private Long reviewId;
    private Long adminId;
    private String message;
    private LocalDateTime createdDate;
    private LocalDateTime uploadDate;
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public String getFormattedCreatedDate() {
        if (createdDate != null) {
            return createdDate.format(formatter);
        }
        return "";
    }
}