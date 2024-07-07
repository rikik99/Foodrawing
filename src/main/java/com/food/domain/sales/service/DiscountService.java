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
		return discountMapper.findDiscountByIdQuery(id);
	}

	public List<Discount2DTO> getCategoryTargetDiscount(Long categoryId) {
		return discountMapper.findCategoryTargetDiscountQuery(categoryId);
	}

	public List<Discount2DTO> getProductTargetDiscount(Long productId) {
		return discountMapper.findProductTargetDiscountQuery(productId);
	}

	public List<Discount2DTO> getDiscountProducts() {
		List<Discount2DTO> discountProducts = discountMapper.findDiscountProductsQuery();
		for (Discount2DTO product : discountProducts) {
			double discountedPrice = product.getOriginalPrice() * (1 - (product.getDiscountValue() / 100.0));
			product.setDiscountedPrice(discountedPrice);
		}
		
		System.out.println("discountProducts: " + discountProducts);
		
		return discountProducts;

	}
}
