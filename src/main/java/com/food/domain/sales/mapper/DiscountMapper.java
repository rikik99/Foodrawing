package com.food.domain.sales.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.sales.dto.Discount2DTO;
import com.food.domain.sales.dto.DiscountDTO;
import com.food.domain.sales.dto.DiscountTargetDTO;

@Mapper
public interface DiscountMapper {

	DiscountTargetDTO getCategroyTargetDiscount(int i);

	DiscountDTO getDiscount(Long discountId);

	DiscountTargetDTO getProductTargetDiscount(String productNumber);

	List<Discount2DTO> findCategoryTargetDiscountQuery(Long categoryId);

	List<Discount2DTO> findProductTargetDiscountQuery(Long productId);

	List<Discount2DTO> findDiscountProductsQuery();

	Discount2DTO findDiscountByIdQuery(Long id);

}
