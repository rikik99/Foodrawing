package com.food.domain.user.dto;

import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomerReservesDTO {
	private Long id;
	private Long customerId;
	private BigDecimal reserves;
	private Long orderId;
	private Date creditDate;
	private String plusminus;
}
