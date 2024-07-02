package com.food.domain.user.service;

import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    public CustomerDTO getCustomerById(Long id) {
        return customerMapper.findById(id);
    }

    public void updateCustomer(CustomerDTO customer) {
        customerMapper.updateCustomer(customer);
    }

    public void deleteCustomer(Long id) {
        customerMapper.deleteCustomer(id);
    }
}
