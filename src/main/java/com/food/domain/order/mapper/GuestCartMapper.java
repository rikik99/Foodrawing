package com.food.domain.order.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.food.domain.order.dto.GuestCartDTO;

@Mapper
public interface GuestCartMapper {
    GuestCartDTO findByIdentifierAndProductNumber(@Param("identifier") String identifier, @Param("productNumber") String productNumber);
    void insertGuestCart(GuestCartDTO cart);
    void updateGuestCart(GuestCartDTO cart);
}