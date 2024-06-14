package com.food.domain.order.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CartResponseDTO {
    private boolean success;
    private boolean stockAvailable;
    private boolean inCart;
}