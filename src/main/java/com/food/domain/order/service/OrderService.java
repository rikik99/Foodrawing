package com.food.domain.order.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.food.domain.order.dto.CartInfoDTO;
import com.food.domain.order.mapper.OrderMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderMapper orderMapper;
    

    public List<CartInfoDTO> getSelectedItems(List<String> productIds, Long customerId) {
        return orderMapper.findItemsByIds(productIds, customerId);
    }

    public List<CartInfoDTO> getAllItems(Long customerId) {
        return orderMapper.findAllItemsByCustomerId(customerId);
    }

    public List<CartInfoDTO> getProduct(String productNumber, int quantity) {
        return orderMapper.findItem(productNumber);
    }

}
