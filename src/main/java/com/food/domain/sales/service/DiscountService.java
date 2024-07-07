package com.food.domain.sales.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.sales.dto.Discount2DTO;
import com.food.domain.sales.mapper.DiscountMapper;

@Service
public class DiscountService {

    @Autowired
    private DiscountMapper discountMapper;

    public Discount2DTO getDiscountById(Long id) {
        return discountMapper.findDiscountById(id);
    }

    public List<Discount2DTO> getCategoryTargetDiscount(Long categoryId) {
        return discountMapper.findCategoryTargetDiscount(categoryId);
    }

    public List<Discount2DTO> getProductTargetDiscount(Long productId) {
        return discountMapper.findProductTargetDiscount(productId);
    }
    public List<Discount2DTO> getDiscountProducts() {
        List<Discount2DTO> discountProducts = discountMapper.findDiscountProducts();
        for (Discount2DTO product : discountProducts) {
            double discountedPrice = product.getOriginalPrice() * (1 - (product.getDiscountValue() / 100.0));
            product.setDiscountedPrice(discountedPrice);
        }
        return discountProducts;
    
}
}
