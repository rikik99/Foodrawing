package com.food.domain.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.product.dto.BestDTO;
import com.food.domain.product.mapper.BestMapper;

@Service
public class BestService {

    private final BestMapper bestMapper;

    @Autowired
    public BestService(BestMapper bestMapper) {
        this.bestMapper = bestMapper;
    }

    public List<BestDTO> getBestSellingProducts() {
        return bestMapper.selectBestSellingProducts();
    }
}
