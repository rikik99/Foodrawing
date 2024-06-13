package com.food.domain.order.controller;

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
}