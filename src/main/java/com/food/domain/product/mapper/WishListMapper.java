package com.food.domain.product.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WishListMapper {

	boolean insertWish(Long customerId, Long salesPostId);

	boolean deleteWish(Long customerId, Long salesPostId);

}
