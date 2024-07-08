package com.food.domain.sales.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.food.domain.user.dto.CustomerDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CouponIssuanceDTO {
	private Long id;
	private Long discountId;
	private Long customerId;
	private Long couponNumber;
	private LocalDateTime issuedAt;
	private String usedYn;
	private String username;
	private DiscountDTO discountDTO;
	private CustomerDTO customerDTO;	
	private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YY.MM.dd");

	public String getFormattedIssuedAt() {
		if (issuedAt != null) {
			return issuedAt.format(formatter);
		}
		return "";
	}

}
