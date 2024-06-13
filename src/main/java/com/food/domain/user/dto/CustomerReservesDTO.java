package com.food.domain.user.dto;

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
	private Long reserves;
	private Long orderId;
	private Date creditDate;
}
