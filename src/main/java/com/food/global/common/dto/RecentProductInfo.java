package com.food.global.common.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecentProductInfo {
	private Long salesPostId;
	private String name;
	private String filePath;
	private int price;
}
