package com.food.domain.order.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuestCartResponseDTO {
	private boolean success;
    private boolean stockAvailable;
    private boolean inCart;
}
