package com.food.domain.order.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CheckoutRequestDTO {
    private Long customerId;
    private String guestId;
    private List<String> productNumbers;
}