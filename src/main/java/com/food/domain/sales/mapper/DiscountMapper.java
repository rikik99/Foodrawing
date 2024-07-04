package com.food.domain.sales.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountTargetDTO;

@Mapper
public interface DiscountMapper {

	DiscountTargetDTO getCategroyTargetDiscount(int i);

	DiscountDTO getDiscount(Long discountId);

	DiscountTargetDTO getProductTargetDiscount(String productNumber);

}
