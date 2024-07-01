package com.food.domain.product.controller;

import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.product.service.WishListService;

@RestController
@RequestMapping("/wishlist")
public class WishListRestController {

    @Autowired
    private WishListService wishListService;

    @PostMapping("/add")
    public ResponseEntity<?> addToWishlist(@RequestBody Map<String, Object> payload) {
        Long salesPostId = Long.valueOf(payload.get("salesPostId").toString());
        Long customerId = Long.valueOf(payload.get("customerId").toString());

        boolean success = wishListService.addProductToWishlist(customerId, salesPostId);

        return ResponseEntity.ok(Collections.singletonMap("success", success));
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeFromWishlist(@RequestBody Map<String, Object> payload) {
        Long salesPostId = Long.valueOf(payload.get("salesPostId").toString());
        Long customerId = Long.valueOf(payload.get("customerId").toString());

        boolean success = wishListService.removeProductFromWishlist(customerId, salesPostId);

        return ResponseEntity.ok(Collections.singletonMap("success", success));
    }
}