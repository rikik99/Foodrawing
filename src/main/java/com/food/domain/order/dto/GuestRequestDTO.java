package com.food.domain.order.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuestRequestDTO {
	private String guestId;
    private String productNumber; // 단일 제품의 경우 사용
    private int quantity;
    private List<String> productNumbers; // 선택된 여러 항목의 경우 사용
}
