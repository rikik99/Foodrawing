package com.food.global.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.global.common.mapper.GlobalCartMapper;

@Service
public class GlobalCartService {
	@Autowired
	GlobalCartMapper cartMapper;
	
	public int getCartItemCount() {
		int count = cartMapper.getCartItemCount();
		return count;
	}

}
