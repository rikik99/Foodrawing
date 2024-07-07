package com.food.domain.product.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.food.domain.product.mapper.WishListMapper;

@Service
public class WishListService {

	@Autowired
	private WishListMapper wishListMapper;

	public boolean addProductToWishlist(Long customerId, Long salesPostId) {
		return wishListMapper.insertWish(customerId, salesPostId);
	}

	public boolean removeProductFromWishlist(Long customerId, Long salesPostId) {
		return wishListMapper.deleteWish(customerId, salesPostId);
	}

	public boolean isWished(Long salesPostId, Long customerId) {
		return wishListMapper.isWished(salesPostId, customerId);
	}

}
