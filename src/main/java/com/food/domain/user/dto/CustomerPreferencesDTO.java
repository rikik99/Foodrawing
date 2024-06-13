package com.food.domain.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomerPreferencesDTO {
	private Long id;
	private Long customerId;
	private Long productCategoryId;
}
