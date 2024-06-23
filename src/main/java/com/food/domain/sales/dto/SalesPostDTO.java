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
public class SalesPostDTO {
    private Long id;
    private Long adminId;
    private String productNumber;
    private String title;
    private String description;
    private Long price;
    private Long stock;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private LocalDateTime startPostDate;
    private LocalDateTime lastPostDate;
    private Long status;
}
