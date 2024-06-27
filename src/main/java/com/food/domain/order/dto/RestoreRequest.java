package com.food.domain.order.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RestoreRequest {
	Long OrderNumber;
	List<String> productNumbers;
	List<String> quantities;
}
