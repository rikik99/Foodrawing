package com.food.domain.user.mapper;

import com.food.domain.user.dto.CouponDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CouponMapper {
    List<CouponDTO> findAvailableCouponsByCustomerId(long customerId);
    int countAvailableCouponsByCustomerId(long customerId);
}
