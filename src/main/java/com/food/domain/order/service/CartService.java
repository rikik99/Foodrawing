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
        ProductDTO product = productMapper.findById(cartRequest.getProductId());
        if (product == null || product.getQuantity() < cartRequest.getQuantity()) {
            return new CartResponseDTO(false, false, false);
        }

        Optional<CartDTO> cartOptional = cartMapper.findByCustomerIdAndProductId(cartRequest.getCustomerId(), cartRequest.getProductId());
        return cartOptional.isPresent() ? new CartResponseDTO(true, true, true) : new CartResponseDTO(true, true, false);
    }

    public CartResponseDTO addToCart(CartRequestDTO cartRequest) {
        ProductDTO product = productMapper.findById(cartRequest.getProductId());
        if (product == null) {
            return new CartResponseDTO(false, false, false);
        }

        CustomerDTO customer = customerMapper.findById(cartRequest.getCustomerId());
        if (customer == null) {
            return new CartResponseDTO(false, false, false);
        }

        Optional<CartDTO> cartOptional = cartMapper.findByCustomerIdAndProductId(cartRequest.getCustomerId(), cartRequest.getProductId());
        if (cartOptional.isPresent()) {
            CartDTO cart = cartOptional.get();
            cart.setQuantity(cart.getQuantity() + cartRequest.getQuantity());
            cartMapper.updateCart(cart);
        } else {
            CartDTO cart = CartDTO.builder()
                .customerId(customer.getId())
                .productId(product.getProductNumber())
                .quantity((long) cartRequest.getQuantity())
                .lastDate(LocalDateTime.now())
                .build();
            cartMapper.insertCart(cart);
        }

        return new CartResponseDTO(true, true, true);
    }

    public CartResponseDTO updateCartItem(CartRequestDTO cartRequest) {
        Optional<CartDTO> cartOptional = cartMapper.findByCustomerIdAndProductId(cartRequest.getCustomerId(), cartRequest.getProductId());
        if (cartOptional.isPresent()) {
            CartDTO cart = cartOptional.get();
            cart.setQuantity((long) cartRequest.getQuantity());
            cart.setLastDate(LocalDateTime.now());
            cartMapper.updateCart(cart);
            return new CartResponseDTO(true, true, true);
        } else {
            return new CartResponseDTO(false, false, false);
        }
    }

    public void deleteCartItem(CartRequestDTO cartRequest) {
        cartMapper.deleteByCustomerIdAndProductId(cartRequest.getCustomerId(), cartRequest.getProductId());
    }

    public void checkoutSelectedItems(CartRequestDTO cartRequest) {
        // 선택된 아이템을 주문 처리하는 로직 구현
        for (Long productId : cartRequest.getProductIds()) {
            cartMapper.deleteByCustomerIdAndProductId(cartRequest.getCustomerId(), productId);
        }
    }
}
