package com.food.domain.product.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {
    private String productNumber;
    private String name;
    private String description;
    private Long price;
    private Long quantity;
    private LocalDateTime createdDate;
	public Object getId() {
		// TODO Auto-generated method stub
		return null;
	}
}
