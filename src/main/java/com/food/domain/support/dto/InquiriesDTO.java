package com.food.domain.support.dto;

import java.time.LocalDateTime;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.user.dto.CustomerDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InquiriesDTO {
    private Long id;
    private Long customerId;
    private String subject;
    private Long type;
    private Long secret;
    private String message;
    private LocalDateTime createdDate;
    private String resolvedYn;
    private Long salesPostId;
    private SalesPostDTO salesPotDTO;
    private ProductDTO productDTO;
    private CustomerDTO customerDTO;
    private ResponseDTO responseDTO;
}
