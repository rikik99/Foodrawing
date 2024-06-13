package com.food.domain.user.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.user.dto.CustomerDTO;

@Mapper
public interface CustomerMapper {
	CustomerDTO findById(Long id);
	void insertCustomer(CustomerDTO customerDTO);

	CustomerDTO findCustomerByEmail(String email);

	CustomerDTO findCustomerById(Long userId);
}
