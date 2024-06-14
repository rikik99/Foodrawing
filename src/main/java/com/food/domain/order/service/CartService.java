package com.food.domain.order.service;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.food.domain.order.dto.CartDTO;
import com.food.domain.order.dto.CartRequestDTO;
import com.food.domain.order.dto.CartResponseDTO;
import com.food.domain.order.mapper.CartMapper;
import com.food.domain.product.dto.ProductDTO;
import com.food.domain.product.mapper.ProductMapper;
import com.food.domain.user.dto.CustomerDTO;
import com.food.domain.user.mapper.CustomerMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartMapper cartMapper;
    private final ProductMapper productMapper;
    private final CustomerMapper customerMapper;

    public CartResponseDTO checkStock(CartRequestDTO cartRequest) {
        ProductDTO product = productMapper.findById(cartRequest.getProductNumber());
        if (product == null) {
            return new CartResponseDTO(false, false, false);
        }

        if (product.getQuantity() < cartRequest.getQuantity()) {
            return new CartResponseDTO(false, false, false);
        }

        Optional<CartDTO> cartOptional = cartMapper.findByCustomerIdAndProductId(cartRequest.getCustomerId(), cartRequest.getProductNumber());
        if (cartOptional.isPresent()) {
            return new CartResponseDTO(true, true, true);
        } else {
            return new CartResponseDTO(true, true, false);
        }
    }

    public CartResponseDTO addToCart(CartRequestDTO cartRequest) {
        ProductDTO product = productMapper.findById(cartRequest.getProductNumber());
        if (product == null) {
            return new CartResponseDTO(false, false, false);
        }

        CustomerDTO customer = customerMapper.findById(cartRequest.getCustomerId());
        if (customer == null) {
            return new CartResponseDTO(false, false, false);
        }

        Optional<CartDTO> cartOptional = cartMapper.findByCustomerIdAndProductId(cartRequest.getCustomerId(), cartRequest.getProductNumber());
        if (cartOptional.isPresent()) {
            CartDTO cart = cartOptional.get();
            cart.setQuantity(cart.getQuantity() + cartRequest.getQuantity());
            cartMapper.updateCart(cart);
        } else {
            CartDTO cart = CartDTO.builder()
                .customerId(customer.getId())
                .productNumber(product.getProductNumber())
                .quantity((long) cartRequest.getQuantity())
                .lastDate(LocalDateTime.now())
                .build();
            cartMapper.insertCart(cart);
        }

        return new CartResponseDTO(true, true, true);
    }
}