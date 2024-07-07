package com.food.domain.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.user.dto.CouponDTO;
import com.food.domain.user.mapper.CouponMapper;

@Service
public class CouponService {

    @Autowired
    private CouponMapper couponMapper;

    public List<CouponDTO> getAvailableCoupons(Long customerId) {
        return couponMapper.findAvailableCouponsByCustomerId(customerId);
    }

    public int getAvailableCouponCount(Long customerId) {
        return couponMapper.countAvailableCouponsByCustomerId(customerId);
    }
}
