package com.food.domain.order.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.order.dto.CartInfoDTO;

@Mapper
public interface OrderMapper {

	List<CartInfoDTO> findItemsByIds(List<String> productIds, Long customerId);

	List<CartInfoDTO> findAllItemsByCustomerId(Long customerId);

	List<CartInfoDTO> findItemsByIds(Map<String, Object> params);

	List<CartInfoDTO> findItem(String productNumber);

}
