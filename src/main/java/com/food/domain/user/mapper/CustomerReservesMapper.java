package com.food.domain.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.food.domain.user.dto.CustomerReservesDTO;

import java.util.List;

@Mapper
public interface CustomerReservesMapper {
    List<CustomerReservesDTO> findTotalReservesByCustomerId(long customerId);
}
