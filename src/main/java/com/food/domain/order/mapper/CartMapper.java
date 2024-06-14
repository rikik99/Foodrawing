package com.food.domain.order.mapper;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.order.dto.CartDTO;
import com.food.domain.order.dto.CartInfoDTO;

@Mapper
public interface CartMapper {
	Optional<CartDTO> findByCustomerIdAndProductId(@Param("customerId") Long customerId, @Param("productNumber") String productNumber);

    void insertCart(CartDTO cart);

    void updateCart(CartDTO cart);

	List<CartInfoDTO> getCartListByCustomerId(Long id);
}