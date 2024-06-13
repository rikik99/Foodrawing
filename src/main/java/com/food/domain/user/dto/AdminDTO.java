package com.food.domain.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminDTO {
	private Long id;
	private String name;
	private Long userId;
	private Long accessLevel;
}
