package com.food.domain.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuestDTO {
	private Long id;
	private String name;
	private String phone;
	private String email; 
	private String password; 
	private String address; 
	private String addressDetail;
	private String zipcode;
}
