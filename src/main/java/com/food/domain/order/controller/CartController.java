package com.food.domain.order.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.food.domain.order.dto.CartRequestDTO;
import com.food.domain.order.dto.CartResponseDTO;
import com.food.domain.order.service.CartService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @PostMapping("/checkStock")
    public ResponseEntity<CartResponseDTO> checkStock(@RequestBody CartRequestDTO cartRequest) {
        try {
            CartResponseDTO response = cartService.checkStock(cartRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new CartResponseDTO(false, false, false));
        }
    }

    @PostMapping("/addToCart")
    public ResponseEntity<CartResponseDTO> addToCart(@RequestBody CartRequestDTO cartRequest) {
        try {
            CartResponseDTO response = cartService.addToCart(cartRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new CartResponseDTO(false, false, false));
        }
    }

    @PostMapping("/updateCartItem")
    public ResponseEntity<CartResponseDTO> updateCartItem(@RequestBody CartRequestDTO cartRequest) {
        try {
            CartResponseDTO response = cartService.updateCartItem(cartRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new CartResponseDTO(false, false, false));
        }
    }

    @PostMapping("/deleteCartItem")
    public ResponseEntity<Map<String, Object>> deleteCartItem(@RequestBody CartRequestDTO cartRequest) {
        try {
            cartService.deleteCartItem(cartRequest);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "Internal server error");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }


    @PostMapping("/deleteSelectedItems")
    public ResponseEntity<Void> deleteSelectedItems(@RequestBody CartRequestDTO cartRequest) {
        try {
            cartService.deleteSelectedItems(cartRequest);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
