package com.food.domain.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.mapper.CustomerMapper;

@Service
public class CustomerService {
	
	@Autowired
	private CustomerMapper customerMapper;

	public CustomerDTO findCustomerByUserId(Long userId) {
        return customerMapper.findCustomerById(userId);
    }

}
