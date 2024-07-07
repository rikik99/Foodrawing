package com.food.domain.user.dto;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.food.domain.order.dto.OrderDTO;
import com.food.domain.sales.dto.CouponIssuanceDTO;
import com.food.domain.support.dto.InquiriesDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomerDTO {
	private Long id;
	private Long userId;
	private String nickname;
	private String name;
	private String gender;
	private String phone;
	private String email;
	private Date birthDate;
	private String address;
	private String addressDetail;
	private String zipcode;
	private String refundAccount;
	private String refundBank;

	private UserDTO userDTO;
	private MemberRatingDTO member;
	private List<CouponIssuanceDTO> couponIssuances;
	private List<OrderDTO> orders;
	private List<InquiriesDTO> Inquiries;
	private Long totalOrderAmount;
	private Long totalReserves;

	public String getFormattedBirthDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		return birthDate != null ? sdf.format(birthDate) : "";
	}

	public Date getBirthDate() {
		return birthDate != null ? birthDate : new Date(); // 기본값 설정, 필요에 따라 변경
	}
}
