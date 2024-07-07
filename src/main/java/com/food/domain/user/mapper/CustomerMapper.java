package com.food.domain.user.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.order.dto.OrderDTO;
import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.MyPageOrderDTO;

@Mapper
public interface CustomerMapper {
    CustomerDTO findById(Long id);

    void insertCustomer(CustomerDTO customer);

    CustomerDTO findCustomerByEmail(String email);

    CustomerDTO findCustomerById(Long userId);

    void updateCustomer(CustomerDTO customer);

    void deleteCustomer(Long id);

    CustomerDTO findCustomerByUserId(Long userId);

    List<MyPageOrderDTO> findOrdersByCustomerAndDateRange(Map<String, Object> params);

    void updateCancelOrderStatus(OrderStatusDTO orderStatusDTO);
}
