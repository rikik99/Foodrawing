package com.food.domain.user.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.order.dto.OrderStatusDTO;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.dto.CustomerReservesDTO;
import com.food.domain.user.dto.MyPageOrderDTO;
import com.food.domain.user.mapper.CustomerMapper;
import com.food.domain.user.mapper.CustomerReservesMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private CustomerReservesMapper customerReservesMapper;

    public CustomerDTO getCustomerById(Long id) {
        return customerMapper.findById(id);
    }

    public void updateCustomer(CustomerDTO customer) {
        customerMapper.updateCustomer(customer);
    }

    public void deleteCustomer(Long id) {
        customerMapper.deleteCustomer(id);
    }

    public CustomerDTO findCustomerByUserId(Long userId) {
        return customerMapper.findCustomerByUserId(userId);
    }

    public List<MyPageOrderDTO> getOrderHistory(String customerId, Date startDate, Date endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("customerId", customerId);
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        log.debug("Fetching orders with params: {}", params);
        List<MyPageOrderDTO> orders = customerMapper.findOrdersByCustomerAndDateRange(params);
        log.debug("Orders retrieved from mapper: {}", orders);
        return orders;
    }

    public void updateCancelOrderStatus(Long orderId, String status) {
        OrderStatusDTO orderStatusDTO = OrderStatusDTO.builder()
                .orderId(orderId)
                .orderStatus(status)
                .build();
        customerMapper.updateCancelOrderStatus(orderStatusDTO);
    }

    public int getCustomerReserves(Long customerId) {
        List<CustomerReservesDTO> reservesList = customerReservesMapper.findTotalReservesByCustomerId(customerId);
        int totalReserves = 0;
        for (CustomerReservesDTO reserve : reservesList) {
            if ("+".equals(reserve.getPlusminus())) {
                totalReserves += reserve.getReserves();
            } else {
                totalReserves -= reserve.getReserves();
            }
        }
        return totalReserves;
    }

}
