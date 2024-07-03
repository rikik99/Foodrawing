package com.food.domain.sales.dto;

import java.time.LocalDateTime;

import com.food.domain.support.dto.ResponseDTO;
import com.food.domain.user.dto.CustomerDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductInquiryDTO {
	private Long id;
    private Long salesPostId;
    private Long customerId;
    private String subject;
    private String message;
    private String resolvedYn;
    private String secret;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private ResponseDTO responses; // 상품 문의 답변 리스트
    private CustomerDTO customer;
}
