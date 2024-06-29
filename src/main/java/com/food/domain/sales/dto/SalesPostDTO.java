package com.food.domain.sales.dto;

import java.time.LocalDateTime;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.user.dto.AdminDTO;

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
    private ProductDTO productDTO;
    private AdminDTO adminDTO;
}
