package com.food.domain.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.food.domain.product.dto.BestDTO;

@Mapper
public interface BestMapper {
    List<BestDTO> selectBestSellingProducts();
}
