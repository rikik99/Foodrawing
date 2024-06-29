package com.food.domain.order.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.food.domain.sales.dto.DiscountDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentRequest {
	private Long customerId;
	private String customerName;
	private String deliverName;
	private String customerPhone;
	private String deliverPhone;

	// 쿠폰 추가 해야함

	private BigDecimal discount;
	private BigDecimal totalAmount;
	private BigDecimal finalPrice;
	private String paymentMethod;

	private OrderDTO order;

	private DeliveryDTO delivery;

	private List<DiscountDTO> discountDetails;
	private List<OrderDetailDTO> orderDetails;

}