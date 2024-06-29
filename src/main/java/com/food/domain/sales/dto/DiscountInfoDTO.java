package com.food.domain.sales.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DiscountInfoDTO {
	private DiscountTargetDTO discountTargetDTO;
	private DiscountDTO discountDTO;
}
