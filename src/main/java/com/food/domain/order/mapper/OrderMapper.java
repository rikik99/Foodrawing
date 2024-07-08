package com.food.domain.order.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.dto.OrderDTO;
import com.food.domain.user.dto.MyPageOrderDTO;

@Mapper
public interface OrderMapper {

    List<CartInfoDTO> findItemsByIds(List<String> productIds, Long customerId);

    List<CartInfoDTO> findAllItemsByCustomerId(Long customerId);

    List<CartInfoDTO> findItemsByIds(Map<String, Object> params);

    List<CartInfoDTO> findItem(String productNumber);

    List<OrderDTO> updateCancelOrderStatus(Long customerId);
    
    
}
