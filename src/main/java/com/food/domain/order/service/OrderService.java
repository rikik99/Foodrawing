package com.food.domain.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.mapper.OrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderMapper orderMapper;

    public List<CartInfoDTO> getSelectedItems(List<String> productIds, Long customerId) {
        Map<String, Object> params = new HashMap<>();
        params.put("productIds", productIds);
        params.put("customerId", customerId);

        return orderMapper.findItemsByIds(params);
    }

    public List<CartInfoDTO> getAllItems(Long customerId) {
        return orderMapper.findAllItemsByCustomerId(customerId);
    }
}
