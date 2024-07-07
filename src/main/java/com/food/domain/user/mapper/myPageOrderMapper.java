package com.food.domain.user.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.user.dto.MyPageOrderDTO;

@Mapper
public interface myPageOrderMapper {
    List<MyPageOrderDTO> findOrdersByCustomerAndDateRange(
            @Param("customerId") Long customerId,
            @Param("startDate") Date startDate,
            @Param("endDate") Date endDate);
}
