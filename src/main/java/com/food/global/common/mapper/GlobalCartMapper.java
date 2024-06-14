package com.food.global.common.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GlobalCartMapper {

	int getCartItemCount();

}
