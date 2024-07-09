package com.food.domain.support.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.food.domain.product.dto.ProductDTO;
import com.food.domain.sales.dto.SalesPostDTO;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.UserDTO;
import com.food.domain.user.dto.UserDTO;

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
    private UserDTO userDTO;
    
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
    
	public String getFormattedCreatedDate() {
		if (createdDate != null) {
			return createdDate.format(formatter);
		}
		return "";
	}
    
}
