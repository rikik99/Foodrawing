package com.food.domain.order.dto;

import com.food.domain.sales.dto.SalesPostDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetailDTO {
    private Long id;
    private Long orderId;
    private Long salesPostId;
    private Long unitPrice;
    private Long discountPrice;
    private Long quantity;
    
    private SalesPostDTO sales;
}