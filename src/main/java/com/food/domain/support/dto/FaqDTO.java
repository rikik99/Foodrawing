package com.food.domain.support.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FaqDTO {
	private Long id;
	private Long type;
	private String question;
	private String answer;
}
